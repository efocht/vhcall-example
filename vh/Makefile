#DEBUG		= -g
FC		= gfortran
CC		= gcc
FCFLAGS		= -fpic -O2 $(DEBUG)
CFLAGS		= -std=gnu99 -fpic $(DEBUG) -O2 -I$(WORKSPACE)/opt/nec/ve/veos/include
CPPFLAGS	= -I.
LDFLAGS		= -fpic -shared
#-------------------------------------------------------------------------------

LIBFTN	= libftnio_vh.so
LIBDEMO	= libvhcode.so

OBJSFTN	= ftn_write_vh.o c_write_vh.o
OBJDEMO = vhcode.o

#-------------------------------------------------------------------------------
.PHONY: all clean default mrproper
all: $(LIBDEMO) $(LIBFTN)

.SUFFIXES: .F03 .o .so .mod .c

vhcode.c: vhcode.h

.F03.o:
	rm -f $@
	$(FC) -c -o $@ $(FCFLAGS) $(FPPFLAGS) $^

.c.o:
	rm -f $@
	$(CC) -c -o $@ $(CFLAGS) $(CPPFLAGS) $^

#-------------------------------------------------------------------------------

clean:
	rm -f *.o *.so *.mod

#-------------------------------------------------------------------------------
$(LIBFTN): $(OBJSFTN)
	$(FC) -o $@ $(LDFLAGS) $^

$(LIBDEMO): $(OBJDEMO)
	$(CC) -o $@ $(LDFLAGS) $^
