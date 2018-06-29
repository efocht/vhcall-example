
#CC=/opt/nec/ve/bin/musl-ncc
CC=/opt/nec/ve/bin/ncc

.PHONY: all
all : vhcall_demo vh

vhcall_demo : vhcall_demo.o
	$(CC) -o vhcall_demo $< -lsysve

vhcall_demo.o : vhcall_demo.c
	$(CC) -o vhcall_demo.o -O2 -c $<

.PHONY: clean vh
clean :
	rm -f vhcall_demo vhcall_demo.o
	make -C vh clean

vh:
	make -C vh
