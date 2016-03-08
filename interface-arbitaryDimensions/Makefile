# specific variables
FCOMPILER = gfortran
FLAGS     = -pipe -ffree-line-length-none -fno-range-check \
            -g -Og -fbacktrace -fbounds-check \
            -Wall -fimplicit-none -pedantic \
            -Wimplicit-interface -Wconversion  -Wsurprising \
            -Wunderflow  -ffpe-trap=invalid,zero,overflow

BINARY    = dimensionTest

.PHONY: run
run: dimensionTest
	./$<

dimensionTest: arbitaryDimensionsTest.f03
	$(FCOMPILER) $(FLAGS) $< -o $@

clean:
	rm -rf dimensionTest *.dSYM *.mod
