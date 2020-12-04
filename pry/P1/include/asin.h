/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

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
    CTE_ = 258,
    ID_ = 259,
    WHILE_ = 260,
    FOR_ = 261,
    IF_ = 262,
    ELSE_ = 263,
    TRUE_ = 264,
    FALSE_ = 265,
    PRINT_ = 266,
    READ_ = 267,
    RETURN_ = 268,
    INT_ = 269,
    BOOL_ = 270,
    ALLAVE_ = 271,
    CLLAVE_ = 272,
    ACORCH_ = 273,
    CCORCH_ = 274,
    APAREN_ = 275,
    CPAREN_ = 276,
    PTOCOMA_ = 277,
    PTO_ = 278,
    CMA_ = 279,
    MAS_ = 280,
    MENOS_ = 281,
    POR_ = 282,
    DIV_ = 283,
    AND_ = 284,
    OR_ = 285,
    SUMASIG_ = 286,
    RESASIG_ = 287,
    MULASIG_ = 288,
    DIVASIG_ = 289,
    IGUAL_ = 290,
    NOIGUAL_ = 291,
    MAYIGUAL_ = 292,
    MENIGUAL_ = 293,
    INC_ = 294,
    DEC_ = 295,
    MAY_ = 296,
    MEN_ = 297,
    ASIG_ = 298,
    NOT_ = 299,
    MOD_ = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_ASIN_H_INCLUDED  */
