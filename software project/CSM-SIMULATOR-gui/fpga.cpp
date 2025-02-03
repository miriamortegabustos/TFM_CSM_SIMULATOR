#ifdef __arm__

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
#include "tc_defs.h"
#include "fee_tm_fwd.h"



uint32_t fpga_get_version() {

    int fpga_fd;
    void* regs;

    fpga_fd = open("/dev/mem", O_RDWR);
    if (fpga_fd < 0) {
        printf("open(/dev/mem) failed (%d)\n", errno);
        return 0;
    }

    regs = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fpga_fd, FPGA_ID_BASE);
    if (regs == MAP_FAILED) {
        printf("mmap64(0x%x@0x%lx) failed (%d)\n",
                PAGE_SIZE, FPGA_ID_BASE, errno);
        return 0;
    }

    uint32_t version = *(uint32_t*)regs;

    close(fpga_fd);

    return version;

}


void fpga_reg_write(uint32_t addr, uint32_t data) {

    int fpga_fd;
    uint32_t* regs;
    uint32_t page;
    uint32_t offset;

    page = addr & PAGE_MASK;
    offset = (addr - page) >> 2;

    fpga_fd = open("/dev/mem", O_RDWR);
    if (fpga_fd < 0) {
        printf("open(/dev/mem) failed (%d)\n", errno);
        return;
    }

    regs = (uint32_t*)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fpga_fd, page);
    if (regs == MAP_FAILED) {
        printf("mmap64(0x%x@0x%lx) failed (%d)\n",
                PAGE_SIZE, FPGA_ID_BASE, errno);
        return;
    }

    regs[offset] = data;

    close(fpga_fd);

}




//#ifdef __SIMULATOR__

//int fpga_sim_rsa_in(QStringList args) {

//    bool ok;

//    if (args.count() != 2)
//        return ENUMARGS;

//    int i1 = args.at(0).toInt(&ok);

//    if (!ok || (i1 < 1) || (i1 > 4))
//        return EINVARG1;

//    int i2 = args.at(1).toInt(&ok);

//    if (!ok || (i2 < 0) || (i2 > 1))
//        return EINVARG2;

//    if(i2)
//        rsa_in |= (1 << (i1-1));
//    else
//        rsa_in &= ~(1 << (i1-1));

//    return 0;

//}

//#endif


#endif //__arm__
