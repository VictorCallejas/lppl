%{
#include <stdio.h>
#include "header.h"
#include "libtds.h"
%}

%union {
    char* ident;            //Para el terminal "identificador"
    int cent;               //Para el terminal "cte" entera  
    int aux;                // Para los no terminales con atributo simple
    EXPR expre;             // Para los no terminales expresion
    ARGU arg;               //Para los argumentos
}


%token WHILE_ FOR_ IF_ ELSE_ TRUE_ FALSE_ PRINT_ READ_ RETURN_ INT_ BOOL_
%token ALLAVE_  CLLAVE_ ACORCH_  CCORCH_ APAREN_ CPAREN_ PTOCOMA_ PTO_ CMA_
%token MAS_ MENOS_ POR_ DIV_
%token AND_ OR_ SUMASIG_ RESASIG_ MULASIG_ DIVASIG_ IGUAL_ NOIGUAL_ MAYIGUAL_ MENIGUAL_ INC_ DEC_  MAY_ MEN_ ASIG_ NOT_ MOD_

%token <cent> CTE_ 
%token <ident> ID_
%token <cent> 

%type<aux> listaDeclaraciones declaracion tipoSimple declaracionFuncion cabeceraFuncion parametrosFormales
%type<aux> parametrosActuales listaParametrosActuales operadorUnario 

%type<arg> parametrosFormales listaParametrosFormales

%type<expre> expresionOpcional expresion expresionIgualdad expresionRelacional expresionAditiva expresionMultiplicativa 
%type<expre> expresionUnaria expresionSufija constante




%%
programa                        : { niv = GLOBAL; dvar = 0; cargaContexto(niv); } 
                                listaDeclaraciones
                                {
                                    if ($2 == 0) yyerror("El programa no tiene main")
                                }
                                ;

listaDeclaraciones              : declaracion 
                                {
                                    $$ = $1
                                } 
                                | listaDeclaraciones declaracion
                                {
                                    if ($1 == 0)        $$ = $2;
                                    else if ($2 == 0)   $$ = $1;
                                        else yyerror("El programa tiene mas de un main")
                                }

                                ;

declaracion                     : declaracionVariable
                                | declaracionFuncion
                                ;

declaracionVariable             : tipoSimple ID_ PTOCOMA_
                                    {
                                        SIMB sim = obtTdS($2);
                                        if (sim.tipo == T_ERROR) {
                                            yyerror("Variable ya declarada");
                                        }
                                        else {
                                            insTdS($2, VARIABLE, $1, niv, dvar, -1);
                                            dvar += TALLA_TIPO_SIMPLE;
                                        }
                                    }
                                | tipoSimple ID_ ACORCH_ CTE_ CCORCH_ PTOCOMA_
                                    {
                                        SIMB sim = obtTdS($2);
                                        if (sim.tipo == T_ERROR) {
                                            yyerror("Variable ya declarada");
                                        }
                                        else {
                                            ref = insTdA($1, $4);
                                            insTdS($2, VARIABLE, T_ARRAY, niv, dvar, ref);
                                            dvar += TALLA_TIPO_SIMPLE * $4;
                                        }
                                    }
                                ;

tipoSimple                      : INT_ { $$ = T_ENTERO }
                                | BOOL_ { $$ = T_LOGICO }
                                ;

declaracionFuncion              : cabeceraFuncion bloque
                                ;

cabeceraFuncion                 : tipoSimple ID_ APAREN_ parametrosFormales CPAREN_
                                    {
                                        INF inf = obtTdS($2);
                                        if(inf.tipo == T_ERROR) {
                                            yyerror("Error, funcion ya definida");
                                        }
                                        else {
                                            insTdS($2, FUNCION, $1, niv, dvar, $4.ref);
                                        }
                                    }
                                ;

parametrosFormales              : 
                                    {
                                        int ref = insTdD(-1, T_VACIO);
                                        $$.talla = 0;
                                        $$.ref = ref;
                                    }
                                | listaParametrosFormales
                                ;

listaParametrosFormales         : tipoSimple ID_
                                    {
                                        int ref = insTdD(-1, $1);
                                        $$.talla = TALLA_TIPO_SIMPLE;
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
                                        $$.talla += TALLA_TIPO_SIMPLE;
                                        $$.ref = $4.ref;
                                    }
                                ;

bloque                          : ALLAVE_ declaracionVariableLocal listaInstrucciones RETURN_ expresion PTOCOMA_ CLLAVE_
                                ;

