flex -l ex1.l
bison -d syntax.y
gcc lex.yy.c syn.tab.c -o compiler
compiler.exe < text.txt