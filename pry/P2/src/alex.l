%{
#include <stdio.h>
#include "header.h"
#include "asin.h"

#define  return(x) {if (verbosidad) ECHO; return(x);}
%}

%option yylineno

delimitador     [ \t\n]+
identificador   [_a-zA-Z][_a-zA-Z0-9]*
numero          [0-9]+("."[0-9]*)?|[0-9]*"."[0-9]+
comentario      \/\/.*\n

%%


{delimitador}  {if (verbosidad) ECHO ; }
{comentario}   {if (verbosidad){  ECHO;  }}

"true"         {return (TRUE_) ;}
"false"        {return (FALSE_) ;}

"print"        {return (PRINT_) ;}
"read"         {return (READ_) ;}

"return"       {return (RETURN_); }

"struct"       {return (FALSE_) ;}
"int"          {return (INT_);}
"bool"         {return (BOOL_) ;}

"while"        {return (WHILE_) ;}
"for"          {return (FOR_) ;}
"if"           {return (IF_) ;}
"else"         {return (ELSE_) ;}

"+"		 	   { return (MAS_) ; }
"-"            { return (MENOS_) ; }
"*"            { return (POR_) ; }
"/"            { return (DIV_) ; }

"&&"		   { return(AND_); }
"||"		   { return(OR_); }
"+="		   { return(SUMASIG_); }
"-="		   { return(RESASIG_); }
"*="		   { return(MULASIG_); }
"/="		   { return(DIVASIG_); }
"=="		   { return(IGUAL_); }
"!="		   { return(NOIGUAL_); }
">="		   { return(MAYIGUAL_); }
"<="		   { return(MENIGUAL_); }
"++"		   { return(INC_); }
"--"		   { return(DEC_); }
">"		       { return(MAY_); }
"<"		       { return(MEN_); }
"="		       { return(ASIG_); }
"!"		       { return(NOT_); }
"%"		       { return(MOD_); }

"{"            { return(ALLAVE_); fprintf(stdout,"%3d.- ",yylineno); }
"}"            { return(CLLAVE_); }
"["            { return(ACORCH_); }
"]"            { return(CCORCH_); }
"("            { return(APAREN_);  }
")"            { return(CPAREN_);   }
";"            { return(PTOCOMA_); }
"."            { return(PTO_); }
","            { return(CMA_); }

{numero}        {yylval.cent = atoi(yytext); return (CTE_) ; }
{identificador}     {yylval.cent = strdup(yytext); return (ID_); }
.		{ yyerror("Caracter desconocido") ;}

%%