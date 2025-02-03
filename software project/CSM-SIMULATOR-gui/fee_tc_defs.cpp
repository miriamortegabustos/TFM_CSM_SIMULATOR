#include "simple_io.h"
#include "tm_server.h"
#include "tc_parser.h"
#include "fee_tm_fwd.h"
#include "simple_io.h"
#include "tc_defs.h"
#include "fpga.h"
#include "timestampv2.h"
#include "ltc2358_driver.h"
#include "csm_sim.h"
#include "lld_load.h"

TC_parser* tc_parser;

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * CSM SIMULATOR TCs
*/

void psc_init_tc_defs(QVector<T_TC_def>* tc_def) {

    tc_def->clear();

    //Calibration: Thermistors
    *tc_def << (T_TC_def){"CAL_VMEAS_SCALE_ADC_10K", LTC2358_TC_cal_meas_10K};
    *tc_def << (T_TC_def){"CAL_VMEAS_SC",  LTC2358_TC_cal_meas_sc};
    *tc_def << (T_TC_def){"CAL_VMEAS_OPEN",  LTC2358_TC_cal_meas_open};
    *tc_def << (T_TC_def){"CAL_VMEAS_WRITE", LTC2358_TC_write_cal};

    //Calibration: LLD and MOTOR
    *tc_def << (T_TC_def){"CAL_VMEAS_SCALE_ADC_CURR", LTC2358_TC_cal_meas_scale_adc};
    *tc_def << (T_TC_def){"CAL_VMEAS_ZERO_CURR",  LTC2358_TC_cal_meas_zero_adc};
    *tc_def << (T_TC_def){"CAL_VMEAS_WRITE", LTC2358_TC_write_cal};

    //CSM_SIM TCs
    *tc_def << (T_TC_def){"SET_MECH_LIMITS", csm_set_mech_lim};
    *tc_def << (T_TC_def){"CSM_RSA_ACT_RANGE_SET", csm_sim_rsa_limit};
    *tc_def << (T_TC_def){"CSM_POS_SIM_ENA", csm_sim_rsa_ena};
    *tc_def << (T_TC_def){"CSM_COIL1_LOAD", csm_sim_coil1_load};
    *tc_def << (T_TC_def){"CSM_COIL2_LOAD", csm_sim_coil2_load};
    *tc_def << (T_TC_def){"CSM_TH_NEG_HI", csm_sim_adc_th_neg_hi};
    *tc_def << (T_TC_def){"CSM_TH_NEG_LO", csm_sim_adc_th_neg_lo};
    *tc_def << (T_TC_def){"CSM_TH_POS_HI", csm_sim_adc_th_pos_hi};
    *tc_def << (T_TC_def){"CSM_TH_POS_LO", csm_sim_adc_th_pos_lo};
    *tc_def << (T_TC_def){"CSM_RSA_ACT", csm_rsa_act};
    *tc_def << (T_TC_def){"CSM_RSA_DEACT", csm_rsa_deact};
    *tc_def << (T_TC_def){"SET_STEPS", csm_sim_set_prst_val};

    //LLD_LOAD TCs
    *tc_def << (T_TC_def){"LLD_SIM_DIS", lld_load_sim_disable};
    *tc_def << (T_TC_def){"LLD_SIM_ENA", lld_load_sim_enable};
    *tc_def << (T_TC_def){"LLD_LOAD", lld_load_set_load_sel};
    *tc_def << (T_TC_def){"LLD_RELEASE_TIME", lld_load_release_time};
}

