#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/un.h>
#include <unistd.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <libvhcall.h>
#include <omp.h>
#include "vh/vhcode.h"

int
main (int argc, char **argv)
{
	int64_t symid1 = -1, symid2 = -1;

	vhcall_handle h = vhcall_install("vh/libvhcode.so");
	if (h == (vhcall_handle)-1) {
		fprintf(stderr, "vhcall_install failed\n");
		exit(1);
	}
	symid1 = vhcall_find(h, "demo1");
	if (symid1 == -1) {
		fprintf(stderr, "vhcall_find 1 failed\n");
		exit(1);
	}
	symid2 = vhcall_find(h, "demo2");
	if (symid2 == -1) {
		fprintf(stderr, "vhcall_find 2 failed\n");
		exit(1);
	}
	printf("vhcall prepared\n\n");

	char x[] = "abcdefghijklmno\0";
	char *y;
	y = (char *)malloc(sizeof(x));
	if (vhcall_invoke(symid1, x, sizeof(x), y, sizeof(x))) {
		perror("vhcall_invoke 1");
		exit(1);
	}
	printf("demo1 result buffer on VE: %s\n", y);

	struct sendrecv_data sr;

	sr.addr = x;
	sr.size = sizeof(x);
	sr.result = malloc(sizeof(x));

	if (vhcall_invoke(symid2, &sr, sizeof(sr), NULL, 0)) {
		perror("vhcall_invoke 2");
		exit(1);
	}
	printf("demo2 recv buffer on VE: %s\n", sr.result);

	return 0;
}
