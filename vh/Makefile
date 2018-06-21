.PHONY: all
SRC=vhcode.c
OBJ=$(SRC:.c=.o)
CFLAGS=-std=gnu99 -fpic -I$(WORKSPACE)/opt/nec/ve/veos/include
all: libvhcode.so

libvhcode.so: $(OBJ)
	$(CC) -shared -o $@ $(OBJ)
vhcode.o: vhcode.c
	$(CC) -c $(CFLAGS) vhcode.c -o $@

.PHONY: clean
clean:
	rm -f *.so *.o
