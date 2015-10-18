FC=gfortran

# Options for gfortran and ifortran compilers (see http://www.fortran90.org/src/faq.html)
OPTIONS_GFORTRAN_DEVEL=-Wall -Wextra -Wimplicit-interface -Werror -fPIC -fmax-errors=1 -fbacktrace -fbounds-check -fcheck-array-temporaries
OPTIONS_IFORT_DEVEL=-warn all -check all
OPTIONS_GFORTRAN_PRODUCTION=-Wall -Wextra -Wimplicit-interface -fPIC -Werror -fmax-errors=1 -O3 -march=native -ffast-math -funroll-loops
OPTIONS_IFORT_PRODUCTION=-warn all -fast

OPTIONS=$(OPTIONS_GFORTRAN_DEVEL)
COMPILE=$(FC) $(OPTIONS) -c

SOURCES:=nrtypes.f90 mesh1d.f90 mesh2d.f90 mesh.f90

OBJECTS:=$(SOURCES:.f90=.o)

default: libhoffe.a

%.o: %.f90
	$(COMPILE) $<

libhoffe.a: $(OBJECTS)
	ar cr libhoffe.a *.o

libhoffe.so: $(OBJECTS)
	gfortran -shared *.o -o libhoffe.so -fPIC

clean:
	rm -f *.o *.so *.a *.mod *~
