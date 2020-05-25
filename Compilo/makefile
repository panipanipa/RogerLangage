EXEC = compilo.exe

all: $(EXEC)

compilo.exe: lex.yy.c y.tab.c
	gcc -Wall build/y.tab.c build/lex.yy.c build/table_symbole.c build/tab_asm.c build/pile_tmp.c -o compilo.exe

lex.yy.c: src/test.lex
	flex -o build/lex.yy.c src/test.lex

y.tab.c: src/synta.y 
	yacc -b build/y -dv src/synta.y

