/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "src/asin.y"

#include <stdio.h>
#include <string.h>
#include "header.h"
#include "libtds.h"

#line 77 "asin.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_ASIN_H_INCLUDED
# define YY_YY_ASIN_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    WHILE_ = 258,
    FOR_ = 259,
    IF_ = 260,
    ELSE_ = 261,
    TRUE_ = 262,
    FALSE_ = 263,
    PRINT_ = 264,
    READ_ = 265,
    RETURN_ = 266,
    INT_ = 267,
    BOOL_ = 268,
    ALLAVE_ = 269,
    CLLAVE_ = 270,
    ACORCH_ = 271,
    CCORCH_ = 272,
    APAREN_ = 273,
    CPAREN_ = 274,
    PTOCOMA_ = 275,
    PTO_ = 276,
    CMA_ = 277,
    MAS_ = 278,
    MENOS_ = 279,
    POR_ = 280,
    DIV_ = 281,
    AND_ = 282,
    OR_ = 283,
    SUMASIG_ = 284,
    RESASIG_ = 285,
    MULASIG_ = 286,
    DIVASIG_ = 287,
    IGUAL_ = 288,
    NOIGUAL_ = 289,
    MAYIGUAL_ = 290,
    MENIGUAL_ = 291,
    INC_ = 292,
    DEC_ = 293,
    MAY_ = 294,
    MEN_ = 295,
    ASIG_ = 296,
    NOT_ = 297,
    MOD_ = 298,
    CTE_ = 299,
    ID_ = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 8 "src/asin.y"

    char* ident;            // Para el terminal "identificador"
    int cent;               // Para el terminal "cte" entera
    int aux;                // Para los no terminales con atributo simple
    EXPR expre;             // Para los no terminales expresion
    ARGU arg;               // Para los argumentos

#line 183 "asin.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_ASIN_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   155

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  46
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  41
/* YYNRULES -- Number of rules.  */
#define YYNRULES  84
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  147

#define YYUNDEFTOK  2
#define YYMAXUTOK   300


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    45,    45,    45,    52,    56,    71,    76,    82,    91,
     108,   113,   134,   133,   150,   149,   168,   171,   178,   194,
     201,   215,   216,   219,   220,   223,   224,   225,   226,   227,
     230,   244,   274,   284,   293,   292,   305,   304,   313,   315,
     321,   330,   334,   348,   352,   367,   370,   384,   388,   400,
     404,   416,   420,   440,   456,   460,   474,   497,   519,   530,
     535,   536,   539,   540,   544,   547,   548,   551,   552,   555,
     556,   559,   560,   561,   562,   565,   566,   569,   570,   571,
     574,   575,   576,   579,   580
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "WHILE_", "FOR_", "IF_", "ELSE_",
  "TRUE_", "FALSE_", "PRINT_", "READ_", "RETURN_", "INT_", "BOOL_",
  "ALLAVE_", "CLLAVE_", "ACORCH_", "CCORCH_", "APAREN_", "CPAREN_",
  "PTOCOMA_", "PTO_", "CMA_", "MAS_", "MENOS_", "POR_", "DIV_", "AND_",
  "OR_", "SUMASIG_", "RESASIG_", "MULASIG_", "DIVASIG_", "IGUAL_",
  "NOIGUAL_", "MAYIGUAL_", "MENIGUAL_", "INC_", "DEC_", "MAY_", "MEN_",
  "ASIG_", "NOT_", "MOD_", "CTE_", "ID_", "$accept", "programa", "$@1",
  "listaDeclaraciones", "declaracion", "declaracionVariable", "tipoSimple",
  "declaracionFuncion", "@2", "cabeceraFuncion", "$@3", "bloque",
  "parametrosFormales", "listaParametrosFormales",
  "declaracionVariableLocal", "listaInstrucciones", "instruccion",
  "instruccionAsignacion", "instruccionEntradaSalida",
  "instruccionSeleccion", "$@4", "instruccionIteracion", "$@5",
  "expresionOpcional", "expresion", "expresionIgualdad",
  "expresionRelacional", "expresionAditiva", "expresionMultiplicativa",
  "expresionUnaria", "expresionSufija", "parametrosActuales",
  "listaParametrosActuales", "constante", "operadorLogico",
  "operadorigualdad", "operadorRelacional", "operadorAditivo",
  "operadorMultiplicativo", "operadorUnario", "operadorIncremento", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300
};
# endif

