DEBUG		= -g2 -traceback

CC		= /opt/nec/ve/bin/ncc
CCFLAGS		= -fPIC -O2 $(DEBUG)

FC		= /opt/nec/ve/bin/nfort
FCFLAGS		= -fPIC -O2 $(DEBUG)
CPPFLAGS	= -I.
LDFLAGS		= -fPIC $(DEBUG)
LDLIBS		= -lsysve

FMAIN		= vhcall_ftn
FSOURCES	= $(wildcard *.F03) 
FOBJECTS	= $(FSOURCES:.F03=.o)

CMAIN		= vhcall_demo
CSOURCES	= $(wildcard *.c)
COBJECTS	= $(CSOURCES:.c=.o)

.PHONY: all clean vh

all : vh $(CMAIN) $(FMAIN)

#-------------------------------------------------------------------------------
.SUFFIXES: .c .F03 .o .mod

%.o : %.mod

vhcall_demo.o : vh/vhcode.h
vhcall_ftn.o : vhcall_ffunctions.o

.F03.o:
	rm -f $@
	$(FC) -c -o $@ $(FCFLAGS) $(CPPFLAGS) $<

.c.o:
	rm -f $@
	$(CC) -c -o $@ $(CFLAGS) $(CPPFLAGS) $<

$(FMAIN): $(FOBJECTS)
	rm -f $@
	$(FC) -o $@ $(LDFLAGS) $^ $(LDLIBS)

$(CMAIN): $(COBJECTS)
	rm -f $@
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)

clean:
	rm -f $(FMAIN) $(CMAIN) *.o *.mod
	make -C vh $@

vh:
	make -C vh
