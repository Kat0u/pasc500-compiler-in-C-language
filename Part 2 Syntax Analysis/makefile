CC=gcc
OBJ=pasc500.tab.c lex.yy.c hashtbl.o


pasc500: lex.yy.c pasc500.tab.c pasc500.tab.h hashtbl.o
	$(CC)  -Wall $(OBJ) -o $@ -lm
	
pasc500.tab.c pasc500.tab.h: pasc500.y
	bison  -v  -d  pasc500.y

lex.yy.c: pasc500.l pasc500.tab.h
	flex pasc500.l
	
hashtbl.o: hashtbl.c hashtbl.h
	$(CC) -o hashtbl.o -Wall -g -c hashtbl.c
