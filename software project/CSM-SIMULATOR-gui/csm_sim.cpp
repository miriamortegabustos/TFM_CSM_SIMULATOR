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
#include "csm_sim.h"
#include "ltc2358_driver.h"
#include "config.h"

#define PAGE_SIZE ((size_t)getpagesize())
#define PAGE_MASK ((uint64_t)(long)~(PAGE_SIZE - 1))

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * MOTOR INTERFACE: STEP COUNT, RELES CONTROL AND LOAD SELECT*/

CSM_SIM* csm_sim;

CSM_SIM::CSM_SIM(uint32_t base) {
    int fd;

    fd = open("/dev/mem", O_RDWR);
    if (fd < 0) {
        printf("open(/dev/mem) failed (%d)\n", errno);
        return;
    }

    regs_csm_sim = (struct T_csm_sim_regs*)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, base);
    if (regs_csm_sim == MAP_FAILED) {
        printf("mmap64(0x%x@0x%lx) failed (%d)\n", PAGE_SIZE, base, errno);
        return;
    }

    //initialization

    regs_csm_sim->sim_enable = 0;
    regs_csm_sim->forced_rsa = 0;
//    regs_csm_sim->state_rsa = 0;

    regs_csm_sim->adc_th_pos_lo = cal_float2raw(config->value("CSM/thr_pos_lo", "0.03").toFloat(), ltc2358_driver->Cal_curr.data_cal_curr[0].a, ltc2358_driver->Cal_curr.data_cal_curr[0].b); //30mA;
    regs_csm_sim->adc_th_pos_hi = cal_float2raw(config->value("CSM/thr_pos_hi", "0.1").toFloat(), ltc2358_driver->Cal_curr.data_cal_curr[0].a, ltc2358_driver->Cal_curr.data_cal_curr[0].b); //40mA;
    regs_csm_sim->adc_th_neg_lo = cal_float2raw(config->value("CSM/thr_neg_lo", "-0.1").toFloat(), ltc2358_driver->Cal_curr.data_cal_curr[0].a, ltc2358_driver->Cal_curr.data_cal_curr[0].b); //-40mA;
    regs_csm_sim->adc_th_neg_hi = cal_float2raw(config->value("CSM/thr_neg_hi", "-0.03").toFloat(), ltc2358_driver->Cal_curr.data_cal_curr[0].a, ltc2358_driver->Cal_curr.data_cal_curr[0].b); //-30mA;

    regs_csm_sim->mech_end1 = -4700;
    regs_csm_sim->mech_end2 = 1700;

    regs_csm_sim->rsa_min[RSA_OPEN_POS_A] =1475;
    regs_csm_sim->rsa_min[RSA_OPEN_POS_B] =1525;
    regs_csm_sim->rsa_min[RSA_CLOSE_POS_A] =-100;
    regs_csm_sim->rsa_min[RSA_CLOSE_POS_B] =-150;
    regs_csm_sim->rsa_min[RSA_REF_POS_A] =-50;
    regs_csm_sim->rsa_min[RSA_REF_POS_B] =-100;
    regs_csm_sim->rsa_min[RSA_CAL_POS_A] =-4750;
    regs_csm_sim->rsa_min[RSA_CAL_POS_B] =-4750;

    regs_csm_sim->rsa_max[RSA_OPEN_POS_A] =1750;
    regs_csm_sim->rsa_max[RSA_OPEN_POS_B] =1750;
    regs_csm_sim->rsa_max[RSA_CLOSE_POS_A] =50;
    regs_csm_sim->rsa_max[RSA_CLOSE_POS_B] =100;
    regs_csm_sim->rsa_max[RSA_REF_POS_A] =100;
    regs_csm_sim->rsa_max[RSA_REF_POS_B] =150;
    regs_csm_sim->rsa_max[RSA_CAL_POS_A] =-4525;
    regs_csm_sim->rsa_max[RSA_CAL_POS_B] =-4475;

}

