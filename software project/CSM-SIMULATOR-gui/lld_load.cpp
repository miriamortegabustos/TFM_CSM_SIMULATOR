#include <fcntl.h>
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <QDebug>
#include "fpga.h"
#include "tc_defs.h"
#include "fee_tm_fwd.h"
#include "common.h"
#include "minIni/minIni.h"
#include "lld_load.h"
#include "common.h"
#include "ltc2358_driver.h"
#include "timestamp.h"
#include "config.h"


#define PAGE_SIZE ((size_t)getpagesize())
#define PAGE_MASK ((uint64_t)(long)~(PAGE_SIZE - 1))

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * LLD INTERFACE: Pulse detected, release time and set pulse thresholds*/

LLD_LOAD* lld_load;

LLD_LOAD::LLD_LOAD(QString tmtc_prefix, uint32_t base) {
    int fd;

    fd = open("/dev/mem", O_RDWR);
    if (fd < 0) {
        printf("open(/dev/mem) failed (%d)\n", errno);
        return;
    }

    regs_lld_load = (struct T_lld_load_regs*)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, base);
    if (regs_lld_load == MAP_FAILED) {
        printf("mmap64(0x%x@0x%lx) failed (%d)\n", PAGE_SIZE, base, errno);
        return;
    }


    //initialization
    regs_lld_load->ctrl = 0;
    regs_lld_load->thres_hi = cal_float2raw(config->value("LLD/thr_hi", "2").toFloat(), ltc2358_driver->Cal_curr.data_cal_curr[2].a, ltc2358_driver->Cal_curr.data_cal_curr[2].b); //100mA
    regs_lld_load->thres_lo = cal_float2raw(config->value("LLD/thr_lo", "0.08").toFloat(), ltc2358_driver->Cal_curr.data_cal_curr[2].a, ltc2358_driver->Cal_curr.data_cal_curr[2].b); //80mA
    regs_lld_load->release_time = 10*1e5;
}

void LLD_LOAD::update_status() {

    //ioctl(fd, IOCTL_EPD_TS_GET_STATUS, &regs_lld_load);
}

void LLD_LOAD::run() {

    uint64_t prev_ts;

    while(1) {


        if (regs_lld_load->falling_ts != prev_ts) {

            QString hdr = ts_st() + " " + tm_server->get_tmtc_prefix() + "_TM_";
            QString tm;

            prev_ts = regs_lld_load->falling_ts;
            pulse_width = (regs_lld_load->falling_ts - regs_lld_load->rising_ts);

            tm += hdr + QString("LLD_ACT_TS");
            tm += QString(" %1").arg(monoraw_to_ts(regs_lld_load->rising_ts)*1e-9, 6, 'f');
            tm += "\n";

            tm += hdr + QString("LLD_ACT_WIDTH");
            tm += QString(" %1").arg(pulse_width*1e-6);
            tm += "\n";

            tm += hdr + QString("LLD_CUR");
            pulse_curr = cal_raw2float(lld_load->regs_lld_load->pk_current, ltc2358_driver->Cal_curr.data_cal_curr[2].a, ltc2358_driver->Cal_curr.data_cal_curr[2].b);
            tm += QString(" %1").arg(cal_raw2float(lld_load->regs_lld_load->pk_current, ltc2358_driver->Cal_curr.data_cal_curr[2].a, ltc2358_driver->Cal_curr.data_cal_curr[2].b));
            tm += "\n";

            tm_server->tm_forward(tm);

        } else
            usleep(1000);


    }
}

uint64_t LLD_LOAD::get_pulse_width(){
    return pulse_width;
}

int LLD_LOAD::get_load_sel(){

    switch (regs_lld_load->status & LLD_LOAD_MASK) {
        case LLD_LOAD_MIN: return 1; break;
        case LLD_LOAD_MAX: return 2; break;
        case LLD_LOAD_SC: return 3; break;
    default: return 0;
    }
}

void LLD_LOAD::set_load_sel(int i) {

    uint32_t u;
    //regs_lld_load->load_sel[i] = 1;

    u = regs_lld_load->ctrl & ~LLD_LOAD_MASK;
    switch (i) {
        case 1: u |= LLD_LOAD_MIN; break;
        case 2: u |= LLD_LOAD_MAX; break;
        case 3: u |= LLD_LOAD_SC; break;
    }
    regs_lld_load->ctrl = u;
}

int lld_load_set_load_sel(QStringList args) {

    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && ((i >= 0) || (i <= 3)))
            lld_load->set_load_sel(i);
    } else {
        return EINVARG1;
    }
    return 0;
}


void LLD_LOAD::set_lld_sim_enable(){

    regs_lld_load->ctrl |= LLD_LOAD_SIM_ENA;
}

bool LLD_LOAD::get_lld_sim_enabled(){

    return !!(regs_lld_load->ctrl & LLD_LOAD_SIM_ENA);
}


int lld_load_sim_enable(QStringList args) {

    if (args.count() != 0)
        return -ENUMARGS;

    lld_load->set_lld_sim_enable();
    return 0;
}

void LLD_LOAD::set_lld_sim_disable(){

    regs_lld_load->ctrl &= ~(LLD_LOAD_SIM_ENA);
}

int lld_load_sim_disable(QStringList args) {

    if (args.count() != 0)
        return -ENUMARGS;

    lld_load->set_lld_sim_disable();
    return 0;
}

void LLD_LOAD::set_lld_load_thres_lo(int i){
    regs_lld_load->thres_lo = i;
}

int lld_load_thres_lo(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (i >= 0))
            lld_load->set_lld_load_thres_lo(i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void LLD_LOAD::set_lld_load_thres_hi(int i){
    regs_lld_load->thres_hi = i;
}

int lld_load_thres_hi(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (i >= 0))
            lld_load->set_lld_load_thres_hi(i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void LLD_LOAD::set_lld_release_time(float i){
    regs_lld_load->release_time = i*1e5;
}

float LLD_LOAD::get_lld_release_time(){
    return (regs_lld_load->release_time)/1e5;
}

int lld_load_release_time(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    float i= args.at(0).toFloat(&ok);

    if (ok) {
        if (ok && (i >= 0))
            lld_load->set_lld_release_time(i);
    } else {
        return EINVARG1;
    }
    return 0;
}


int64_t LLD_LOAD::get_rising_ts(){
    if (regs_lld_load->rising_ts > 0)
        return regs_lld_load->rising_ts;
    else
        return 0;
}

int64_t LLD_LOAD::get_falling_ts(){
    if (regs_lld_load->falling_ts > 0)
        return regs_lld_load->falling_ts;
    else
        return 0;
}

