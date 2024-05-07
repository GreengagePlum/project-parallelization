CC=mpicc
CFLAGS=-g -O3 -march=native -Wall -Wextra -pedantic -fopenmp

.PHONY: all clean

all: julia

julia: julia.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f julia *.o
