%{
#include <stdio.h>
#include "header.h"
#include "asin.h"
#include <string.h>

#define  retornar(x) {if (verbosidad) ECHO; return(x);}
%}

%option yylineno

delimitador    [ \t\n]+
digito         [0-9]
entero         {digito}+
letra          [a-zA-Z]
constante      {entero}|("."){entero}|{entero}(".")|{entero}("."){entero}
identificador {letra}({letra}|{digito}|_)*
comentario     \/\/.*


%%
{delimitador}  { if(verbosidad) ECHO ; }
{comentario}   { if(verbosidad) {ECHO; printf("  %d.-", yylineno);}  }
"\n"           { if(verbosidad) {ECHO; printf("  %d.-", yylineno);}  }

"true"         {retornar (TRUE_) ;}
"false"        {retornar (FALSE_) ;}

"print"        {retornar (PRINT_) ;}
"read"         {retornar (READ_) ;}

"return"       {retornar (RETURN_); }

"struct"       {retornar (FALSE_) ;}
"int"          {retornar (INT_);}
"bool"         {retornar (BOOL_) ;}

"while"        {retornar (WHILE_) ;}
"for"          {retornar (FOR_) ;}
"if"           {retornar (IF_) ;}
"else"         {retornar (ELSE_) ;}

"+"		 	   { retornar (MAS_) ; }
"-"            { retornar (MENOS_) ; }
"*"            { retornar (POR_) ; }
"/"            { retornar (DIV_) ; }

"&&"		   { retornar(AND_); }
"||"		   { retornar(OR_); }
"+="		   { retornar(SUMASIG_); }
"-="		   { retornar(RESASIG_); }
"*="		   { retornar(MULASIG_); }
"/="		   { retornar(DIVASIG_); }
"=="		   { retornar(IGUAL_); }
"!="		   { retornar(NOIGUAL_); }
">="		   { retornar(MAYIGUAL_); }
"<="		   { retornar(MENIGUAL_); }
"++"		   { retornar(INC_); }
"--"		   { retornar(DEC_); }
">"		       { retornar(MAY_); }
"<"		       { retornar(MEN_); }
"="		       { retornar(ASIG_); }
"!"		       { retornar(NOT_); }
"%"		       { retornar(MOD_); }

"{"            { retornar(ALLAVE_); }
"}"            { retornar(CLLAVE_); }
"["            { retornar(ACORCH_); }
"]"            { retornar(CCORCH_); }
"("            { retornar(APAREN_);  }
")"            { retornar(CPAREN_);   }
";"            { retornar(PTOCOMA_); }
"."            { retornar(PTO_); }
","            { retornar(CMA_); }

{constante}            { yylval.cent = atoi(yytext); retornar (CTE_); }
{identificador}     { yylval.ident = strdup(yytext); retornar (ID_); }
.		            { yyerror("Caracter desconocido") ;}

%%