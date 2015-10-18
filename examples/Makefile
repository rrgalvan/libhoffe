# Definition of the compiler
FC=gfortran

# Options for gfortran and ifortran compilers (see http://www.fortran90.org/src/faq.html)
OPTIONS_GFORTRAN_DEVEL=-Wall -Wextra -Wimplicit-interface -Werror -fPIC -fmax-errors=1 -fbacktrace -fbounds-check -fcheck-array-temporaries
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

SOURCES:=$(wildcard *.f90)
OBJECTS:=$(SOURCES:.f90=.o)
EXEC:=$(SOURCES:.f90=)

# Compiling rules

all: $(EXEC)

%.o: %.f90
	$(COMPILE) $<

%: %.o
	$(LINK) $(OBJECTS) $(HOFFELIB) -o $@

clean:
	rm -f  $(EXEC) *.o *.mod *~

.PHONY: all clean
