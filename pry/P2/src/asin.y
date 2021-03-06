%{
#include <stdio.h>
#include <string.h>
#include "header.h"
#include "libtds.h"
%}

%union {
    char* ident;            // Para el terminal "identificador"
    int cent;               // Para el terminal "cte" entera
    int aux;                // Para los no terminales con atributo simple
    EXPR expre;             // Para los no terminales expresion
    ARGU arg;               // Para los argumentos
}


%token WHILE_ FOR_ IF_ ELSE_ TRUE_ FALSE_ PRINT_ READ_ RETURN_ INT_ BOOL_
%token ALLAVE_  CLLAVE_ ACORCH_  CCORCH_ APAREN_ CPAREN_ PTOCOMA_ PTO_ CMA_
%token MAS_ MENOS_ POR_ DIV_
%token AND_ OR_ SUMASIG_ RESASIG_ MULASIG_ DIVASIG_ IGUAL_ NOIGUAL_ MAYIGUAL_ MENIGUAL_ INC_ DEC_  MAY_ MEN_ ASIG_ NOT_ MOD_

%token <cent> CTE_
%token <ident> ID_


// %type <aux> listaDeclaraciones declaracion declaracionVariable tipoSimple declaracionFuncion cabeceraFuncion
// %type <aux> parametrosActuales listaParametrosActuales operadorUnario declaracionVariableLocal

%type <aux> listaDeclaraciones declaracion tipoSimple declaracionFuncion cabeceraFuncion
%type <aux> parametrosActuales listaParametrosActuales operadorUnario

// %type <arg>  listaParametrosFormales parametrosFormales
%type <arg>  listaParametrosFormales parametrosFormales

%type <expre> expresionOpcional expresion expresionIgualdad expresionRelacional expresionAditiva expresionMultiplicativa
%type <expre> expresionUnaria expresionSufija constante


// ∆ = primera posición libre en el segmento de datos. n = nivel del bloque actual.
// ∆ = dvar y n = niv
// Nuestro nivel de anidamiento es solo local o global

%%
programa                        :// Pseudocódigo diapos P ⇒ LD ==> n = 0; ∆ = 0;
                                { niv = GLOBAL; dvar = 0; cargaContexto(niv);}
                                listaDeclaraciones
                                    {
                                        if ($2 == 0) yyerror("El programa no tiene main");
                                    }
                                ;

listaDeclaraciones              : declaracion
                                    {
                                        $$ = $1;
                                    }
                                | listaDeclaraciones declaracion
                                    {
                                        if ($1 == 0){
                                            $$ = $2;
                                        }
                                        else if($2 == 0){
                                            $$ = $1;
                                        }
                                        else{
                                            TRAZA;
                                            yyerror("El programa tiene mas de un main");
                                        }
                                    }
                                ;

declaracion                     : declaracionVariable
                                {
                                    $$ = 0;
                                }
                                // Pseudocódigo diapos D ⇒ DV ==> insTdS(DV.n, “variable-global”, DV.t, n, ∆); ∆ = ∆ + DV.talla;
                                | declaracionFuncion
                                {
                                    $$ = $1;
                                }
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
                                        if (!insTdS($2, VARIABLE, T_ARRAY, niv, dvar, insTdA($1,$4))){
                                            yyerror("Error en declaracionVariable, variable ya declarada");
                                        }
                                        else if( $4 <= 0 ){
                                            yyerror("Error en declaracionVariable, indice ha de ser mayor de cero");
                                        }
                                        else {
                                            dvar += TALLA_TIPO_SIMPLE * $4;
                                        }
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
                                        if (verTdS) mostrarTdS();
                                        descargaContexto(niv);
                                        niv=GLOBAL;
                                        // Es dos porque el corchete de arriba actua como otro elemento y nosotros almacenamos dvar en $<aux>$
                                        dvar = $<aux>2;
                                        $$ = $1;
                                    }
                                ;

