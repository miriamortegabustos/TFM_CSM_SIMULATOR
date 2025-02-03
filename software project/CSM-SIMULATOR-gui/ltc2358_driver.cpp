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
#include "ltc2358_driver.h"
#include "fee_tm_fwd.h"
#include "common.h"
#include "minIni/minIni.h"
#include "ltc2358_driver.h"
#include "lld_load.h"

#define PAGE_SIZE ((size_t)getpagesize())
#define PAGE_MASK ((uint64_t)(long)~(PAGE_SIZE - 1))
#define TH_MAX_LIMIT    49000 //ohms


#define a_coef   1.029573E-03    /* Coeffs. for NTC sensor 44031, (ANY)*/
#define b_coef   2.390623E-04
#define c_coef   1.569122E-07

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * LTC2358: Calibration of all measures acquired by ADC and calibration*/

LTC2358_DRIVER* ltc2358_driver;

LTC2358_DRIVER::LTC2358_DRIVER(uint32_t base) {
    int fd;

    fd = open("/dev/mem", O_RDWR);
    if (fd < 0) {
        printf("open(/dev/mem) failed (%d)\n", errno);
        return;
    }

    regs_ltc2358_driver = (struct T_ltc2358_driver_regs*)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, base);
    if (regs_ltc2358_driver == MAP_FAILED) {
        printf("mmap64(0x%x@0x%lx) failed (%d)\n", PAGE_SIZE, base, errno);
        return;
    }

    read_cal();

    //initialization
    for (int i = 0; i < NUM_ADC_CH; i++)
        regs_ltc2358_driver->adc_data_avg[i] = 0;
}

void LTC2358_DRIVER::update_cal_from_data() {

    int i;
        for(i = 0; i < NUM_ADC_CH; i++) {
            if (i < NUM_CURRENT_CHs){
                Cal_curr.data_cal_curr[i].a = (caldata_curr.data_cal_curr[i].y2 - caldata_curr.data_cal_curr[i].y1)/(caldata_curr.data_cal_curr[i].x2 - caldata_curr.data_cal_curr[i].x1);
                Cal_curr.data_cal_curr[i].b = caldata_curr.data_cal_curr[i].y1 - caldata_curr.data_cal_curr[i].x1*Cal_curr.data_cal_curr[i].a;
            }
            else
                Cal_ther.data_cal_ther[i-NUM_CURRENT_CHs].Rb =((float)(caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].x_o - caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].x_sc)/(float)(caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].xcal - caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].x_sc) - 1) * caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].r_cal;
        }
}

void LTC2358_DRIVER::read_cal() {

    int i;

    for (i = 0; i < NUM_ADC_CH; i++) {
        if (i < NUM_CURRENT_CHs){
            caldata_curr.data_cal_curr[i].x1 = ini_getl(QString("adc_curr%1").arg(i).toUtf8(), "x1", 0, calfile);
            caldata_curr.data_cal_curr[i].y1 = ini_getf(QString("adc_curr%1").arg(i).toUtf8(), "y1", 0, calfile);
            caldata_curr.data_cal_curr[i].x2 = ini_getl(QString("adc_curr%1").arg(i).toUtf8(), "x2", 32768, calfile); //16 bits, 65536
            caldata_curr.data_cal_curr[i].y2 = ini_getf(QString("adc_curr%1").arg(i).toUtf8(), "y2", 2.5, calfile); //vref 2.5
        }
        else{
            caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].x_sc = ini_getl(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "xsc", 0, calfile);
            caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].x_o = ini_getf(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "xo", 0, calfile);
            caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].xcal = ini_getl(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "xcal", 32768, calfile); //16 bits, 65536
            caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].r_cal = ini_getf(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "rcal", 2.5, calfile); //vref 2.5
        }
    }
    update_cal_from_data();
}

void LTC2358_DRIVER::write_cal() {

    int i;

    system(QString("cp %1 %1.bak").arg(calfile).toUtf8());

    for(i = 0; i < NUM_ADC_CH; i++) {
        if (i < NUM_CURRENT_CHs){
            ini_putl(QString("adc_curr%1").arg(i).toUtf8(), "x1", caldata_curr.data_cal_curr[i].x1, calfile);
            ini_putf(QString("adc_curr%1").arg(i).toUtf8(), "y1", caldata_curr.data_cal_curr[i].y1, calfile);
            ini_putl(QString("adc_curr%1").arg(i).toUtf8(), "x2", caldata_curr.data_cal_curr[i].x2, calfile);
            ini_putf(QString("adc_curr%1").arg(i).toUtf8(), "y2", caldata_curr.data_cal_curr[i].y2, calfile);
        }
        else{
            ini_putl(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "xsc", caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].x_sc, calfile);
            ini_putf(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "xo", caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].x_o, calfile);
            ini_putl(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "xcal", caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].xcal, calfile);
            ini_putf(QString("adc_ther%1").arg(i-NUM_CURRENT_CHs).toUtf8(), "rcal", caldata_ther.data_cal_ther[i-NUM_CURRENT_CHs].r_cal, calfile);
        }
    }
}

