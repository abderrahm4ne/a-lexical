# analyse-lexical

## first part

Include C declerations + nb_line, nb_column to locate where errors occure and lexical_errors to calculate how many errors occured

### basic exR :
lettre [a-zA-Z]
chiffre [0-9]

### basic exR for numbers :
INTEGER {chiffre}+
REAL [+-]?{chiffre}+\.{chiffre}+

### exR for keywords :
KEYWORD Script|Vars|Code|Begin|End|Finish|Int|Real|write

exR for Identifier :

## second part

Include Rules :

// catching keywords and increase the column

<pre> ```{KEYWORD} {
    printf("KEYWORD(%s)\n", yytext);
    nb_column += yyleng;
}``` <pre>

// catching identifier entered by user which can includes - and _ in the middle


<pre>```{IDF} {
    if (yyleng > 14)
        printf("error lexical in the entity %s in the line %d and column %d - must be <= 14 chars\n",
               yytext, nb_line, nb_column);
    else
        printf("IDENTIFIER(%s)\n", yytext);
    nb_column += yyleng;
}```<pre>

catching real and integer


<pre>```{REAL} {
    printf("REAL(%s)\n", yytext);
    nb_column += yyleng;
}```<pre>

catching space and tab and increase column for better error locating


<pre>```[ \t]+ {
    nb_column += yyleng;
    /* this catches spaces and tab*/
}```<pre>

// catching new line for better error locating


<pre>```\n {
    nb_line++;
    nb_column = 1;

    // this handle new line
}```<pre>


// catching operations


<pre>```(":="|";"|":"|","|"."|"("|")"|"+"|"-"|"*"|"/") {
    printf("SYMBOL(%s)\n", yytext);
    nb_column += yyleng;
}```<pre>

// catching comments starting with //


<pre>```"//".* {
    printf("this is a comment\n");
    nb_column += yyleng;
}```<pre>

// catching any others character not handled by the rules above:


<pre>```. {
    printf("error lexical in the entity %s in the line %d and column %d\n", yytext, nb_line, nb_column);
    nb_column += yyleng;
    lexical_errors++;
}```<pre>


# run

0. Clone Repo
```sh
    git clone https://github.com/abderrahm4ne/
    cd a-lexical
```
1. Run command
```sh
    flex ex1.l
```

2. compile it 
```sh
    gcc gcc lex.yy.c -o MonTP -lfl
```
if you faced problems dont use the flag `-lfl` i had defiend yywrap in file

use instead 
```sh
    gcc lex.yy.c -o ex1
```

3. to test `test.txt` run :
    3.0 on Windows 
    ```sh
        Get-Content test.txt | ./ex1.exe
    ```
    3.1 on Linux
    ```sh
        ./ex1.exe < input.txt
    ```
