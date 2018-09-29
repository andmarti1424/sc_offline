# Makefile
SHELL = /bin/bash
FILES   = lua.c
CC      = gcc
CFLAGS  = -g -DSYSV3 -pg -fPIC -DCOMPAT_MODULE

test1:    xlsx.o expr.o Parser.o Lexer.o sheet.o calc.o function.o lua.o util.o test1.o rpsc.h
	$(CC) $(CFLAGS) lua.o xlsx.o expr.o Parser.o Lexer.o sheet.o calc.o function.o util.o test1.o -lm `pkg-config --libs libxml-2.0 libzip lua` -o test1
#	$(CC) -fPIC -shared -o sc.so lua.o

Lexer.c:	Lexer.l
	flex Lexer.l

Parser.c:	Parser.y Lexer.c
		bison -t Parser.y

xlsx.o:         xlsx.c
	$(CC) $(CFLAGS) -c  -D XLSX xlsx.c `pkg-config --cflags libxml-2.0`


%.o:            %.c rpsc.h
	$(CC) $(CFLAGS) -c $< -o $@ `pkg-config --cflags lua5.2`

clean:
	rm -f Lexer.c Parser.c Parser.h *.o gmon.out test1