float LTC2358_DRIVER::R_to_Temp(float R){

    float ln_R = logf(R);

    if (R <= 300.0) return 999.9;
    else if (R >= TH_MAX_LIMIT) return -99.9;
    else return ( 1 / (a_coef + b_coef*ln_R + c_coef*ln_R*ln_R*ln_R) - 273.15);

}

// Cal_meas_ther

void LTC2358_DRIVER::cal_meas_sc(int n_ch) {

    caldata_ther.data_cal_ther[n_ch-NUM_CURRENT_CHs].x_sc = regs_ltc2358_driver->adc_data_avg[n_ch];

    update_cal_from_data();
}

void LTC2358_DRIVER::cal_meas_open(int n_ch) {

    caldata_ther.data_cal_ther[n_ch-NUM_CURRENT_CHs].x_o = regs_ltc2358_driver->adc_data_avg[n_ch];

    update_cal_from_data();
}

void LTC2358_DRIVER::cal_meas_Rcal(int n_ch, float f) {

    caldata_ther.data_cal_ther[n_ch-NUM_CURRENT_CHs].xcal = regs_ltc2358_driver->adc_data_avg[n_ch];
    caldata_ther.data_cal_ther[n_ch-NUM_CURRENT_CHs].r_cal = f;

    update_cal_from_data();
}

float LTC2358_DRIVER::get_meas_adc_ther(int n_ch) {

    float avg = (float)Cal_ther.data_cal_ther[n_ch].Rb / ((float)(caldata_ther.data_cal_ther[n_ch].x_o - caldata_ther.data_cal_ther[n_ch].x_sc)/((regs_ltc2358_driver->adc_data_avg[n_ch+3]) - caldata_ther.data_cal_ther[n_ch].x_sc) - 1);

    if (avg < 0.0)
            return 10e6;
    else if (avg > 10e6)
        return 10e6;
    else
        return avg;
}


int LTC2358_TC_cal_meas_sc(QStringList args) {
    bool ok;

    int n_ch = args.at(0).toInt(&ok);

    ltc2358_driver->cal_meas_sc(n_ch-1);

    return 0;
}

int LTC2358_TC_cal_meas_open(QStringList args) {
    bool ok;

    int n_ch = args.at(0).toInt(&ok);

    ltc2358_driver->cal_meas_open(n_ch-1);

    return 0;
}

int LTC2358_TC_cal_meas_10K(QStringList args) {
    bool ok;

    int n_ch = args.at(0).toInt(&ok);
    float f = args.at(1).toFloat(&ok);

    ltc2358_driver->cal_meas_Rcal(n_ch-1, f);

    return 0;
}

// Cal_meas_curr
void LTC2358_DRIVER::cal_meas_zero_adc(int n_ch) {

    caldata_curr.data_cal_curr[n_ch].x1 = regs_ltc2358_driver->adc_data_avg[n_ch];
    caldata_curr.data_cal_curr[n_ch].y1 = 0.0;

    update_cal_from_data();
}

void LTC2358_DRIVER::cal_meas_scale_avg_adc(int n_ch, float f) {

    if (n_ch == 2){
        caldata_curr.data_cal_curr[n_ch].x2 = lld_load->regs_lld_load->pk_current;
        caldata_curr.data_cal_curr[n_ch].y2 = f;
    }
    else{
        caldata_curr.data_cal_curr[n_ch].x2 = regs_ltc2358_driver->adc_data_avg[n_ch];
        caldata_curr.data_cal_curr[n_ch].y2 = f;
    }

    update_cal_from_data();
}

float LTC2358_DRIVER::get_meas_adc_curr(int n_ch) {

    float avg = (float)regs_ltc2358_driver->adc_data_avg[n_ch];
    return cal_raw2float(avg, Cal_curr.data_cal_curr[n_ch].a, Cal_curr.data_cal_curr[n_ch].b);
}


int LTC2358_TC_cal_meas_zero_adc(QStringList args) {
    bool ok;

    int n_ch = args.at(0).toInt(&ok);

    ltc2358_driver->cal_meas_zero_adc(n_ch-1);

    return 0;
}

int LTC2358_TC_cal_meas_scale_adc(QStringList args) {
    bool ok;

    int n_ch = args.at(0).toInt(&ok);
    float f = args.at(1).toFloat(&ok);

    ltc2358_driver->cal_meas_scale_avg_adc(n_ch-1, f);

    return 0;
}

int LTC2358_TC_write_cal(QStringList args) {

    if (args.count())
        return -ENUMARGS;

    ltc2358_driver->write_cal();
    return 0;
}



//void LLD_PULSE::set_release_thres(int i, float thres){


//}

//void LLD_PULSE::set_release_time(int i, float time){

//}



