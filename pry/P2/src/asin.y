%{
#include <stdio.h>
#include <string.h>
#include "header.h"
#include "libtds.h"
%}

%union {
    char* ident;            // Para el terminal "identificador"
    int cent;               // Para el terminal "cte" entera
    int aux;                // Para los no terminales con atributo simbple
    EXPR expre;             // Para los no terminales expresion
}


%token WHILE_ FOR_ IF_ ELSE_ TRUE_ FALSE_ PRINT_ READ_ RETURN_ INT_ BOOL_
%token ALLAVE_  CLLAVE_ ACORCH_  CCORCH_ APAREN_ CPAREN_ PTOCOMA_ PTO_ CMA_
%token MAS_ MENOS_ POR_ DIV_
%token AND_ OR_ SUMASIG_ RESASIG_ MULASIG_ DIVASIG_ IGUAL_ NOIGUAL_ MAYIGUAL_ MENIGUAL_ INC_ DEC_  MAY_ MEN_ ASIG_ NOT_ MOD_

%token <cent> CTE_
%token <ident> ID_
%token <cent> INT_ BOOL_


%type <aux> tipoSimple listaParametrosFormales parametrosFormales
%type <aux> operadorUnario operadorLogico operadorMultiplicativo
%type <aux> operadorIgualdad operadorRelacional operadorIncremento operadorAditivo


%type <expre> expresionOpcional expresion expresionIgualdad expresionRelacional expresionAditiva expresionMultiplicativa
%type <expre> expresionUnaria expresionSufija constante listaDeclaraciones declaracion


// ∆ = primera posición libre en el segmento de datos. n = nivel del bloque actual.
// ∆ = dvar y n = niv
// Nuestro nivel de anidamiento es solo local o global

%%
programa                        :// Pseudocódigo diapos P ⇒ LD ==> n = 0; ∆ = 0;
                                { niv = GLOBAL; dvar = 0; cargaContexto(niv);}
                                listaDeclaraciones
                                    {
                                        if ($2.valor == 0) yyerror("El programa no tiene main");
                                    }
                                ;

listaDeclaraciones              : declaracion
                                    {
                                        $$ = $1;
                                    }
                                | listaDeclaraciones declaracion
                                    // {
                                    //     if ($1 == 0)    $$ = $2;
                                    //     else if ($2 == 0)   $$ = $1;
                                    //     else yyerror("El programa tiene mas de un main");
                                    // }
                                ;

declaracion                     : declaracionVariable
                                // Pseudocódigo diapos D ⇒ DV ==> insTdS(DV.n, “variable-global”, DV.t, n, ∆); ∆ = ∆ + DV.talla;
                                | declaracionFuncion
                                ;

declaracionVariable             : tipoSimple ID_ PTOCOMA_
                                // Pseudocódigo diapos DV ⇒ T id ==> DV.n = id.n; DV.t = T.t; DV.talla = T.talla;
                                    {
                                        if (insTdS($2, VARIABLE, $1, niv, dvar, -1) == 0) {
                                            yyerror("Error en declaracionVariable, variable ya declarada");
                                        } else {
                                            dvar += TALLA_TIPO_SIMPLE;
                                        }
                                    }
                                | tipoSimple ID_ ACORCH_ CTE_ CCORCH_ PTOCOMA_
                                // Pseudocódigo diapos DV ⇒ T id [ cte ] ==> si ¬[ cte.t = tentero ∧ cte.num > 0 ] MenError(.)
                                // sino DV.n = id.n; DV.t = tvector(cte.num, T.t);
                                // DV.talla = cte.num ∗ T.talla;
                                    {
                                        int nelem = $4;
                                        if($4 <= 0) {
                                            yyerror("Error en declaracionVariable, talla < 1");
                                            nelem = 0;
                                        }

                                        int ref = insTdA($1, nelem);
                                        if( !insTdS($2, VARIABLE, T_ARRAY, niv, dvar, ref) )
                                            yyerror("Error en declaracionVariable, variable ya definida");
                                        else dvar += nelem * TALLA_TIPO_SIMPLE;
                                    }
                                ;

