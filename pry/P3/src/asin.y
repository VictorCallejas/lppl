%{
#include <stdio.h>
#include <string.h>
#include "header.h"
#include "libtds.h"
#include "libgci.h"
%}

%union {
    char* ident;            // Para el terminal "identificador"
    int cent;               // Para el terminal "cte" entera
    int aux;                // Para los no terminales con atributo simple
    EXPR expre;             // Para los no terminales expresion
    ARGU arg;               // Para los argumentos
    FOR_INST instfor;       // Para las instrucciones del for
    REFE refe;

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

%type <cent> operadorLogico operadorIgualdad operadorRelacional operadorAditivo operadorMultiplicativo operadorIncremento

// %type <arg>  listaParametrosFormales parametrosFormales
%type <arg>  listaParametrosFormales parametrosFormales

%type <expre> expresionOpcional expresion expresionIgualdad expresionRelacional expresionAditiva expresionMultiplicativa
%type <expre> expresionUnaria expresionSufija constante instruccionAsignacion


// ∆ = primera posición libre en el segmento de datos. n = nivel del bloque actual.
// ∆ = dvar y n = niv
// Nuestro nivel de anidamiento es solo local o global

%%
programa                        :// Pseudocódigo diapos P ⇒ LD ==> n = 0; ∆ = 0; Ω = 0;
                                {
                                    niv = GLOBAL; dvar = 0; si = 0; cargaContexto(niv);
                                    /*************** Reserva de espacio para variables globales */
                                    $<refe>$.ref1 = creaLans(si);
                                    emite( INCTOP, crArgNul(), crArgNul(), crArgEnt(-1));
                                    dvar +=1;
                                    /*************** Salto al comienzo de la funcion "main" */
                                    $<refe>$.ref2 = creaLans(si);
                                    emite(GOTOS, crArgNul(), crArgNul(), crArgEtq(-1));
                                    dvar +=1;
                                }
                                listaDeclaraciones
                                    {
                                        // control del "main
                                        if ($2 == 0) yyerror("El programa no tiene main");

                                        // lista declariones no tiene .d
                                        $<cent>$ = creaVarTemp();

                                        /***** Completa espacio para las variables globales */
                                        completaLans($<refe>1.ref1, crArgEnt(dvar));

                                        /***** Completa salto al comienzo del "main" */
                                        completaLans($<refe>$.ref2, crArgEtq(XX));
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
                                // Emite(push(fp)); Emite(fp = sp);
                                // D.d = CreaLans(Ω); Emite(sp = sp+⊗);
                                    {
                                        $<aux>$ = dvar;
                                    }
                                bloque
                                // CompletaLans(D.d, ∆); Emite(sp = fp);
                                // Emite(fp = pop); Emite(return(pop));
                                    {
                                        descargaContexto(niv);
                                        niv=GLOBAL;
                                        // Es dos porque el corchete de arriba actua como otro elemento y nosotros almacenamos dvar en $<aux>$
                                        dvar = $<aux>2;
                                        $$ = $1;

                                        /****************** Emite FIN si es "main" y RETURN si no es */
                                        if ($1 == 1){
                                            emite( FIN, crArgNul(), crArgNul(), crArgNul());
                                        }
                                        else {
                                            emite( RET, crArgNul(), crArgNul(), crArgNul());
                                        }
                                    }
                                ;

cabeceraFuncion                 : tipoSimple ID_
                                    {
                                        niv = LOCAL;
                                        cargaContexto(niv);
                                    }
                                APAREN_ parametrosFormales CPAREN_
                                // Emite(push(fp)); Emite(fp = sp);
                                // D.d = CreaLans(Ω); Emite(sp = sp+⊗);
                                    {
                                        if(strcmp($2, "main") == 0){
                                            $$ = 1;
                                            XX = si;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                        if(!insTdS($2, FUNCION, $1, niv, dvar, $5.ref)) {
                                            yyerror("Error en cabeceraFuncion, funcion ya definida");
                                        }
                                    }
                                ;

bloque                          :{
                                    dvar = 0;
                                    /************************* Carga de los enlaces de control */
                                    emite( PUSHFP, crArgNul(), crArgNul(), crArgNul());
                                    emite( FPTOP, crArgNul(), crArgNul(), crArgNul());
                                    /***** Reserva de espacio para Variables locales y temporales */
                                    $<aux>$ = creaLans(si);
                                    emite(INCTOP, crArgNul(), crArgNul(), crArgEnt(-1));
                                }
                                ALLAVE_ declaracionVariableLocal listaInstrucciones RETURN_ expresion PTOCOMA_ CLLAVE_
                                {
                                    INF f = obtTdD(-1);
                                    if (f.tipo == T_ERROR){
                                        yyerror("Error en bloque, la función no esta compilada.");
                                    }
                                    /**** Completa la reserva de espacios para variables locales */
                                    completaLans($<aux>1, crArgEnt(dvar));
                                    /*********************************** guardar valor de retorno */
                                    int dvret; /* Desplazamiento del valor retorno en el RA */
                                    dvret = TALLA_SEGENLACES + f.tsp + TALLA_TIPO_SIMPLE;
                                    emite(EASIG,crArgPos(niv, $6.pos),crArgNul(),crArgPos(niv, -dvret));
                                    /********* Libera el segmento de variables locales y temporales */
                                    emite(TOPFP, crArgNul(), crArgNul(), crArgNul());
                                    /************************** Descarga de los enlaces de control */
                                    emite(FPPOP, crArgNul(), crArgNul(), crArgNul());
                                }
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
                                        $$.talla = $1.talla + TALLA_SEGENLACES;
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
                                        // SIMB sim = obtTdS($2);
                                        // dvar = -TALLA_SEGENLACES + sim.d;

                                        // if(!insTdS($2, PARAMETRO, $1, niv, dvar, -1)){
                                        //     yyerror("Parametro no valido");
                                        // } else{
                                        //     $$.ref = insTdD(-1, $1);
                                        // }
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
                                        // SIMB sim = obtTdS($2);
                                        // dvar = -TALLA_SEGENLACES + sim.d;

                                        // if(!insTdS($2, PARAMETRO, $1, niv, dvar, $4.ref)){
                                        //     yyerror("Parametro no valido");}
                                        // else{
                                        //     $$.ref = insTdD($4.ref,$1);
                                        // }
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
                                // Pseudocódigo diapos I ⇒ id = E ; ==> si ¬[ obtTdS(id.n, id.t) ∧ (id.t = E.t) ] {MenError(.)}
                                // sino Emite(id.d = E.d);
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

                                        emite( EASIG, crArgPos(niv, $3.pos), crArgNul(), crArgPos(simb.n, simb.d));
                                    }
                                | ID_ ACORCH_ expresion CCORCH_ ASIG_ expresion PTOCOMA_
                                // Pseudocódigo diapos I ⇒ id [ E ] = E ; ==>
                                // si ¬[ obtTdS(id.n, id.t) ∧ (id.t = tvector(id.nel, id.tel)) ∧ (E1.t = tentero) ∧ (id.tel = E2.t) ] { MenError(.); }
                                // sino Emite(E1.d = E1.d ∗ talla(id.tel));
                                // Emite(id.pos [ E1.pos ] = E2.pos);
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

                                        $$.pos = creaVarTemp();
                                        emite(EASIG, crArgPos(niv, $6.pos), crArgNul(), crArgPos(niv, $$.pos));
                                        emite(EVA, crArgPos(simb.n, simb.d), crArgPos(niv, $3.pos), crArgPos(niv, $6.pos));
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
                                    emite(EREAD, crArgNul(), crArgNul(), crArgPos(simb.n, simb.d));
                                }
                                | PRINT_ APAREN_ expresion CPAREN_ PTOCOMA_
                                {
                                    if ($3.tipo != T_ERROR && $3.tipo != T_ENTERO){
                                        yyerror("Error en instruccionEntradSalida, la variable ha de ser de tipo entero.");
                                    }
                                    emite(EWRITE, crArgNul(), crArgNul(), crArgPos(niv, $3.pos));
                                }
                                ;

instruccionSeleccion            : IF_ APAREN_ expresion CPAREN_
                                // S.If = CreaLans(Ω); Emite(if E.d = ’0’ goto ⊗)
                                {
                                    if ($3.tipo == T_ERROR ){
                                        // EL error ya ha sido mostrado
                                    }
                                    else if ($3.tipo != T_LOGICO){
                                        yyerror("Error en instruccionSeleccion, la expresion ha de ser de tipo lógico.");
                                    }

                                    $<cent>$ = creaLans(si);
                                    emite(EIGUAL, crArgPos(niv, $3.pos), crArgEnt(0), crArgEtq(-1));
                                }
                                instruccion
                                // S.fin = CreaLans(Ω); Emite(goto ⊗); CompletaLans(S.lf, Ω);
                                {
                                    $<cent>$ = creaLans(si);
                                    emite(GOTOS, crArgNul(), crArgNul(), crArgEtq(-1));
                                    completaLans($<cent>5, crArgEnt(si));
                                }
                                ELSE_ instruccion
                                // CompletaLans(S.fin, Ω);
                                {
                                    completaLans($<cent>7, crArgEnt(si));
                                }
                                ;

instruccionIteracion            : FOR_ APAREN_ expresionOpcional PTOCOMA_
                                // S.ini = Ω;
                                {
                                    $<cent>$ = si;
                                }
                                expresion PTOCOMA_
                                // S.lv = CreaLans(Ω); Emite(if E2.d = ’1’ goto ⊗);
                                // S.lf = CreaLans(Ω); Emite(goto ⊗);
                                // S.aux = Ω;
                                {
                                    if ($6.tipo != T_ERROR){
                                        // El error ya ha sido mostrado
                                    }
                                    else if($6.tipo != T_LOGICO) {
                                        yyerror("Error en instruccionIteracion, la condicion no es logica");
                                    }

                                    $<instfor>$.lv = creaLans(si);
                                    emite(EIGUAL, crArgPos(niv, $6.pos), crArgEnt(1), crArgEtq(-1));

                                    $<instfor>$.lf = creaLans(si);
                                    emite(GOTOS, crArgNul(), crArgNul(), crArgEtq(-1));

                                    $<instfor>$.aux = si;
                                }
                                expresionOpcional CPAREN_
                                // Emite(goto S.ini); CompletaLans(S.lv, Ω);
                                {
                                    emite(GOTOS, crArgNul(), crArgNul(), crArgEtq($<cent>5));
                                    completaLans($<instfor>8.lv, crArgEnt(si));
                                }
                                instruccion
                                // Emite(goto S.aux); CompletaLans(S.lf, Ω);
                                {
                                    emite(GOTOS, crArgNul(), crArgNul(), crArgEtq($<instfor>8.aux));
                                    completaLans($<instfor>8.lf, crArgEnt(si));
                                }
                                ;

expresionOpcional               : %empty { $$.tipo == T_VACIO;
                                    }
                                | expresion
                                    {
                                        $$ = $1;
                                    }
                                | ID_ ASIG_ expresion
                                {
                                    $$.tipo = T_ERROR;
                                    SIMB simb = obtTdS($1);
                                    if ($3.tipo != T_ERROR) {
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionOpcional, varibale ya declarada");
                                        } else if (!((simb.t == T_LOGICO && $3.tipo == T_LOGICO) ||
                                                    (simb.t == T_ENTERO && $3.tipo == T_ENTERO))) {
                                            yyerror("Error en expresionOpcional, los tipos no coinciden.");
                                        } else {
                                            $$.tipo = simb.t;
                                        }
                                    }


                                    $$.pos = creaVarTemp();
                                    emite(EASIG, crArgPos(niv, $3.pos), crArgNul(), crArgPos(niv, $$.pos));
                                    emite(EASIG, crArgPos(niv, $3.pos), crArgNul(), crArgPos(simb.n, simb.d));

                                }
                                ;


