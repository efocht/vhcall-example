#include <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>


int64_t
cwrite_vh(void *hdl, void *ip, size_t isize, void *op, size_t osize)
{
        int *in = (int *)ip;
        int *out = (int *)op;

	printf("cwrite_vh: isize = %d ip=%p op=%p\n", isize, ip, op);
        for (int i = 0; i < isize/sizeof(int); i++) {
		printf("%d ", in[i]);
        }
        printf("\ncwrite_vh done\n");
        return 0;
}