tipoSimple                      : INT_
                                // Pseudocódigo diapos T ⇒ int ==> T.t = tentero; T.talla = Talla-Entero;
                                    {
                                        $$ = T_ENTERO;
                                    }
                                | BOOL_
                                // Pseudocódigo diapos T ⇒ bool ==> T.t = tlogico; T.talla = Talla-Lógico;
                                    {
                                        $$ = T_LOGICO;
                                    }
                                ;

// He visto que hay una declaracion que es básicamente la declaracionFuncion, cabeceraFuncion y bloque juntas
// D ⇒ T id ( PF ) { DL LI }, así es como lo pone en pseudocódigo ==>

// n++; cargaCont(n); D.aux = ∆; ∆ = 0;
// insTdS(id.n, “función”, tfunción(PF.t, T.t, PF.talla), n-1, ◁);
// descargaCont(n); n−−; ∆ = D.aux;

// IMPORTANTE estás declaraciones han de seguir un orden especial se ve en video
// web.microsoftstream.com/video/a90621b6-23ec-4ba6-836a-dcc77b979957
// min 4.20 en el video sale como se ha de hacer

 // Lo de local lo explica en el video es porque solo hay dos niveles local y global

declaracionFuncion              :cabeceraFuncion
                                    {
                                        $<aux>$ = dvar;
                                        dvar = 0;
                                    }
                                bloque
                                    {
                                        descargaContexto(niv);
                                        niv=GLOBAL;
                                        // Es dos porque el corchete de arriba actua como otro elemento y nosotros almacenamos dvar en $<aux>$
                                        dvar = $<aux>2;
                                    }
                                ;

cabeceraFuncion                 : tipoSimple ID_
                                    {
                                        niv = LOCAL;
                                        cargaContexto(niv);
                                    }
                                 APAREN_ parametrosFormales CPAREN_
                                    {
                                        if(!insTdS($2, FUNCION, $1, niv, dvar, $5)) {
                                            yyerror("Error en cabeceraFuncion, funcion ya definida");
                                        }
                                    }
                                ;

bloque                          : ALLAVE_ declaracionVariableLocal listaInstrucciones RETURN_ expresion PTOCOMA_ CLLAVE_
                                ;

parametrosFormales              :
                                // Pseudocódigo diapos PF ⇒ e ==> PF.t = tvacio; PF.talla = 0;
                                | listaParametrosFormales
                                //  Pseudocódigo diapos  PF ⇒ LF ==> PF.t = LF.t; PF.talla = LF.talla − TallaSegEnlaces;
                                    {
                                        $$ = $1;
                                    }
                                ;

// TODO Revisar en las diapos pone que LF ⇒ DV , LF | DV no se si deber ser así
// con eso tenemos estas dos declaraciones

// LF ⇒ DV , LF ==> LF.t = DV.t ⊗ LF’.t; LF.talla = LF’.talla + DV.talla;
// insTdS(DV.n, “parámetro”, DV.t, n, -LF.talla);

// LF ⇒ DV ==> LF.t = DV.t; LF.talla = TallaSegEnlaces + DV.talla;
// insTdS(DV.n, “parámetro”, DV.t, n, -LF.talla);

listaParametrosFormales         : tipoSimple ID_
                                    {
                                        int ref = insTdD(-1, $1);
                                        if(!insTdS($2, PARAMETRO, $1, niv, dvar, ref))
                                            yyerror("Lista params formales - Parametro incorrecto");
                                        $$ = ref;
                                    }
                                | tipoSimple ID_ CMA_ listaParametrosFormales
                                    {
                                        if(!insTdS($2, PARAMETRO, $1, niv, dvar, $4))
                                            yyerror("Lista params formales - Parametro incorrecto");
                                    }
                                ;

declaracionVariableLocal        : %empty
                                | declaracionVariableLocal declaracionVariable
                                // Pseudocódigo diapos DL ⇒ DL DV ; ==> insTdS(DV.n, “variable-local”, DV.t, n, ∆); ∆ = ∆ + DV.talla;
                                ;

listaInstrucciones              : %empty
                                | listaInstrucciones instruccion
                                ;

