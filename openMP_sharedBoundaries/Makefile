# specific variables
FCOMPILER = gfortran
FLAGS     = -pipe -ffree-line-length-none -fno-range-check \
            -g -Og -fbacktrace -fbounds-check \
            -Wall -fimplicit-none -pedantic \
            -Wimplicit-interface -Wconversion  -Wsurprising \
            -Wunderflow  -ffpe-trap=invalid,zero,overflow -fopenmp

BINARY    = shared_boundaries

.PHONY: run
run: $(BINARY)
	./$<

shared_boundaries: shared_boundaries.f03
	$(FCOMPILER) $(FLAGS) $< -o $@

clean:
	rm -rf $(BINARY) *.dSYM *.mod
