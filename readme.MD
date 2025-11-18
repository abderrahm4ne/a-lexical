# TO RUN :

```sh
flex -l ex1.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -o compiler
```

# TO TEST :
## testing text.txt file : 

```sh
./compiler < text.txt
```