#define YYPACT_NINF (-110)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
    -110,     6,   116,  -110,  -110,  -110,   116,  -110,  -110,   -20,
    -110,  -110,  -110,   -15,    14,   -11,  -110,    24,  -110,  -110,
      34,   116,   116,    33,    18,    56,  -110,  -110,    36,    -2,
    -110,    62,  -110,   -15,    69,    71,    83,    87,    23,  -110,
      21,  -110,  -110,  -110,  -110,  -110,   116,    32,    23,    23,
      54,  -110,  -110,    23,  -110,  -110,  -110,  -110,  -110,  -110,
      48,    84,    99,    91,   111,    53,  -110,  -110,  -110,    23,
      94,     9,    23,    23,  -110,    11,    96,   109,    75,    79,
     119,    81,    23,    23,  -110,   125,  -110,  -110,    23,  -110,
    -110,    23,  -110,  -110,  -110,  -110,    23,  -110,  -110,    23,
    -110,  -110,  -110,    23,  -110,  -110,  -110,    63,    90,    23,
      23,  -110,   121,   122,  -110,    65,    97,   124,  -110,  -110,
      99,    91,   111,    53,  -110,    73,  -110,   109,    93,    12,
    -110,  -110,  -110,    23,  -110,    23,    32,   138,  -110,    95,
     126,    12,  -110,  -110,  -110,    12,  -110
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     1,    10,    11,     3,     4,     6,     0,
       7,    12,     5,    14,     0,     0,     8,     0,    21,    13,
       0,    17,    23,     0,     0,     0,    18,    22,     0,     0,
       9,    19,    15,     0,     0,     0,     0,     0,     0,    23,
       0,    24,    26,    28,    27,    29,     0,    38,     0,     0,
       0,    65,    66,     0,    80,    81,    83,    84,    82,    64,
      58,     0,    41,    43,    45,    47,    49,    51,    59,     0,
       0,     0,     0,     0,    20,    58,     0,    39,     0,     0,
       0,     0,     0,    60,    55,     0,    67,    68,     0,    69,
      70,     0,    73,    74,    71,    72,     0,    75,    76,     0,
      77,    78,    79,     0,    52,    53,    25,     0,     0,     0,
       0,    34,     0,     0,    54,     0,    62,     0,    61,    16,
      42,    44,    46,    48,    50,     0,    30,    40,     0,     0,
      33,    32,    56,     0,    57,     0,    38,     0,    63,     0,
       0,     0,    31,    36,    35,     0,    37
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -110,  -110,  -110,  -110,   140,   127,    37,  -110,  -110,  -110,
    -110,  -110,  -110,   101,  -110,   112,  -109,  -110,  -110,  -110,
    -110,  -110,  -110,    16,   -38,    60,    59,    57,    55,   -65,
    -110,  -110,    22,  -110,  -110,  -110,  -110,  -110,  -110,  -110,
      13
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     2,     6,     7,     8,     9,    10,    14,    11,
      17,    19,    25,    26,    22,    29,    41,    42,    43,    44,
     129,    45,   145,    76,    77,    62,    63,    64,    65,    66,
      67,   117,   118,    68,    88,    91,    96,    99,   103,    69,
      70
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      61,    15,    34,    35,   104,    16,     3,    36,    37,    38,
      78,    79,    39,    34,    35,    81,    34,    35,    36,    37,
     137,    36,    37,    39,   106,    13,    39,    82,    18,    83,
      51,    52,   144,    20,   107,   108,   146,    72,   124,    51,
      52,    53,    21,    40,   115,   116,    54,    55,    56,    57,
      53,    23,   109,    30,    40,    54,    55,    40,    24,    28,
      56,    57,    73,    31,    82,    58,    83,    59,    60,    56,
      57,   127,   128,    84,    58,    32,    59,    75,   100,   101,
     125,    33,   132,    24,    46,    56,    57,    47,    84,    48,
      86,    87,    86,    87,   111,   116,   102,   139,   112,    80,
     114,    49,    86,    87,    85,    50,    86,    87,    86,    87,
     126,    86,    87,   136,   135,   142,   110,    86,    87,   133,
      86,    87,    86,    87,    86,    87,    92,    93,     4,     5,
      94,    95,    89,    90,    97,    98,    86,    87,   113,   105,
     119,   130,   131,   134,   141,   143,    12,    74,   120,    27,
     121,    71,   140,   122,   123,   138
};

