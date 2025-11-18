%{
    #include <stdio.h>
    #include <string.h>
    #include "syntax.tab.h"
    
    int nb_line = 1;
    int nb_column = 1;
    int lexical_errors = 0;
%}

lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|_|{chiffre})*
KEYWORD (Script|Vars|Int|Real|Code|Begin|write|Finish|If|Else|EndIf|AND|OR|For|de|à|pas|Do|While)
INTEGER {chiffre}+
REAL [+-]?{chiffre}+\.{chiffre}+

%%

{KEYWORD} {
    nb_column += yyleng;
    if(strcmp(yytext,"Script")==0) return SCRIPT;
    else if(strcmp(yytext,"Vars")==0) return VARS;
    else if(strcmp(yytext,"Int")==0) return INT;
    else if(strcmp(yytext,"Real")==0) return REAL;
    else if(strcmp(yytext,"Code")==0) return CODE;
    else if(strcmp(yytext,"Begin")==0) return BEGIN_T;
    else if(strcmp(yytext,"write")==0) return WRITE;
    else if(strcmp(yytext,"Finish")==0) return FINISH;
    else if(strcmp(yytext, "If")==0) return IF;
    else if(strcmp(yytext, "Else")==0) return ELSE;
    else if(strcmp(yytext, "EndIf")==0) return ENDIF;
    else if(strcmp(yytext, "AND")==0) return AND;
    else if(strcmp(yytext, "OR")==0) return OR;
    else if(strcmp(yytext, "For")==0) return FOR;
    else if(strcmp(yytext, "de")==0) return DE;
    else if(strcmp(yytext, "à")==0) return A;
    else if(strcmp(yytext, "pas")==0) return PAS;
    else if(strcmp(yytext, "Do")==0) return DO;
    else if(strcmp(yytext, "While")==0) return WHILE;    
}

{IDF} {
    if (yyleng > 14) {
        printf("error lexical: IDF '%s' too long (max 14) at line %d col %d\n", yytext, nb_line, nb_column);
        lexical_errors++;
    } else {
        nb_column += yyleng;
        return IDF;
    }
}

{INTEGER}   { nb_column += yyleng; return INTEGER; }
{REAL}      { nb_column += yyleng; return REALNUM; }

\r          { nb_column++; }  
[ \t\r]+      { nb_column += yyleng; }
\n          { nb_line++; nb_column = 1; }

":=" { nb_column += yyleng; return AFF; }
";"  { nb_column += yyleng; return PVG; }
":"  { nb_column += yyleng; return DP; }
","  { nb_column += yyleng; return VG; }
"("  { nb_column += yyleng; return PO; }
")"  { nb_column += yyleng; return PF; }
"+"  { nb_column += yyleng; return PLUS; }
"-"  { nb_column += yyleng; return MINUS; }
"*"  { nb_column += yyleng; return MUL; }
"/"  { nb_column += yyleng; return DIV; }
"{"  { nb_column += yyleng; return AO; }
"}"  { nb_column += yyleng; return AF; }
">"  { nb_column += yyleng; return GRT; }
"<"  { nb_column += yyleng; return SML; }
">="  { nb_column += yyleng; return GOE; }
"<="  { nb_column += yyleng; return SOE; }
"=="  { nb_column += yyleng; return EQL; }
"!="  { nb_column += yyleng; return NEL; }
"!"  { nb_column += yyleng; return MARK; }


"//".*      { nb_column += yyleng; }   /* commentaires ignorés */

["][^"\n]*["] |
['][^'\n]*['] {
    nb_column += yyleng;
    return STRING;
}

. {
    printf("error lexical: char '%s' unknown at line %d col %d\n", yytext, nb_line, nb_column);
    lexical_errors++;
    nb_column += yyleng;
}

%%

int yywrap() { return 1; }