instruccion                     : ALLAVE_ listaInstrucciones CLLAVE_
                                | instruccionAsignacion
                                | instruccionSeleccion
                                | instruccionEntradaSalida
                                | instruccionIteracion
                                ;

instruccionAsignacion           : ID_ ASIG_ expresion PTOCOMA_
                                // Pseudocódigo diapos I ⇒ id = E ; ==> si ¬[ obtTdS(id.n, id.t) ∧ (id.t = E.t) ] MenError(.);
                                    {
                                        SIMB simb = obtTdS($1);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en instruccionAsignacion, variable no declarada.");
                                        }
                                        else if(simb.t != $3.tipo){
                                            yyerror("Error en instruccionAsignacion, el tipo de la variable no coincide con la expresión");
                                        }
                                    }
                                | ID_ ACORCH_ expresion CCORCH_ ASIG_ expresion PTOCOMA_
                                // Pseudocódigo diapos I ⇒ id [ E ] = E ; ==> si ¬[ obtTdS(id.n, id.t) ∧ (id.t = tvector(id.nel, id.tel)) ∧
                                // (E1.t = tentero) ∧ (id.tel = E2.t) ] { MenError(.); }
                                    {
                                        SIMB simb = obtTdS($1);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en instruccionAsignacion, variable no declarada.");
                                        }
                                        else if (simb.t != T_ARRAY){
                                            yyerror("Error en instruccionAsignacion, varibale no es de tipo array.");
                                        }
                                        else {
                                            DIM array = obtTdA(simb.ref);
                                            if (array.telem == T_ERROR){
                                                yyerror("Error en instruccionAsignacion, el tipo del array en TdA es error.");
                                            }
                                            else if ($3.tipo != T_ENTERO){
                                                yyerror("Error en instruccionAsignacion, la expresion del indice no es de tipo entero.");
                                            }
                                            else if ($6.tipo == array.telem){
                                                yyerror("Error en instruccionAsignacion, el tipo de la expresion no es igual al tipo de los elementos");
                                            }
                                        }
                                    }
                                ;

instruccionEntradaSalida        : READ_ APAREN_ ID_ CPAREN_ PTOCOMA_
                                {
                                    SIMB simb = obtTdS($3);
                                    if( simb.t == T_ERROR) {
                                         yyerror("Error en instruccionES, no hay variable a la que asignar el valor");
                                    }
                                    else if ( simb.t != T_ENTERO) {
                                        yyerror("El argumento del 'read' debe ser 'entero'");
                                    }
                                }
                                | PRINT_ APAREN_ expresion CPAREN_ PTOCOMA_
                                {
                                    if ($3.tipo != T_ERROR && $3.tipo != T_ENTERO){
                                        yyerror("Error en instruccionES, la variable ha de ser de tipo entero.");
                                    }
                                }
                                ;

instruccionSeleccion            : IF_ APAREN_ expresion CPAREN_
                                 {
                                    if ($3.tipo != T_LOGICO && $3.tipo != T_ERROR){
                                        yyerror("Error en instruccionSeleccion, la expresion ha de ser de tipo lógico.");
                                    }
                                 }
                                instruccion ELSE_ instruccion
                                ;

instruccionIteracion            : FOR_ APAREN_ expresionOpcional PTOCOMA_ expresion PTOCOMA_ expresionOpcional CPAREN_ instruccion
                                    {

                                        if($5.tipo != T_LOGICO) {
                                            yyerror("Error en instruccionIteracion, la condicion no es logica");
                                        }
                                    }
                                ;

expresionOpcional               : %empty
                                | expresion
                                | ID_ ASIG_ expresion
                                    {
                                        SIMB simb = obtTdS($1);
                                        if($3.tipo != simb.t) {
                                            yyerror("Error en expresionOpcional, la expresion no es del mismo tipo que la variable.");
                                        }
                                    }
                                ;


expresion                       : expresionIgualdad
                                    {
                                        $$ = $1;
                                    }
                                | expresion operadorLogico expresionIgualdad
                                    {
                                        $$.tipo = T_ERROR;
                                        if($1.tipo != $3.tipo) {
                                            yyerror("Error en expresion, los tipos no coinciden.");
                                        }
                                        else if($1.tipo != T_LOGICO){
                                            yyerror("Error en expresion, la expresion no es de tipo lógico.");
                                        }
                                        else {
                                            // $1 debe ser tipo logico
                                            $$.tipo = $1.tipo;
                                        }
                                    }
                                ;