static const yytype_uint8 yycheck[] =
{
      38,    16,     4,     5,    69,    20,     0,     9,    10,    11,
      48,    49,    14,     4,     5,    53,     4,     5,     9,    10,
     129,     9,    10,    14,    15,    45,    14,    16,    14,    18,
       7,     8,   141,    44,    72,    73,   145,    16,   103,     7,
       8,    18,    18,    45,    82,    83,    23,    24,    37,    38,
      18,    17,    41,    20,    45,    23,    24,    45,    21,    22,
      37,    38,    41,    45,    16,    42,    18,    44,    45,    37,
      38,   109,   110,    60,    42,    19,    44,    45,    25,    26,
      17,    45,    17,    46,    22,    37,    38,    18,    75,    18,
      27,    28,    27,    28,    19,   133,    43,   135,    19,    45,
      19,    18,    27,    28,    20,    18,    27,    28,    27,    28,
      20,    27,    28,    20,    41,    20,    20,    27,    28,    22,
      27,    28,    27,    28,    27,    28,    35,    36,    12,    13,
      39,    40,    33,    34,    23,    24,    27,    28,    19,    45,
      15,    20,    20,    19,     6,    19,     6,    46,    88,    22,
      91,    39,   136,    96,    99,   133
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    47,    48,     0,    12,    13,    49,    50,    51,    52,
      53,    55,    50,    45,    54,    16,    20,    56,    14,    57,
      44,    18,    60,    17,    52,    58,    59,    51,    52,    61,
      20,    45,    19,    45,     4,     5,     9,    10,    11,    14,
      45,    62,    63,    64,    65,    67,    22,    18,    18,    18,
      18,     7,     8,    18,    23,    24,    37,    38,    42,    44,
      45,    70,    71,    72,    73,    74,    75,    76,    79,    85,
      86,    61,    16,    41,    59,    45,    69,    70,    70,    70,
      45,    70,    16,    18,    86,    20,    27,    28,    80,    33,
      34,    81,    35,    36,    39,    40,    82,    23,    24,    83,
      25,    26,    43,    84,    75,    45,    15,    70,    70,    41,
      20,    19,    19,    19,    19,    70,    70,    77,    78,    15,
      71,    72,    73,    74,    75,    17,    20,    70,    70,    66,
      20,    20,    17,    22,    19,    41,    20,    62,    78,    70,
      69,     6,    20,    19,    62,    68,    62
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    46,    48,    47,    49,    49,    50,    50,    51,    51,
      52,    52,    54,    53,    56,    55,    57,    58,    58,    59,
      59,    60,    60,    61,    61,    62,    62,    62,    62,    62,
      63,    63,    64,    64,    66,    65,    68,    67,    69,    69,
      69,    70,    70,    71,    71,    72,    72,    73,    73,    74,
      74,    75,    75,    75,    76,    76,    76,    76,    76,    76,
      77,    77,    78,    78,    79,    79,    79,    80,    80,    81,
      81,    82,    82,    82,    82,    83,    83,    84,    84,    84,
      85,    85,    85,    86,    86
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     2,     1,     2,     1,     1,     3,     6,
       1,     1,     0,     3,     0,     6,     7,     0,     1,     2,
       4,     0,     2,     0,     2,     3,     1,     1,     1,     1,
       4,     7,     5,     5,     0,     8,     0,    10,     0,     1,
       3,     1,     3,     1,     3,     1,     3,     1,     3,     1,
       3,     1,     2,     2,     3,     2,     4,     4,     1,     1,
       0,     1,     1,     3,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 45 "src/asin.y"
                                { niv = GLOBAL; dvar = 0; cargaContexto(niv);}
#line 1475 "asin.c"
    break;

  case 3:
#line 47 "src/asin.y"
                                    {
                                        if ((yyvsp[0].aux) == 0) yyerror("El programa no tiene main");
                                    }
#line 1483 "asin.c"
    break;

  case 4:
#line 53 "src/asin.y"
                                    {
                                        (yyval.aux) = (yyvsp[0].aux);
                                    }
#line 1491 "asin.c"
    break;

  case 5:
#line 57 "src/asin.y"
                                    {
                                        if ((yyvsp[-1].aux) == 0){
                                            (yyval.aux) = (yyvsp[0].aux);
                                        }
                                        else if((yyvsp[0].aux) == 0){
                                            (yyval.aux) = (yyvsp[-1].aux);
                                        }
                                        else{
                                            TRAZA;
                                            yyerror("El programa tiene mas de un main");
                                        }
                                    }
#line 1508 "asin.c"
    break;

  case 6:
#line 72 "src/asin.y"
                                {
                                    (yyval.aux) = 0;
                                }
#line 1516 "asin.c"
    break;

  case 7:
#line 77 "src/asin.y"
                                {
                                    (yyval.aux) = (yyvsp[0].aux);
                                }
#line 1524 "asin.c"
    break;

  case 8:
#line 84 "src/asin.y"
                                    {
                                        if (insTdS((yyvsp[-1].ident), VARIABLE, (yyvsp[-2].aux), niv, dvar, -1) == 0) {
                                            yyerror("Error en declaracionVariable, variable ya declarada");
                                        } else {
                                            dvar += TALLA_TIPO_SIMPLE;
                                        }
                                    }
#line 1536 "asin.c"
    break;

  case 9:
#line 95 "src/asin.y"
                                    {
                                        if (!insTdS((yyvsp[-4].ident), VARIABLE, T_ARRAY, niv, dvar, insTdA((yyvsp[-5].aux),(yyvsp[-2].cent)))){
                                            yyerror("Error en declaracionVariable, variable ya declarada");
                                        }
                                        else if( (yyvsp[-2].cent) <= 0 ){
                                            yyerror("Error en declaracionVariable, indice ha de ser mayor de cero");
                                        }
                                        else {
                                            dvar += TALLA_TIPO_SIMPLE * (yyvsp[-2].cent);
                                        }
                                    }
#line 1552 "asin.c"
    break;

  case 10:
#line 110 "src/asin.y"
                                    {
                                        (yyval.aux) = T_ENTERO;
                                    }
#line 1560 "asin.c"
    break;

  case 11:
#line 115 "src/asin.y"
                                    {
                                        (yyval.aux) = T_LOGICO;
                                    }
#line 1568 "asin.c"
    break;

  case 12:
#line 134 "src/asin.y"
                                    {
                                        (yyval.aux) = dvar;
                                        dvar = 0;
                                    }
#line 1577 "asin.c"
    break;

  case 13:
#line 139 "src/asin.y"
                                    {
                                        if (verTdS) mostrarTdS();
                                        descargaContexto(niv);
                                        niv=GLOBAL;
                                        // Es dos porque el corchete de arriba actua como otro elemento y nosotros almacenamos dvar en $<aux>$
                                        dvar = (yyvsp[-1].aux);
                                        (yyval.aux) = (yyvsp[-2].aux);
                                    }
#line 1590 "asin.c"
    break;

  case 14:
#line 150 "src/asin.y"
                                    {
                                        niv = LOCAL;
                                        cargaContexto(niv);
                                    }
#line 1599 "asin.c"
    break;

  case 15:
#line 155 "src/asin.y"
                                    {
                                        if(strcmp((yyvsp[-4].ident), "main") == 0){
                                            (yyval.aux) = 1;
                                        }
                                        else{
                                            (yyval.aux) = 0;
                                        }
                                        if(!insTdS((yyvsp[-4].ident), FUNCION, (yyvsp[-5].aux), niv, dvar, (yyvsp[-1].arg).ref)) {
                                            yyerror("Error en cabeceraFuncion, funcion ya definida");
                                        }
                                    }
#line 1615 "asin.c"
    break;

  case 17:
#line 173 "src/asin.y"
                                    {
                                        int ref = insTdD(-1, T_VACIO);
                                        (yyval.arg).talla = 0;
                                        (yyval.arg).ref = ref;
                                    }
#line 1625 "asin.c"
    break;

  case 18:
#line 180 "src/asin.y"
                                    {
                                        (yyval.arg).talla = (yyvsp[0].arg).talla - TALLA_SEGENLACES;
                                    }
#line 1633 "asin.c"
    break;

  case 19:
#line 195 "src/asin.y"
                                    {
                                        int ref = insTdD(-1, (yyvsp[-1].aux));
                                        (yyval.arg).talla = TALLA_TIPO_SIMPLE + TALLA_SEGENLACES;
                                        (yyval.arg).ref = ref;
                                        insTdS((yyvsp[0].ident), PARAMETRO, (yyvsp[-1].aux), niv, dvar, -1);
                                    }
#line 1644 "asin.c"
    break;

  case 20:
#line 202 "src/asin.y"
                                    {
                                        INF dom = obtTdD((yyvsp[0].arg).ref);
                                        if(dom.tipo != T_ERROR) {
                                            yyerror("Error, campo ya declarado");
                                        }

                                        insTdD((yyvsp[0].arg).ref, (yyvsp[-3].aux));
                                        (yyval.arg).talla += TALLA_TIPO_SIMPLE + TALLA_SEGENLACES;
                                        (yyval.arg).ref = (yyvsp[0].arg).ref;
                                        insTdS((yyvsp[-2].ident), PARAMETRO, (yyvsp[-3].aux), niv, dvar, -1);
                                    }
#line 1660 "asin.c"
    break;

  case 30:
#line 232 "src/asin.y"
                                    {
                                        SIMB simb = obtTdS((yyvsp[-3].ident));
                                        if ((yyvsp[-1].expre).tipo == T_ERROR){
                                            // No hacemos nada el mensaje ya ha sido mostrado
                                        }
                                        else if (simb.t == T_ERROR) {
                                            yyerror("Error en instruccionAsignacion, variable no declarada.");
                                        }
                                        else if(simb.t != (yyvsp[-1].expre).tipo){
                                            yyerror("Error en instruccionAsignacion, el tipo de la variable no coincide con la expresión");
                                        }
                                    }
#line 1677 "asin.c"
    break;

  case 31:
#line 247 "src/asin.y"
                                    {

                                        SIMB simb = obtTdS((yyvsp[-6].ident));
                                        if ((yyvsp[-1].expre).tipo == T_ERROR){
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
                                            else if ((yyvsp[-4].expre).tipo != T_ENTERO){
                                                yyerror("Error en instruccionAsignacion, la expresion del indice no es de tipo entero.");
                                            }
                                            else if ((yyvsp[-1].expre).tipo != array.telem){
                                                yyerror("Error en instruccionAsignacion, el tipo de la expresion no es igual al tipo de los elementos");
                                            }
                                        }
                                    }
#line 1707 "asin.c"
    break;

  case 32:
#line 275 "src/asin.y"
                                {
                                    SIMB simb = obtTdS((yyvsp[-2].ident));
                                    if (simb.t == T_ERROR) {
                                        yyerror("Error en instruccionEntradSalida, variable no declarada.");
                                    }
                                    else if (simb.t != T_ENTERO) {
                                        yyerror("Error en instruccionEntradSalida, la variable ha de ser de tipo entero.");
                                    }
                                }
#line 1721 "asin.c"
    break;

  case 33:
#line 285 "src/asin.y"
                                {
                                    if ((yyvsp[-2].expre).tipo != T_ERROR && (yyvsp[-2].expre).tipo != T_ENTERO){
                                        yyerror("Error en instruccionEntradSalida, la variable ha de ser de tipo entero.");
                                    }
                                }
#line 1731 "asin.c"
    break;

  case 34:
#line 293 "src/asin.y"
                                {
                                    if ((yyvsp[-1].expre).tipo == T_ERROR ){
                                        // EL error ya ha sido mostrado
                                    }
                                    else if ((yyvsp[-1].expre).tipo != T_LOGICO){
                                        yyerror("Error en instruccionSeleccion, la expresion ha de ser de tipo lógico.");
                                    }
                                }
#line 1744 "asin.c"
    break;

  case 36:
#line 305 "src/asin.y"
                                {
                                    if((yyvsp[-3].expre).tipo != T_LOGICO) {
                                        yyerror("Error en instruccionIteracion, la condicion no es logica");
                                    }
                                }
#line 1754 "asin.c"
    break;

  case 38:
#line 313 "src/asin.y"
                                         { (yyval.expre).tipo == T_VACIO;
                                    }
#line 1761 "asin.c"
    break;

  case 39:
#line 316 "src/asin.y"
                                    {
                                        if((yyvsp[0].expre).tipo != T_LOGICO) {
                                            yyerror("Error en expresionOpcional, la expresion no es logica.");
                                        }
                                    }
#line 1771 "asin.c"
    break;

  case 40:
#line 322 "src/asin.y"
                                    {
                                        if((yyvsp[0].expre).tipo != T_LOGICO) {
                                            yyerror("Error en expresionOpcional, la expresion no es logica.");
                                        }
                                    }
#line 1781 "asin.c"
    break;

  case 41:
#line 331 "src/asin.y"
                                    {
                                        (yyval.expre) = (yyvsp[0].expre);
                                    }
#line 1789 "asin.c"
    break;

  case 42:
#line 335 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        if((yyvsp[-2].expre).tipo == T_ARRAY){
                                            yyerror("Esto esta mal");
                                        }
                                        if((yyvsp[-2].expre).tipo != (yyvsp[0].expre).tipo) {
                                            yyerror("Error en expresion, los tipos no coinciden");
                                        }
                                        else {
                                            (yyval.expre).tipo = (yyvsp[-2].expre).tipo;
                                        }
                                    }
