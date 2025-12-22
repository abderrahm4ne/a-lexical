%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "TS.h"

extern int nb_line;
extern int nb_column;
int yylex();
int yyerror(const char *s);
char SauvType[20];
%}

%union{
      int integer;
      char *str;
      float real;
}
%start program
%right MARK


%token SCRIPT VARS INT REAL CODE BEGIN_T WRITE FINISH
%token AFF PVG DP VG PO PF PLUS MINUS MUL DIV AO AF
%token <str> IDF <integer> INTEGER <real> REALNUM <str> STRING
%token IF ELSE ENDIF AND OR FOR DE A PAS WHILE DO
%token GRT SML GOE SOE EQL NEL MARK

%%

program:
      SCRIPT IDF PVG declarations code FINISH
      { printf("Program syntax is correct.\n"); }
;

declarations:
      VARS varlist
     | 
;

varlist:
      vardecl varlist
    |
;

vardecl:
      identlist DP type PVG
;

identlist:
      IDF      {
            if(recherche($1)==-1) {inserer($1,SauvType);}
            else printf("Erreur Semantique: double declation de %s, a la ligne %d\n", $1, nb_line); 
            }          
    | IDF VG identlist    {
            if(recherche($1)==-1) {inserer($1,SauvType);}
            else printf("Erreur Semantique: double declation de %s, a la ligne %d\n", $1, nb_line); 
            }
;

type:
      INT {strcpy(SauvType,"INT");} | REAL {strcpy(SauvType,"REAL");}
;

code:
      CODE BEGIN_T AO statements AF
;

statements:
      statement statements
    |
;

statement:
      assignment PVG
    | writestmt PVG
    | conditionEx
    | loop
;

conditionEx: 
       IF PO condition PF AO statements AF ENDIF PVG
     | IF PO condition PF AO statements AF ELSE AO statements AF ENDIF PVG
;

condition:
      expressionLogique | expressionComparison
;

expressionLogique:
      ex AND ex
     |ex OR ex
     | MARK ex
;

expressionComparison:
      ex GRT ex | ex SML ex | ex GOE ex |
      ex SOE ex | ex EQL ex | ex NEL ex
;

loop:
      forLoop
    | doWhileLoop

forLoop: 
      FOR IDF DE INTEGER A INTEGER PAS INTEGER AO statements AF IDF { /* Vérification de la declaration */ if (recherche($2)== -1) printf("Erreur semantique: %s non declare a la ligne %d\n",$2,nb_line);
      }
;

doWhileLoop:
      DO AO statements AF WHILE PO condition PF PVG
;

ex: 
      IDF { /* Vérification de la declaration */ if (recherche($1)==-1) printf("Erreur semantique: %s non declare a la ligne %d\n",$1,nb_line);
      }  
      | REALNUM | INTEGER
;

assignment:
      IDF AFF expression { /* Vérification de la declaration */
                              if (recherche($1)==-1) printf("Erreur semantique: %s non declare a la ligne%d\n",$1,nb_line);
                         }     
;

writestmt:
      WRITE PO STRING PF      
;

expression:
      expression PLUS term
    | expression MINUS term
    | term
;

term:
      term DIV INTEGER  { if ($3==0) printf("Erreur semantique: Division par zero a la ligne %d\n",nb_line); }
    | term DIV IDF
    | term MUL factor
    | factor
;

factor:
      IDF { /* Vérification de la declaration */ if (recherche($1)==-1) printf("Erreur semantique: %s non declare a la ligne%d\n",$1,nb_line);
          }
    | INTEGER
    | REALNUM
    | PO expression PF
;

%%

int main(void) {
    yyparse();
    afficher();
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Syntax error at line %d, column %d: %s\n",
            nb_line, nb_column, s);
    return 1;     
}