expresion                       : expresionIgualdad
                                    {
                                        $$ = $1;
                                    }
                                | expresion operadorLogico expresionIgualdad
                                    {
                                        $$.tipo = T_ERROR;
                                        if($1.tipo == T_ERROR || $3.tipo == T_ERROR){
                                            // Error printeado en su sitio
                                        }
                                        else {
                                            $$.tipo = T_LOGICO;
                                        }

                                        $$.pos = creaVarTemp();
                                        if ($2 == AND_) {
                                            emite(EMULT, crArgPos(niv, $1.pos), crArgPos(niv, $3.pos), crArgPos(niv, $$.pos));
                                        } else if ($2 == OR_) {
                                            emite(ESUM, crArgPos(niv, $1.pos), crArgPos(niv, $3.pos), crArgPos(niv, $$.pos));
                                            emite(EMENEQ, crArgPos(niv, $$.pos), crArgEnt(1), crArgEtq(si + 2));
                                            emite(EASIG, crArgEnt(1), crArgNul(), crArgPos(niv, $$.pos));
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
                                                        yyerror("Error en expresionIgualdad, no coinciden los tipos de la igualdad");
                                                } else if (!($1.tipo == $3.tipo && ($1.tipo == T_LOGICO || $1.tipo ==T_ENTERO)) ){
                                                        yyerror("Error en expresionIgualdad, error de tipos en la igualdad");
                                                } else {
                                                        $$.tipo = T_LOGICO;
                                                }
                                        }
                                        $$.pos = creaVarTemp();
                                        emite(EASIG, crArgEnt(1), crArgNul(), crArgPos(niv, $$.pos));
                                        emite($2, crArgPos(niv, $1.pos), crArgPos(niv, $3.pos), crArgEtq(si + 2));
                                        emite(EASIG, crArgEnt(0), crArgNul(), crArgPos(niv, $$.pos));
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

                                    $$.pos = creaVarTemp();
                                    emite(EASIG, crArgEnt(1), crArgNul(), crArgPos(niv, $$.pos));
                                    emite($2, crArgPos( niv, $1.pos), crArgPos( niv, $3.pos), crArgEtq(si + 2));
                                    emite(EASIG, crArgEnt(0), crArgNul(), crArgPos(niv, $$.pos));
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

                                    $$.pos = creaVarTemp();
                                    emite($2, crArgPos(niv, $1.pos), crArgPos(niv, $3.pos), crArgPos(niv, $$.pos));
                                    }
                                ;