#line 1806 "asin.c"
    break;

  case 43:
#line 349 "src/asin.y"
                                    {
                                        (yyval.expre) = (yyvsp[0].expre);
                                    }
#line 1814 "asin.c"
    break;

  case 44:
#line 353 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        if ((yyvsp[-2].expre).tipo != T_ERROR && (yyvsp[0].expre).tipo != T_ERROR){
                                                if ((yyvsp[-2].expre).tipo != (yyvsp[0].expre).tipo){
                                                        yyerror("Error en expresionIgualdad, no coinciden los tipos de la igualdad");
                                                } else if (!((yyvsp[-2].expre).tipo == (yyvsp[0].expre).tipo && ((yyvsp[-2].expre).tipo == T_LOGICO || (yyvsp[-2].expre).tipo ==T_ENTERO)) ){
                                                        yyerror("Error en expresionIgualdad, error de tipos en la igualdad");
                                                } else {
                                                        (yyval.expre).tipo = T_LOGICO;
                                                }
                                        }
                                }
#line 1831 "asin.c"
    break;

  case 45:
#line 368 "src/asin.y"
                                    { (yyval.expre) = (yyvsp[0].expre);
                                    }
#line 1838 "asin.c"
    break;

  case 46:
#line 371 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        if((yyvsp[-2].expre).tipo != T_ERROR && (yyvsp[0].expre).tipo != T_ERROR) {
                                            if((yyvsp[-2].expre).tipo != T_ENTERO || (yyvsp[0].expre).tipo != T_ENTERO) {
                                                yyerror("Error en expresionRelacional, los operandos deben ser enteros");
                                            }
                                            else {
                                                (yyval.expre).tipo = T_LOGICO;
                                            }
                                        }
                                    }