void CSM_SIM::set_csm_sim_enable(){
        regs_csm_sim->sim_enable |= CSM_SIM_ENA;
}

int csm_sim_set_enable(QStringList args) {

    if (args.count() != 0)
        return -ENUMARGS;

    csm_sim->set_csm_sim_enable();
    return 0;
}

void CSM_SIM::set_csm_sim_prst_val(int i){
        regs_csm_sim->step_count = i;
}

int csm_sim_set_prst_val(QStringList args) {

    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok)
            csm_sim->set_csm_sim_prst_val(i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::set_csm_sim_adc_th_pos_lo(int i){
    regs_csm_sim->adc_th_pos_lo = i;
}

int csm_sim_adc_th_pos_lo(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (i >= 0))
            csm_sim->set_csm_sim_adc_th_pos_lo(i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::set_csm_sim_adc_th_pos_hi(int i){
    regs_csm_sim->adc_th_pos_hi = i;
}

int csm_sim_adc_th_pos_hi(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (i >= 0))
            csm_sim->set_csm_sim_adc_th_pos_hi(i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::set_csm_sim_adc_th_neg_lo(int i){
    regs_csm_sim->adc_th_neg_lo = i;
}

int csm_sim_adc_th_neg_lo(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (i >= 0))
            csm_sim->set_csm_sim_adc_th_neg_lo(i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::set_csm_sim_adc_th_neg_hi(int i){
    regs_csm_sim->adc_th_neg_hi = i;
}

int csm_sim_adc_th_neg_hi(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int i= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (i >= 0))
            csm_sim->set_csm_sim_adc_th_neg_hi(i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::set_csm_sim_mech_end(int n_mech, int i){
    if (n_mech == 1)
        regs_csm_sim->mech_end1 = i;
    else if (n_mech == 2)
        regs_csm_sim->mech_end2 = i;
}

int csm_sim_mech_end(QStringList args) {
    bool ok;

    if (args.count() != 2)
        return -ENUMARGS;

    int ch= args.at(0).toInt(&ok);
    int i= args.at(1).toInt(&ok);

    if (ok) {
        if (ok && ((ch == 1) || (ch == 2)) && (i>=0) )
            csm_sim->set_csm_sim_mech_end(ch, i);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::rsa_ena(uint8_t ena){

    regs_csm_sim->sim_enable = ena ;
}

void CSM_SIM::rsa_limit(int n_rsa, int low_lim, int hig_lim){
    if (n_rsa < NUM_RSAs){
       regs_csm_sim->rsa_min[n_rsa] = low_lim;
       regs_csm_sim->rsa_max[n_rsa] = hig_lim;
    }
}

uint8_t CSM_SIM::csm_sim_get_rsa_sts(){

    return regs_csm_sim->sim_enable;

}

int CSM_SIM::get_rsa_sts(int n_rsa){
    return !!(regs_csm_sim->rsa & (1 << n_rsa));
}

int CSM_SIM::get_step_count(){
    return regs_csm_sim->step_count;
}

int CSM_SIM::get_mech_limit_lo(){
    return regs_csm_sim->mech_end1;
}

int CSM_SIM::get_mech_limit_hi(){
    return regs_csm_sim->mech_end2;
}

int CSM_SIM::get_limit_lo(int rsa_out){
    return regs_csm_sim->rsa_min[rsa_out];
}

int CSM_SIM::get_limit_hi(int rsa_out){
    return regs_csm_sim->rsa_max[rsa_out];
}

int csm_sim_rsa_ena(QStringList args){
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    uint8_t ena= args.at(0).toInt(&ok);
    if(!ok)
        return EINVARG1;

    csm_sim->rsa_ena(ena);

    return 0;
}

void CSM_SIM::set_mech_lim(int min_steps, int max_steps){
    regs_csm_sim->mech_end1 = min_steps;
    regs_csm_sim->mech_end2 = max_steps;
}

int csm_set_mech_lim(QStringList args){
    bool ok;

    if (args.count() != 2)
        return -ENUMARGS;

    int min_steps= args.at(0).toInt(&ok);
    int max_steps= args.at(1).toInt(&ok);

    if (ok) {
            csm_sim->set_mech_lim(min_steps, max_steps);
    } else {
        return EINVARG1;
    }
    return 0;
}

int csm_sim_rsa_limit(QStringList args) {
    bool ok;

    if (args.count() != 3)
        return -ENUMARGS;

    int rsa_output= args.at(0).toInt(&ok);
    int low_lim= args.at(1).toInt(&ok);
    int hig_lim= args.at(2).toInt(&ok);


    if (ok) {
            csm_sim->rsa_limit(rsa_output, low_lim, hig_lim);
    } else {
        return EINVARG1;
    }
    return 0;
}

int CSM_SIM::get_coil1_load(){

    switch (regs_csm_sim->status & CSM_SIM_MASK_1) {
        case CSM_SIM_MIN_1: return 1; break;
        case CSM_SIM_MAX_1: return 2; break;
        case CSM_SIM_SC_1: return 3; break;
    default: return 0;
    }
}

void CSM_SIM::set_coil1_load(int i) {

    uint32_t u;
    //regs_lld_load->load_sel[i] = 1;

    u = regs_csm_sim->status & ~CSM_SIM_MASK_1;
    switch (i) {
        case 1: u |= CSM_SIM_MIN_1; break;
        case 2: u |= CSM_SIM_MAX_1; break;
        case 3: u |= CSM_SIM_SC_1; break;
    }
    regs_csm_sim->status = u;
}

int CSM_SIM::get_coil2_load(){

    switch (regs_csm_sim->status & CSM_SIM_MASK_2) {
        case CSM_SIM_MIN_2: return 1; break;
        case CSM_SIM_MAX_2: return 2; break;
        case CSM_SIM_SC_2: return 3; break;
    default: return 0;
    }
}

void CSM_SIM::set_coil2_load(int i) {

    uint32_t u;
    //regs_lld_load->load_sel[i] = 1;

    u = regs_csm_sim->status & ~CSM_SIM_MASK_2;
    switch (i) {
        case 1: u |= CSM_SIM_MIN_2; break;
        case 2: u |= CSM_SIM_MAX_2; break;
        case 3: u |= CSM_SIM_SC_2; break;
    }
    regs_csm_sim->status = u;
}


int csm_sim_coil1_load(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int load_sts= args.at(0).toInt(&ok);

    if (ok) {
        if (ok &&  (load_sts <= 3))
            csm_sim->set_coil1_load(load_sts);
    } else {
        return EINVARG1;
    }
    return 0;
}

int csm_sim_coil2_load(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int load_sts= args.at(0).toInt(&ok);

    if (ok) {
        if (ok &&  (load_sts <= 3))
            csm_sim->set_coil2_load(load_sts);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::csm_selected_out_dis(int selected_out){
       regs_csm_sim->forced_rsa &= ~(1 << selected_out);
}

int csm_rsa_deact(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int selected_out= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (selected_out >= 0) && (selected_out <= 7))
            csm_sim->csm_selected_out_dis(selected_out);
    } else {
        return EINVARG1;
    }
    return 0;
}

void CSM_SIM::csm_selected_out_ena(int selected_out){
       regs_csm_sim->forced_rsa  |= (1 << selected_out);
}

int csm_rsa_act(QStringList args) {
    bool ok;

    if (args.count() != 1)
        return -ENUMARGS;

    int selected_out= args.at(0).toInt(&ok);

    if (ok) {
        if (ok && (selected_out >= 0) && (selected_out <= 7))
            csm_sim->csm_selected_out_ena(selected_out);
    } else {
        return EINVARG1;
    }
    return 0;
}