expresionMultiplicativa         : expresionUnaria
                                    {
                                        $$ = $1;
                                    }
                                | expresionMultiplicativa operadorMultiplicativo expresionUnaria
                                    //si ¬[ E1.t = E2.t = tentero ] { E.t = terror; MenError(.); }
                                    // sino E.t = tentero; E.d = CreaVarTemp(E.t); Emite(E.d = E1.d mod E2.d);
                                    {
                                        $$.tipo = T_ERROR;
                                        if($1.tipo == T_ERROR || $3.tipo == T_ERROR){
                                            // Error ya mostrado donde deber
                                        }
                                        else if($1.tipo != T_ENTERO || $3.tipo != T_ENTERO) {
                                            yyerror("Error en expresionMultiplicativa, los operandos no son de tipo entero");
                                        }
                                        else {
                                            $$.tipo = T_ENTERO;
                                        }
                                        $$.pos = creaVarTemp();
                                        emite($2, crArgPos(niv, $1.pos), crArgPos(niv, $3.pos), crArgPos(niv, $$.pos));
                                    }
                                ;

expresionUnaria                 : expresionSufija
                                    {
                                        $$.tipo = $1.tipo;
                                    }
                                | operadorUnario expresionUnaria
                                    // E => - E
                                    // si ( E.t 6= tentero ) { E.t = terror; MenError(.); }
                                    // sino E.t = E1.t; E.d = CreaVarTemp(E.t);
                                    // (Emite(E.d = - E1.d);
                                    {
                                        $$.tipo = T_ERROR;
                                        if ($2.tipo != T_ERROR )
                                        {
                                            if (!($2.tipo == T_ENTERO || $2.tipo == T_LOGICO)) {
                                                yyerror("Error en expresionUnaria, variable espresion unaria no es tipo entero o lógico.");
                                            }
                                            else
                                            {
                                                if ($1 == NOT && $2.tipo != T_LOGICO) {
                                                    yyerror("Error en expresionUnaria, solo se puede realizar expresion not con T_LOGICO");
                                                } else if (($1 == ESUM || $1 == EDIF ) && $2.tipo != T_ENTERO) {
                                                    yyerror("Error en expresionUnaria, los cambios de signo solo se aplican a enteros");
                                                } else {
                                                    $$.tipo = $2.tipo;
                                                }
                                            }
                                        }

                                        $$.pos = creaVarTemp();
                                        if ($1 == NOT) {
                                            emite(EDIF, crArgEnt(1), crArgPos( niv, $2.pos), crArgPos(niv, $$.pos));
                                        } else {
                                            emite($1, crArgEnt(0), crArgPos(niv, $2.pos), crArgPos(niv, $$.pos));
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
                                        $$.pos = creaVarTemp();
                                        emite($1, crArgPos(simb.n,simb.d), crArgEnt(1), crArgPos(simb.n, simb.d));
                                        emite(EASIG, crArgPos(simb.n,simb.d), crArgNul(), crArgPos(niv, $$.pos));
                                    }
                                ;

expresionSufija                 : APAREN_ expresion CPAREN_
                                    // E.t = E1.t; E.d = E1.d;
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
                                        $$.pos = creaVarTemp();
                                        emite(EASIG, crArgPos(simb.n, simb.d), crArgNul(), crArgPos(niv, $$.pos));
                                        emite($2, crArgPos(simb.n, simb.d), crArgEnt(1), crArgPos(simb.n, simb.d));
                                    }
                                | ID_ ACORCH_ expresion CCORCH_
                                // E => id [E]
                                // si ¬[ obtTdS(id.n, id.t, id.d) ∧ ( id.t = tvector(id.nel, id.tel)) ∧ (E1.t = tentero) ] { E.t = terror; MenError(.); }
                                // sino E.t = id.tel; Emite(E1.d = E1.d ∗ talla(E.t)); E.d = CreaVarTemp(E.t); Emite(E.d = id.d [ E1.d ] );
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
                                                // emite(EMULT, crArg( niv, $3.pos), crArgEnt(TALLA_TIPO_SIMPLE), crArg( niv, $3.pos))
                                            }
                                        }
                                        $$.pos = creaVarTemp();
                                        emite(EAV, crArgPos(simb.n, simb.d), crArgPos(niv, $3.pos), crArgPos(niv, $$.pos));
                                    }
                                | ID_ APAREN_
                                {
                                    /******************* Reserva espacio para el valor de retorno */
                                    //emite( INCTOP, crArgNul(), crArgNul(), crArgEnt(TALLA_TIPO_SIMPLE));
                                    emite( EPUSH, crArgNul(), crArgNul(), crArgEnt(0));
                                }
                                parametrosActuales CPAREN_
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
                                        // else if (simb.t != $4.t ) {
                                        //     yyerror("Error en expresionSufija, el tipo del dominio no coincide con el de los PA.");
                                        // }
                                        else{
                                            $$.tipo = dom.tipo;
                                        }

                                        /************************************* Llamada a la funcion */
                                        emite( CALL, crArgNul(), crArgNul(), crArgEtq(simb.d));
                                        /*********************** Desapila el segmento de parametros */
                                        emite( DECTOP, crArgNul(), crArgNul(), crArgEnt(dom.tsp));
                                        /******************* Desapila y asigna el valor de retorno */
                                        $$.pos = creaVarTemp();
                                        emite( EPOP, crArgNul(), crArgNul(), crArgPos(niv, $$.pos));

                                    }
                                | ID_
                                // si ¬[ obtTdS(id.n, id.t, id.d) { MenError(.); E.t = terror; }
                                // sino E.t = id.t; E.d = CreaVarTemp(E.t);
                                // Emite(E.d = id.d);
                                    {
                                        $$.tipo = T_ERROR;
                                        SIMB simb = obtTdS($1);
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionSufija, varibale no declarada.");
                                        }
                                        else {
                                            $$.tipo = simb.t;
                                        }
                                        $$.pos = creaVarTemp();
                                        emite(EASIG, crArgPos(simb.n, simb.d), crArgNul(), crArgPos(niv, $$.pos));
                                    }
                                | constante
                                    // E.t = cte.t; E.d = CreaVarTemp(E.t); Emite(E.d = cte.num);
                                    {
                                        $$ = $1;
                                    }