cabeceraFuncion                 : tipoSimple ID_
                                    {
                                        niv = LOCAL;
                                        cargaContexto(niv);
                                    }
                                APAREN_ parametrosFormales CPAREN_
                                    {
                                        if(strcmp($2, "main") == 0){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                        if(!insTdS($2, FUNCION, $1, niv, dvar, $5.ref)) {
                                            yyerror("Error en cabeceraFuncion, funcion ya definida");
                                        }
                                    }
                                ;

bloque                          : ALLAVE_ declaracionVariableLocal listaInstrucciones RETURN_ expresion PTOCOMA_ CLLAVE_
                                ;

parametrosFormales              : %empty
                                // Pseudocódigo diapos PF ⇒ e ==> PF.t = tvacio; PF.talla = 0;
                                    {
                                        int ref = insTdD(-1, T_VACIO);
                                        $$.talla = 0;
                                        $$.ref = ref;
                                    }
                                | listaParametrosFormales
                                //  Pseudocódigo diapos  PF ⇒ LF ==> PF.t = LF.t; PF.talla = LF.talla − TallaSegEnlaces;
                                    {
                                        $$.talla = $1.talla - TALLA_SEGENLACES;
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
                                        $$.talla = TALLA_TIPO_SIMPLE + TALLA_SEGENLACES;
                                        $$.ref = ref;
                                        insTdS($2, PARAMETRO, $1, niv, dvar, -1);
                                    }
                                | tipoSimple ID_ CMA_ listaParametrosFormales
                                    {
                                        INF dom = obtTdD($4.ref);
                                        if(dom.tipo != T_ERROR) {
                                            yyerror("Error, campo ya declarado");
                                        }

                                        insTdD($4.ref, $1);
                                        $$.talla += TALLA_TIPO_SIMPLE + TALLA_SEGENLACES;
                                        $$.ref = $4.ref;
                                        insTdS($2, PARAMETRO, $1, niv, dvar, -1);
                                    }
                                ;

declaracionVariableLocal        : %empty
                                | declaracionVariableLocal declaracionVariable
                                // Pseudocódigo diapos DL ⇒ DL DV ; ==> insTdS(DV.n, “variable-local”, DV.t, n, ∆); ∆ = ∆ + DV.talla;

listaInstrucciones              :
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
                                        if ($3.tipo == T_ERROR){
                                            // No hacemos nada el mensaje ya ha sido mostrado
                                        }
                                        else if (simb.t == T_ERROR) {
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
                                        if ($6.tipo == T_ERROR){
                                            // No hacemos nada el mensaje ya ha sido mostrado
                                        }
                                        else if (simb.t == T_ERROR) {
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
                                            else if ($6.tipo != array.telem){
                                                yyerror("Error en instruccionAsignacion, el tipo de la expresion no es igual al tipo de los elementos");
                                            }
                                        }
                                    }
                                ;

instruccionEntradaSalida        : READ_ APAREN_ ID_ CPAREN_ PTOCOMA_
                                {
                                    SIMB simb = obtTdS($3);
                                    if (simb.t == T_ERROR) {
                                        yyerror("Error en instruccionEntradSalida, variable no declarada.");
                                    }
                                    else if (simb.t != T_ENTERO) {
                                        yyerror("Error en instruccionEntradSalida, la variable ha de ser de tipo entero.");
                                    }
                                }
                                | PRINT_ APAREN_ expresion CPAREN_ PTOCOMA_
                                {
                                    if ($3.tipo != T_ERROR && $3.tipo != T_ENTERO){
                                        yyerror("Error en instruccionEntradSalida, la variable ha de ser de tipo entero.");
                                    }
                                }
                                ;

instruccionSeleccion            : IF_ APAREN_ expresion CPAREN_
                                {
                                    if ($3.tipo == T_ERROR ){
                                        // EL error ya ha sido mostrado
                                    }
                                    else if ($3.tipo != T_LOGICO){
                                        yyerror("Error en instruccionSeleccion, la expresion ha de ser de tipo lógico.");
                                    }
                                }
                                instruccion ELSE_ instruccion
                                ;

instruccionIteracion            : FOR_ APAREN_ expresionOpcional PTOCOMA_ expresion                                 PTOCOMA_ expresionOpcional CPAREN_
                                {
                                    if($5.tipo != T_LOGICO) {
                                        yyerror("Error en instruccionIteracion, la condicion no es logica");
                                    }
                                }
                                instruccion
                                ;

expresionOpcional               : %empty { $$.tipo == T_VACIO;
                                    }
                                | expresion
                                    {
                                        if($1.tipo != T_LOGICO) {
                                            yyerror("Error en expresionOpcional, la expresion no es logica.");
                                        }
                                    }
                                | ID_ ASIG_ expresion
                                    {
                                        if($3.tipo != T_LOGICO) {
                                            yyerror("Error en expresionOpcional, la expresion no es logica.");
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
                                        if($1.tipo == T_ARRAY){
                                            yyerror("Esto esta mal");
                                        }
                                        if($1.tipo != $3.tipo) {
                                            yyerror("Error en expresion, los tipos no coinciden");
                                        }
                                        else {
                                            $$.tipo = $1.tipo;
                                        }
                                    }
                                ;
expresionIgualdad               : expresionRelacional
                                    {
                                        $$ = $1;
                                    }
                                | expresionIgualdad operadorigualdad expresionRelacional
                                    {
                                        $$.tipo = T_ERROR;
                                        if ($1.tipo != T_ERROR && $3.tipo != T_ERROR){
                                                if ($1.tipo != $3.tipo){
                                                        yyerror("Error en expresionIgualdad, no coinciden los tipos de la igualdad");
                                                } else if (!($1.tipo == $3.tipo && ($1.tipo == T_LOGICO || $1.tipo ==T_ENTERO)) ){
                                                        yyerror("Error en expresionIgualdad, error de tipos en la igualdad");
                                                } else {
                                                        $$.tipo = T_LOGICO;
                                                }
                                        }
                                }
                                ;

expresionRelacional             : expresionAditiva
                                    { $$ = $1;
                                    }
                                | expresionRelacional operadorRelacional expresionAditiva
                                    {
                                        $$.tipo = T_ERROR;
                                        if($1.tipo != T_ERROR && $3.tipo != T_ERROR) {
                                            if($1.tipo != T_ENTERO || $3.tipo != T_ENTERO) {
                                                yyerror("Error en expresionRelacional, los operandos deben ser enteros");
                                            }
                                            else {
                                                $$.tipo = T_LOGICO;
                                            }
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
                                            yyerror("Error en expresionAditiva, los operandos no son de tipo entero");
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
                                            yyerror("Error en expresionMultiplicativa, los operandos no son de tipo entero");
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
                                                yyerror("Error en expresionUnaria, variable espresion unaria no es tipo entero o lógico.");
                                            }
                                            else
                                            {
                                                if ($1 == NOT_ && $2.tipo != T_LOGICO) {
                                                    yyerror("Error en expresionUnaria, solo se puede realizar expresion not con T_LOGICO");
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
                                                yyerror("Error en expresionSufija, el tipo del array en TdA es error.");
                                            }
                                            else if ($3.tipo != T_ENTERO){
                                                yyerror("Error en expresionSufija, la expresion no es de tipo entero.");
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
                                        $$.tipo = $1.tipo;
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
                                        }
                                | TRUE_ { $$.tipo = T_LOGICO; }
                                | FALSE_ { $$.tipo = T_LOGICO; }
                                ;

operadorLogico                  : AND_
                                | OR_
                                ;

operadorigualdad                : IGUAL_
                                | NOIGUAL_
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

operadorUnario                  : MAS_ { $$=MAS_; }
                                | MENOS_ { $$=MENOS_; }
                                | NOT_ { $$=NOT_; }
                                ;

operadorIncremento              : INC_
                                | DEC_
                                ;