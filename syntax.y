%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int nb_line;
extern int nb_column;
int yylex();
int yyerror(const char *s);
%}

%token SCRIPT VARS INT REAL CODE BEGIN_T WRITE FINISH
%token AFF PVG DP VG PO PF PLUS MINUS MUL DIV AO AF
%token IDF INTEGER REALNUM STRING
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
      IDF                     
    | IDF VG identlist        
;

type:
      INT | REAL
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
      FOR IDF DE INTEGER A INTEGER PAS INTEGER AO statements AF
;

doWhileLoop:
      DO AO statements AF WHILE PO condition PF PVG
;

ex: 
      IDF | REALNUM | INTEGER
;

assignment:
      IDF AFF expression      
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
      term MUL factor
    | term DIV factor
    | factor
;

factor:
      IDF
    | INTEGER
    | REALNUM
    | PO expression PF
;

%%

int main(void) {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Syntax error at line %d, column %d: %s\n",
            nb_line, nb_column, s);
    return 1;     
}