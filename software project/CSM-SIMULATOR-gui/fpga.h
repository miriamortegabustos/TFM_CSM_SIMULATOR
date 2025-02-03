#ifndef FPGA_VERSION_H
#define FPGA_VERSION_H

#include <stdint.h>
#include <QtCore>

#define PAGE_SIZE ((size_t)getpagesize())
#define PAGE_MASK ((uint64_t)(long)~(PAGE_SIZE - 1))

#define FREQ_CTR_BASE       0x43c40000
#define FPGA_ID_BASE        0x43ff0000


uint32_t fpga_get_version();
void fpga_reg_write(uint32_t, uint32_t);

void bhclk_meas_init();
float get_bhclk_freq();

//int fpga_set_rsa(QStringList);
//int fpga_set_shp_wdt(QStringList);
//int fpga_trigger_shp(QStringList);
//int fpga_sim_shp_acq(QStringList);

//#ifdef __SIMULATOR__

//extern uint32_t rsa_out;
//extern uint32_t rsa_in;
//extern float shp_wdt;

//int fpga_sim_rsa_in(QStringList);

//#endif

#endif // FPGA_VERSION_H
