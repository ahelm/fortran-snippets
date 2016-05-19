# specific variables
MPIFC				 = mpifort
# define MPI process and threads for test purposes
PROCS        = 4
THREADS			 = 2

FC           = gfortran
CC					 = gcc

FC_FLAGS     = -cpp -fopenmp

BINARY    = whoami.bin

.PHONY: run-mpi
run-mpi: $(BINARY)
	@for i in $(BINARY); do \
		export OMP_NUM_THREADS=$(THREADS); echo "" && echo ">> running '$$i':\n" && \
		mpiexec -n $(PROCS) $$i; \
	done

.PHONY: run
run: $(BINARY)
	@for i in $(BINARY); do \
		echo "" && echo ">> running '$$i':\n" && ./$$i; \
	done

whoami.bin: whoami.f03 cpu-num.o
	$(MPIFC) $(FC_FLAGS) cpu-num.o $< -o $@

cpu-num.o: cpu-num.c
	$(CC) -c $< -o $@

clean:
	rm -rf $(BINARY) *.dSYM *.mod *.optrpt *.def *.o