#line 1854 "asin.c"
    break;

  case 47:
#line 385 "src/asin.y"
                                    {
                                        (yyval.expre) = (yyvsp[0].expre);
                                    }
#line 1862 "asin.c"
    break;

  case 48:
#line 389 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        if((yyvsp[-2].expre).tipo != T_ENTERO || (yyvsp[0].expre).tipo != T_ENTERO) {
                                            yyerror("Error en expresionAditiva, los operandos no son de tipo entero");
                                        }
                                        else {
                                                (yyval.expre).tipo = (yyvsp[-2].expre).tipo;
                                            }
                                    }
#line 1876 "asin.c"
    break;

  case 49:
#line 401 "src/asin.y"
                                    {
                                        (yyval.expre) = (yyvsp[0].expre);
                                    }
#line 1884 "asin.c"
    break;

  case 50:
#line 405 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        if((yyvsp[-2].expre).tipo != T_ENTERO || (yyvsp[0].expre).tipo != T_ENTERO) {
                                            yyerror("Error en expresionMultiplicativa, los operandos no son de tipo entero");
                                        }
                                        else {
                                                (yyval.expre).tipo = (yyvsp[-2].expre).tipo;
                                            }
                                    }
#line 1898 "asin.c"
    break;

  case 51:
#line 417 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = (yyvsp[0].expre).tipo;
                                    }
