CC=gcc

CFALGS=-O1

main.s: main.c
	$(CC) -S $(CFALGS) -o main.s main.c

all: main.s


clean:
	rm -f main.s