parametrosActuales              : %empty
                                | listaParametrosActuales
                                ;

listaParametrosActuales         : expresion
                                {
                                    emite( EPUSH, crArgNul(), crArgNul(), crArgPos(niv,$1.pos));
                                }
                                | expresion CMA_
                                {
                                    emite( EPUSH, crArgNul(), crArgNul(), crArgPos(niv,$1.pos));
                                }
                                listaParametrosActuales
                                ;

constante                       : CTE_ {
                                        $$.tipo = T_ENTERO;
                                        $$.pos = creaVarTemp();
                                        emite(EASIG, crArgEnt($1), crArgNul(), crArgPos(niv, $$.pos));
                                        }
                                | TRUE_ {
                                        $$.tipo = T_LOGICO;
                                        $$.pos = creaVarTemp();
                                        emite(EASIG, crArgEnt(1), crArgNul(), crArgPos(niv, $$.pos));
                                    }
                                | FALSE_ {
                                        $$.tipo = T_LOGICO;
                                        $$.pos = creaVarTemp();
                                        emite(EASIG, crArgEnt(0), crArgNul(), crArgPos(niv, $$.pos));
                                }
                                ;

operadorLogico                  : AND_ {$$=AND_;}
                                | OR_ {$$=OR_;}
                                ;

operadorIgualdad                : IGUAL_ { $$=EIGUAL; }
                                | NOIGUAL_ { $$=EDIST; }
                                ;

operadorRelacional              : MAY_ { $$=EMAY; }
                                | MEN_ { $$=EMEN; }
                                | MAYIGUAL_ { $$=EMAYEQ; }
                                | MENIGUAL_ { $$=EMENEQ; }
                                ;

operadorAditivo                 : MAS_ { $$=ESUM; }
                                | MENOS_ { $$=EDIF; }
                                ;

operadorMultiplicativo          : POR_ { $$=EMULT; }
                                | DIV_ { $$=EDIVI; }
                                | MOD_ { $$=RESTO; }
                                ;

operadorUnario                  : MAS_ { $$=ESUM; }
                                | MENOS_ { $$=EDIF; }
                                | NOT_  {$$=NOT; }
                                ;

operadorIncremento              : INC_ { $$=ESUM; }
                                | DEC_ { $$=EDIF; }
                                ;