# specific variables
FC           = ifort

FC_PROFILING = -g -vec -O3 -qopt-report=5 -simd
FC_DEBUG     = -g3 -check all -fpe0 -warn -traceback -debug extended
FC_WORKSHARE = -O3 -g -debug inline-debug-info -traceback -parallel-source-info=2

FC_FLAGS     = -diag-disable=7025,7416 -qopenmp -fpp -stand f03 -free -Tf


BINARY    = openmp-hello.bin openmp-pi.bin openmp-oneliner.bin \
						openmp-workshare.bin

.PHONY: run
run: $(BINARY)
	@for i in $(BINARY); do \
		echo "" && echo ">> running '$$i':" && ./$$i; \
	done

openmp-hello.bin: openmp-hello.f03
	$(FC) $(FC_FLAGS) $< -o $@

openmp-pi.bin: openmp-pi.f03
	$(FC) $(FC_PROFILING) $(FC_FLAGS) $< -o $@

openmp-oneliner.bin: openmp-oneliner.f03
	$(FC) $(FC_DEBUG) $(FC_FLAGS) $< -o $@

openmp-workshare.bin: openmp-workshare.f03
	$(FC) $(FC_WORKSHARE) $(FC_FLAGS) $< -o $@

clean:
	rm -rf $(BINARY) *.dSYM *.mod *.optrpt *.def
