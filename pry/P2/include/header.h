/*****************************************************************************/
/**   Ejemplo de un posible fichero de cabeceras donde situar las           **/
/** definiciones de constantes, variables y estructuras para MenosC.        **/
/** Los alumnos deberán adaptarlo al desarrollo de su propio compilador.     **/
/*****************************************************************************/

/***************** Para ver ultima linea ejecutada antes de un seg fault */
#define TRAZA printf("Linea %d",__LINE__)
/********************************/
#ifndef _HEADER_H
#define _HEADER_H



/* Operador Logico*/
#define OP_AND 0
#define OP_OR  1

/* Operador igualdad */
#define OP_IGUAL    0
#define OP_NOIGUAL 1

/* Operador relacional */
#define OP_MAYOR   0
#define OP_MAYORIG 1
#define OP_MENOR   2
#define OP_MENORIG 3

/* Operador aditivo */
#define OP_SUMA  0
#define OP_RESTA 1

/* Operador multiplicativo */
#define OP_MULT 0
#define OP_DIV  1
#define OP_MOD  2

/* Operador unario */
#define OP_MAS   0
#define OP_MENOS 1
#define OP_NOT   2

/* Operador incremento */
#define OP_INC 0
#define OP_DEC 1


/************************************* Constantes simbólicas P2 */
#define TRUE 1
#define FALSE 0
#define GLOBAL 0
#define LOCAL 1
#define TALLA_TIPO_SIMPLE 1 /* Talla asociada a los tipos simples */
#define TALLA_SEGENLACES 2 /* Talla del segmento de Enlaces de Control */

/************************************* Variables Globales P2 */
extern int verTdS; /* Flag para saber si mostrar la TdS */
extern int dvar; /* Desplazamiento en el Segmento de Variables */
extern int niv; /* Nivel de anidamiento "global" o "local" */

/************************************* Variables externas definidas en el AL */
extern int yylex();
extern int yyparse();

extern FILE *yyin;                           /* Fichero de entrada           */
extern int   yylineno;                       /* Contador del numero de linea */
extern char *yytext;                         /* Patron detectado             */
/********* Funciones y variables externas definidas en el Programa Principal */
extern void yyerror(const char * msg) ;   /* Tratamiento de errores          */

extern int verbosidad;                   /* Flag si se desea una traza       */
extern int numErrores;              /* Contador del numero de errores        */



/************************************************ Struct para las expresiones */
typedef struct expre {
    int valor;
    int tipo;
} EXPR;

#endif  /* _HEADER_H */
/*****************************************************************************/