declaracionVariableLocal        : 
                                | declaracionVariableLocal declaracionVariable
                                ;

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
                                | ID_ ACORCH_ expresion CCORCH_ ASIG_ expresion PTOCOMA_
                                ;

instruccionEntradaSalida        : READ_ APAREN_ ID_ CPAREN_ PTOCOMA_
                                {
                                    SIMB sim = obtTdS($3);
                                    if (sim.tipo == T_ERROR) {
                                        yyerror("Error en instruccionEntradSalida, variable no declarada.");                                    
                                    }
                                    else if (sim.tipo != T_ENTERO) {
                                        yyerror("Error en instruccionEntradSalida, la variable ha de ser de tipo entero.");
                                    }
                                }
                                | PRINT_ APAREN_ expresion CPAREN_ PTOCOMA_
                                {
                                    if ($3.tipo != T_ERROR && t.tipo != T_ENTERO){
                                        yyerror("Error en instruccionEntradSalida, la variable ha de ser de tipo entero.");
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
                                ;

expresionOpcional               : 
                                | expresion
                                | ID_ ASIG_ expresion
                                ;

expresion                       : expresionigualdad
                                | expresion operadorLogico expresionigualdad
                                ;

expresionIgualdad               : expresionRelacional
                                | expresionigualdad operadorigualdad expresionRelacional
                                ;

expresionRelacional             : expresionAditiva
                                | expresionRelacional operadorRelacional expresionAditiva
                                ;

expresionAditiva                : expresionMultiplicativa
                                | expresionAditiva operadorAditivo expresionMultiplicativa
                                ;

expresionMultiplicativa         : expresionUnaria
                                | expresionMultiplicativa operadorMultiplicativo expresionUnaria
                                ;

expresionUnaria                 : expresionSufija
                                {
                                    $$.tipo = $1.tipo;
                                }
                                | operadorUnario expresionUnaria
                                {
                                    $$.tipo = T_ERROR;
                                    if ($1.tipo != $2.tipo){
                                        yyerror("Error en expresionUnaria, variable no declarada.")
                                    }
                                }
                                | operadorIncremento ID_
                                {
                                    $$.tipo = T_ERROR;
                                    SIMB sim = obtTdS($2);
                                    if (sim.tipo == T_ERROR) {
                                        yyerror("Error en expresionUnaria, variable no declarada.");
                                    }
                                    else if (sim.tipo != T_ENTERO){
                                        yyerror("Error en expresionUnaria, variable ha de ser de tipo entero");
                                    }
                                    else {
                                        $$.tipo = T_ENTERO;
                                    }
                                }
                                ;

expresionSufija                 : APAREN_ expresion CPAREN_
                                | ID_ operadorIncremento
                                | ID_ ACORCH_ expresion CCORCH_
                                | ID_ APAREN_ parametrosActuales CPAREN_
                                
                                | ID_
                                | constante
                                ;

parametrosActuales              : 
                                | listaParametrosActuales
                                ;

listaParametrosActuales         : expresion
                                | expresion CMA_ listaParametrosActuales
                                ;


/***************************************************/

constante                       : CTE_ {$$ = CTE;}
                                | TRUE_ {$$ = TRUE;}
                                | FALSE_ {$$ = FALSE;}
                                ;

operadorLogico                  :AND_ {$$ = AND;}
                                |OR_ {$$ = OR;}
                                ;

operadorigualdad                :IGUAL_ {$$ = IGUAL;}
                                |NOIGUAL_ {$$ = NOIGUAL;}
                                ;

operadorRelacional              : MAY_ {$$ = MAY;}
                                | MEN_ {$$ = MEN;}
                                | MAYIGUAL_ {$$ = MAYIGUAL;}
                                | MENIGUAL_ {$$ = MAYIGUAL;}
                                ;

operadorAditivo                 : MAS_ {$$ = MAS_UN;}
                                | MENOS_ {$$ = MENOS_UN;}
                                ;

operadorMultiplicativo          : POR_ {$$ = POR;}
                                | DIV_ {$$ = DIV;}
                                | MOD_ {$$ = MOD;}
                                ;

operadorUnario                  : MAS_ {$$ = MAS_UN;}
                                | MENOS_ {$$ = MENOS_UN;}
                                | NOT_ {$$ = NOT_UN;}
                                ;

operadorIncremento              : INC_ {$$ = INC;}
                                | DEC_  {$$ = DEC;}
                                ;