#include <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <time.h>
#include "libvepseudo.h"
#include "vhcode.h"


int64_t
demo1(void *hdl, void *ip, size_t isize, void *op, size_t osize)
{
	char *in = (char *)ip;
	char *out = (char *)op;

	for (int i = 0; i < isize; i++) {
	  if (in[i])
	    out[i] = in[i] + 1;
	  else
	    out[i] = in[i];
	}
	printf("VH side done\n");
	return 0;
}

int64_t
demo2(void *hdl, void *ip, size_t isize, void *op, size_t osize)
{
	int ret;
	void *vh_buffer = NULL;
	struct sendrecv_data *data = ip;

	if (isize != sizeof(struct sendrecv_data)) {
		return 1;
	}
	vh_buffer = malloc(data->size);
	if (!vh_buffer) {
		perror("vh_buffer malloc");
		return 1;
	}
	ret = ve_recv_data(hdl, (uint64_t)data->addr, data->size, vh_buffer);
	if (ret != 0) {
		return 1;
	}
	printf("received buffer on VH: %s\n", vh_buffer);

	ret = ve_send_data(hdl, (uint64_t)data->result, data->size, vh_buffer);
	printf("sent buffer to VE\n");
	free(vh_buffer);
	return 0;
}

