CC=mpicc
CFLAGS=-g -O3 -march=native -Wall -Wextra -pedantic -fopenmp

.PHONY: all clean

all: julia julia_omp julia_mpi_omp

julia: julia.c
	$(CC) $(CFLAGS) -o $@ $^

julia_omp: julia_omp.c
	$(CC) $(CFLAGS) -o $@ $^

julia_mpi_omp: julia_mpi_omp.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f julia julia_omp julia_mpi_omp *.o