expresionIgualdad               : expresionRelacional
                                    {
                                        $$ = $1;
                                    }
                                | expresionIgualdad operadorIgualdad expresionRelacional
                                     {
                                        $$.tipo = T_ERROR;
                                        if ($1.tipo != T_ERROR && $3.tipo != T_ERROR){
                                                if ($1.tipo != $3.tipo){
                                                        yyerror("Error en expresionIgu, no coinciden los tipos de la igualdad.");
                                                } else if (!($1.tipo == $3.tipo && ($1.tipo == T_LOGICO || $1.tipo ==T_ENTERO)) ){
                                                        // Operación igualdad restringida para enteros y logicos
                                                        yyerror("Error en expresionIgu, error de tipos en la igualdad.");
                                                } else {
                                                        $$.tipo = T_LOGICO;
                                                }
                                        }
                                }
                                ;

expresionRelacional             : expresionAditiva
                                    {
                                        $$ = $1;
                                    }
                                | expresionRelacional operadorRelacional expresionAditiva
                                    {
                                        $$.tipo = T_ERROR;
                                        if($1.tipo != T_ENTERO || $3.tipo != T_ENTERO) {
                                            yyerror("Error en expresionRelacional, los dos operandos deben ser enteros.");
                                        }
                                        else {
                                            $$.tipo = $1.tipo;
                                        }
                                    }
                                ;

expresionAditiva                : expresionMultiplicativa
                                    {
                                        $$ = $1;
                                    }
                                | expresionAditiva operadorAditivo expresionMultiplicativa
                                    {
                                        $$.tipo = T_ERROR;
                                        if($1.tipo != T_ENTERO || $3.tipo != T_ENTERO) {
                                            yyerror("Error en expresionAditiva, los dos operandos deben ser enteros.");
                                        }
                                        else {
                                                $$.tipo = $1.tipo;
                                            }
                                    }
                                ;

expresionMultiplicativa         : expresionUnaria
                                    {
                                        $$ = $1;
                                    }
                                | expresionMultiplicativa operadorMultiplicativo expresionUnaria
                                    {
                                        $$.tipo = T_ERROR;
                                        if($1.tipo != T_ENTERO || $3.tipo != T_ENTERO) {
                                            yyerror("Error en expresionMultiplicativa, los dos operandos deben ser enteros.");
                                        }
                                        else {
                                            $$.tipo = $1.tipo;
                                        }
                                    }
                                ;

expresionUnaria                 : expresionSufija
                                    {
                                        $$.tipo = $1.tipo;
                                    }
                                | operadorUnario expresionUnaria
                                    {
                                        $$.tipo = T_ERROR;
                                        if ($2.tipo != T_ERROR )
                                        {
                                            if (!($2.tipo == T_ENTERO || $2.tipo == T_LOGICO)) {
                                                yyerror("Error en expresionUnaria, variable expresion unaria no es tipo entero o lógico.");
                                            }
                                            else
                                            {
                                                if ($1 == NOT_ && $2.tipo != T_LOGICO) {
                                                    yyerror("Error en expresionUnaria, solo se puede realizar expresion not T_LOGICO");
                                                } else if (($1 == MAS_ || $1 == MENOS_ ) && $2.tipo != T_ENTERO) {
                                                    yyerror("Error en expresionUnaria, los cambios de signo solo se aplican a enteros");
                                                } else {
                                                    $$.tipo = $2.tipo;
                                                }
                                            }
                                        }
                                    }
                                | operadorIncremento ID_
                                    {
                                        $$.tipo = T_ERROR;
                                        SIMB simb = obtTdS($2);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionUnaria, variable no declarada.");
                                        }
                                        else if (simb.ref != -1) {
                                            yyerror("Error en expresionUnaria, no es variable simple.");
                                        }
                                        else if (simb.t != T_ENTERO){
                                            yyerror("Error en expresionUnaria, variable ha de ser de tipo entero.");
                                        }
                                        else {
                                            $$.tipo = T_ENTERO;
                                        }
                                    }
                                ;

