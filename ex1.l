%{
    #include <stdio.h>
    #include <string.h>
    int nb_line = 1;
    int nb_colomn = 1
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*

%%

{IDF} {if(yyleng > 14)
    printf("Error: Identifier must be less or equals to 14");
    else printf("IDENTIFIER");
}

"//".* {printf("this is a comment");}

. {printf("error lexical in the entity %s in the line %d and colomn %d", yytext, nb_line, nb_colomn );
nb_colomn += yyleng;
lexical_errors++ }

%%

int yywrap() {return 1;}

int main(){

    yylex();
    return 0;
}