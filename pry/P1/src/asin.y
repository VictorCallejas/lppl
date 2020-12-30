%{
#include <stdio.h>
#include "header.h"
%}

%token CTE_ ID_
%token WHILE_ FOR_ IF_ ELSE_ TRUE_ FALSE_ PRINT_ READ_ RETURN_
%token INT_ BOOL_
%token ALLAVE_  CLLAVE_ ACORCH_  CCORCH_ APAREN_ CPAREN_ PTOCOMA_ PTO_ CMA_
%token MAS_ MENOS_ POR_ DIV_
%token AND_ OR_ SUMASIG_ RESASIG_ MULASIG_ DIVASIG_ IGUAL_ NOIGUAL_ MAYIGUAL_ MENIGUAL_ INC_ DEC_  MAY_ MEN_ ASIG_ NOT_ MOD_

%%
programa                        : listaDeclaraciones
                                ;

listaDeclaraciones              : declaracion
                                | listaDeclaraciones declaracion
                                ;

declaracion                     : declaracionVariable
                                | declaracionFuncion
                                ;

declaracionVariable             : tipoSimple ID_ PTOCOMA_
                                | tipoSimple ID_ ACORCH_ CTE_ CCORCH_ PTOCOMA_
                                ;

tipoSimple                      : INT_
                                | BOOL_
                                ;

declaracionFuncion              : cabeceraFuncion bloque
                                ;

cabeceraFuncion                 : tipoSimple ID_ APAREN_ parametrosFormales CPAREN_
                                ;

parametrosFormales              :
                                | listaParametrosFormales
                                ;

listaParametrosFormales         : tipoSimple ID_
                                | tipoSimple ID_ CMA_ listaParametrosFormales
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
                                | PRINT_ APAREN_ expresion CPAREN_ PTOCOMA_
                                ;

instruccionSeleccion            : IF_ APAREN_ expresion CPAREN_ instruccion ELSE_ instruccion
                                ;

instruccionIteracion            : FOR_ APAREN_ expresionOpcional PTOCOMA_ expresion PTOCOMA_ expresionOpcional CPAREN_ instruccion
                                ;

expresionOpcional               :
                                | expresion
                                | ID_ ASIG_ expresion
                                ;

expresion                       : expresionIgualdad
                                | expresion operadorLogico expresionIgualdad
                                ;

expresionIgualdad               : expresionRelacional
                                | expresionIgualdad operadorIgualdad expresionRelacional
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
                                | operadorUnario expresionUnaria
                                | operadorIncremento ID_
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


constante                       : CTE_
                                | TRUE_
                                | FALSE_
                                ;

operadorLogico                  : AND_
                                | OR_
                                ;

operadorIgualdad                : IGUAL_
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
                                ;

operadorUnario                  : MAS_
                                | MENOS_
                                | NOT_
                                ;

operadorIncremento              : INC_
                                | DEC_
                                ;