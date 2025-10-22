%{
    #include <stdio.h>
    #include <string.h>
    int nb_line = 1;     // line number
    int nb_column = 1;   // column number
    int lexical_errors = 0;
%}


lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}* /* this handle identifer who contains _ or - in the middle */
KEYWORD Script|Vars|Code|Begin|End|Finish|Int|Real|write
INTEGER {chiffre}+
REAL [+-]?{chiffre}+\.{chiffre}+

%%

{KEYWORD} {
    printf("KEYWORD(%s)\n", yytext);
    nb_column += yyleng;
}

{IDF} {
    if (yyleng > 14)
        printf("error lexical in the entity %s in the line %d and column %d - must be <= 14 chars\n",
               yytext, nb_line, nb_column);
    else
        printf("IDENTIFIER(%s)\n", yytext);
    nb_column += yyleng;
}

{INTEGER} {
    printf("INTEGER(%s)\n", yytext);
    nb_column += yyleng;
}

{REAL} {
    printf("REAL(%s)\n", yytext);
    nb_column += yyleng;
}

[ \t]+ {
    nb_column += yyleng;
    /* this catches spaces and tab*/
}

\n {
    nb_line++;
    nb_column = 1;

    // this handle new line
}

(":="|";"|":"|","|"."|"("|")"|"+"|"-"|"*"|"/") {
    printf("SYMBOL(%s)\n", yytext);
    nb_column += yyleng;
}

"//".* {
    printf("this is a comment\n");
    nb_column += yyleng;
}                       /* this rule for catching comment: they start with double slash */

. {
    printf("error lexical in the entity %s in the line %d and column %d\n", yytext, nb_line, nb_column);
    nb_column += yyleng;
    lexical_errors++;
}                  /* this catch errors: characters not cought by any previous rules */
%%

int yywrap() {return 1;}

int main(){

    yylex();
    return 0;
}