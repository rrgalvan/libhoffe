# Definition of the compiler
FC=gfortran

# Options for gfortran and ifortran compilers (see http://www.fortran90.org/src/faq.html)
OPTIONS_GFORTRAN_DEVEL=-Wall -Wextra -Wimplicit-interface -Werror -fPIC -fbacktrace -fbounds-check -fcheck-array-temporaries # -fmax-errors=1
OPTIONS_IFORT_DEVEL=-warn all -check all
OPTIONS_GFORTRAN_PRODUCTION=-Wall -Wextra -Wimplicit-interface -fPIC -Werror -fmax-errors=1 -O3 -march=native -ffast-math -funroll-loops
OPTIONS_IFORT_PRODUCTION=-warn all -fast

OPTIONS=$(OPTIONS_GFORTRAN_DEVEL)
INCLUDE=-I../src

COMPILE=$(FC) $(INCLUDE) $(OPTIONS) -c
LINK=$(FC)

# Localization of HOFFElib
HOFFELIB_SRC=../src
HOFFELIB=$(HOFFELIB_SRC)/libhoffe.a

# Definition of object and source files

# WARNING! Order is important: fruit.mod is needed by *_test.f90
# and *_test.mod are needed by test_suite.f90
SOURCES:=fruit.f90 $(wildcard *_test.f90) test_suite.f90

OBJECTS:=$(SOURCES:.f90=.o)

# Compiling rules


test_suite: $(OBJECTS) $(HOFFELIB)
	$(LINK) $(OBJECTS) $(HOFFELIB) -o $@

%.o: %.f90
	$(COMPILE) $<

run: test_suite
	./test_suite

clean:
	rm -f test_suite *.o *.mod *~

.PHONY: all clean
