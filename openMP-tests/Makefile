# specific variables
FC       = ifort
FC_FLAGS = -diag-disable=7025,7416 -qopenmp -fpp -stand f03 -free -Tf

BINARY    = openmp-hello.bin

.PHONY: run
run: $(BINARY)
	./$<

openmp-hello.bin: openmp-hello.f03
	$(FC) $(FC_FLAGS) $< -o $@

clean:
	rm -rf $(BINARY) *.dSYM *.mod
