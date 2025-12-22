/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SYNTAX_TAB_H_INCLUDED
# define YY_YY_SYNTAX_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    SCRIPT = 258,                  /* SCRIPT  */
    VARS = 259,                    /* VARS  */
    INT = 260,                     /* INT  */
    REAL = 261,                    /* REAL  */
    CODE = 262,                    /* CODE  */
    BEGIN_T = 263,                 /* BEGIN_T  */
    WRITE = 264,                   /* WRITE  */
    FINISH = 265,                  /* FINISH  */
    AFF = 266,                     /* AFF  */
    PVG = 267,                     /* PVG  */
    DP = 268,                      /* DP  */
    VG = 269,                      /* VG  */
    PO = 270,                      /* PO  */
    PF = 271,                      /* PF  */
    PLUS = 272,                    /* PLUS  */
    MINUS = 273,                   /* MINUS  */
    MUL = 274,                     /* MUL  */
    DIV = 275,                     /* DIV  */
    AO = 276,                      /* AO  */
    AF = 277,                      /* AF  */
    IDF = 278,                     /* IDF  */
    INTEGER = 279,                 /* INTEGER  */
    REALNUM = 280,                 /* REALNUM  */
    STRING = 281,                  /* STRING  */
    IF = 282,                      /* IF  */
    ELSE = 283,                    /* ELSE  */
    ENDIF = 284,                   /* ENDIF  */
    AND = 285,                     /* AND  */
    OR = 286,                      /* OR  */
    FOR = 287,                     /* FOR  */
    DE = 288,                      /* DE  */
    A = 289,                       /* A  */
    PAS = 290,                     /* PAS  */
    WHILE = 291,                   /* WHILE  */
    DO = 292,                      /* DO  */
    GRT = 293,                     /* GRT  */
    SML = 294,                     /* SML  */
    GOE = 295,                     /* GOE  */
    SOE = 296,                     /* SOE  */
    EQL = 297,                     /* EQL  */
    NEL = 298,                     /* NEL  */
    MARK = 299                     /* MARK  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 14 "syntax.y"

      int integer;
      char *str;
      float real;

#line 114 "syntax.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SYNTAX_TAB_H_INCLUDED  */