#line 1906 "asin.c"
    break;

  case 52:
#line 421 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        if ((yyvsp[0].expre).tipo != T_ERROR )
                                        {
                                            if (!((yyvsp[0].expre).tipo == T_ENTERO || (yyvsp[0].expre).tipo == T_LOGICO)) {
                                                yyerror("Error en expresionUnaria, variable espresion unaria no es tipo entero o lógico.");
                                            }
                                            else
                                            {
                                                if ((yyvsp[-1].aux) == NOT_ && (yyvsp[0].expre).tipo != T_LOGICO) {
                                                    yyerror("Error en expresionUnaria, solo se puede realizar expresion not con T_LOGICO");
                                                } else if (((yyvsp[-1].aux) == MAS_ || (yyvsp[-1].aux) == MENOS_ ) && (yyvsp[0].expre).tipo != T_ENTERO) {
                                                    yyerror("Error en expresionUnaria, los cambios de signo solo se aplican a enteros");
                                                } else {
                                                    (yyval.expre).tipo = (yyvsp[0].expre).tipo;
                                                }
                                            }
                                        }
                                    }
#line 1930 "asin.c"
    break;

  case 53:
#line 441 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        SIMB simb = obtTdS((yyvsp[0].ident));
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionUnaria, variable no declarada.");
                                        }
                                        else if (simb.t != T_ENTERO){
                                            yyerror("Error en expresionUnaria, variable ha de ser de tipo entero.");
                                        }
                                        else {
                                            (yyval.expre).tipo = T_ENTERO;
                                        }
                                    }
