#include <fcntl.h>
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include "fpga.h"
#include "simple_io.h"
#include "tc_defs.h"

uint32_t* reg_in;
uint32_t* reg_out;

void simple_io_init(uint32_t base) {

    int fpga_fd;
    void* regs;

    fpga_fd = open("/dev/mem", O_RDWR);
    if (fpga_fd < 0) {
        printf("open(/dev/mem) failed (%d)\n", errno);
        return;
    }

    regs = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fpga_fd, base);
    if (regs == MAP_FAILED) {
        printf("mmap64(0x%x@0x%lx) failed (%d)\n",
                PAGE_SIZE, base, errno);
        return;
    }

    reg_in = (uint32_t*)regs;
    reg_out = (uint32_t*)regs + 1;
}

bool get_input(uint32_t mask) {

    return !!(*reg_in & mask);
}

bool get_output(uint32_t mask) {

    return !!(*reg_out & mask);
}

bool set_output(uint32_t mask) {

    *reg_out |= mask;
}

bool clr_output(uint32_t mask) {

    *reg_out &= ~mask;
}

// TC Functions

int ena_input_test(QStringList args) {

    bool ok;

    if (args.count() != 1)
        return ENUMARGS;

    int i = args.at(0).toInt(&ok);

    if (!ok)
        return EINVARG1;

    switch (i) {
        case 1: set_output(INPUT_TEST_1); return 0;
        case 2: set_output(INPUT_TEST_2); return 0;
        default: return EINVARG1;
    }
}

int dis_input_test(QStringList args) {

    bool ok;

    if (args.count() != 1)
        return ENUMARGS;

    int i = args.at(0).toInt(&ok);

    if (!ok)
        return EINVARG1;

    switch (i) {
        case 1: clr_output(INPUT_TEST_1); return 0;
        case 2: clr_output(INPUT_TEST_2); return 0;
        default: return EINVARG1;
    }
}