expresionSufija                 : APAREN_ expresion CPAREN_
                                    {
                                        $$ = $2;
                                    }
                                | ID_ operadorIncremento
                                    {
                                        $$.tipo = T_ERROR;
                                        SIMB simb = obtTdS($1);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionSufija, varibale no declarada.");
                                        }
                                        else if (simb.t != T_ENTERO) {
                                            yyerror("Error en expresionSufija, la variable ha de ser de tipo entero.");
                                        }
                                        else {
                                            $$.tipo = simb.t;
                                        }
                                    }
                                | ID_ ACORCH_ expresion CCORCH_
                                    {
                                        $$.tipo = T_ERROR;
                                        SIMB simb = obtTdS($1);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionSufija, varibale no declarada.");
                                        }
                                        else if (simb.t != T_ARRAY){
                                            yyerror("Error en expresionSufija, varibale no es de tipo array.");
                                        }
                                        else{
                                            DIM array = obtTdA(simb.ref);
                                            if (array.telem == T_ERROR){
                                                yyerror("Error en expresionSufija, no se ha encontrado el array.");
                                            }
                                            else if ($3.tipo != T_ENTERO){
                                                yyerror("Error en expresionSufija, la expresion no es de tipo entero.");
                                            }
                                            else if ($3.valor < 0 || $3.valor >= array.nelem) {
                                                yyerror("Error en expresionSufija, índice fuera de rango.");
                                            }
                                            else {
                                                $$.tipo = array.telem;
                                            }
                                        }
                                    }
                                | ID_ APAREN_ parametrosActuales CPAREN_
                                // E ⇒ id ==> ( PA ) si ¬[ obtTdS(id.n, id.t) ∧ (id.t = tfuncion(id.td, id.tr))
                                // ∧ (id.td = PA.t) ] { E.t = terror; MenError(.); }
                                // sino E.t = id.tr;
                                    {
                                        $$.tipo = T_ERROR;
                                        SIMB simb = obtTdS($1);
                                        INF dom = obtTdD(simb.ref);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionSufija, varibale no declarada.");
                                        }
                                        else if (dom.tipo == T_ERROR)
                                        {
                                            yyerror("Error en expresionSufija, la función no se corresponde con una ya compilada.");
                                        }
                                        // else if (simb.t != $3.t ) {
                                        //     yyerror("Error en expresionSufija, el tipo del dominio no coincide con el de los PA.");
                                        // }
                                        else{
                                            $$.tipo = dom.tipo;
                                        }
                                    }
                                | ID_
                                    {
                                        $$.tipo = T_ERROR;
                                        SIMB simb = obtTdS($1);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionSufija, varibale no declarada.");
                                        }
                                        else {
                                            $$.tipo = simb.t;
                                        }
                                    }
                                | constante
                                    {
                                        $$ = $1;
                                    }

parametrosActuales              : %empty
                                | listaParametrosActuales
                                ;

listaParametrosActuales         : expresion
                                | expresion CMA_ listaParametrosActuales
                                ;
/***************************************************/

constante                       : CTE_ {
                                            $$.tipo = T_ENTERO;
                                            $$.valor = $<aux>1;
                                        }
                                | TRUE_ { $$.tipo = T_LOGICO;
                                          $$.valor = TRUE;
                                }
                                | FALSE_ { $$.tipo = T_LOGICO;
                                           $$.valor = FALSE;
                                }
                                ;

operadorLogico                  :AND_
                                |OR_
                                ;

operadorIgualdad                :IGUAL_
                                |NOIGUAL_
                                ;

operadorRelacional              : MAY_
                                | MEN_
                                | MAYIGUAL_
                                | MENIGUAL_
                                ;

operadorAditivo                 : MAS_
                                | MENOS_
                                ;

operadorMultiplicativo          : POR_
                                | DIV_
                                | MOD_
                                ;

operadorUnario                  : MAS_
                                | MENOS_
                                | NOT_
                                ;

operadorIncremento              : INC_
                                | DEC_
                                ;