#line 1948 "asin.c"
    break;

  case 54:
#line 457 "src/asin.y"
                                    {
                                        (yyval.expre) = (yyvsp[-1].expre);
                                    }
#line 1956 "asin.c"
    break;

  case 55:
#line 461 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        SIMB simb = obtTdS((yyvsp[-1].ident));
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionSufija, varibale no declarada.");
                                        }
                                        else if (simb.t != T_ENTERO) {
                                            yyerror("Error en expresionSufija, la variable ha de ser de tipo entero.");
                                        }
                                        else {
                                            (yyval.expre).tipo = simb.t;
                                        }
                                    }
#line 1974 "asin.c"
    break;

  case 56:
#line 475 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        SIMB simb = obtTdS((yyvsp[-3].ident));
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
                                            else if ((yyvsp[-1].expre).tipo != T_ENTERO){
                                                yyerror("Error en expresionSufija, la expresion no es de tipo entero.");
                                            }
                                            else {
                                                (yyval.expre).tipo = array.telem;
                                            }
                                        }
                                    }
#line 2001 "asin.c"
    break;

  case 57:
#line 501 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        SIMB simb = obtTdS((yyvsp[-3].ident));
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
                                            (yyval.expre).tipo = dom.tipo;
                                        }
                                    }
#line 2024 "asin.c"
    break;

  case 58:
#line 520 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = T_ERROR;
                                        SIMB simb = obtTdS((yyvsp[0].ident));
                                        if (simb.t == T_ERROR) {
                                            yyerror("Error en expresionSufija, varibale no declarada.");
                                        }
                                        else {
                                            (yyval.expre).tipo = simb.t;
                                        }
                                    }
#line 2039 "asin.c"
    break;

  case 59:
#line 531 "src/asin.y"
                                    {
                                        (yyval.expre).tipo = (yyvsp[0].expre).tipo;
                                    }
#line 2047 "asin.c"
    break;

  case 64:
#line 544 "src/asin.y"
                                       {
                                        (yyval.expre).tipo = T_ENTERO;
                                        }
#line 2055 "asin.c"
    break;

  case 65:
#line 547 "src/asin.y"
                                        { (yyval.expre).tipo = T_LOGICO; }
#line 2061 "asin.c"
    break;

  case 66:
#line 548 "src/asin.y"
                                         { (yyval.expre).tipo = T_LOGICO; }
#line 2067 "asin.c"
    break;

  case 80:
#line 574 "src/asin.y"
                                       { (yyval.aux)=MAS_; }
#line 2073 "asin.c"
    break;

  case 81:
#line 575 "src/asin.y"
                                         { (yyval.aux)=MENOS_; }
#line 2079 "asin.c"
    break;

  case 82:
#line 576 "src/asin.y"
                                       { (yyval.aux)=NOT_; }
#line 2085 "asin.c"
    break;


#line 2089 "asin.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
