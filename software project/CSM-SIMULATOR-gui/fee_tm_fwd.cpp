#include "fee_tm_fwd.h"
#include "simple_io.h"
#include "fpga.h"
#include "chrony.h"
#include "config.h"
#include "simple_io.h"
#include "tc_defs.h"
#include "freq_ctr.h"
#include "timestampv2.h"
#include "ltc2358_driver.h"
#include "csm_sim.h"
#include "lld_load.h"
#include "ltc2358_driver.h"
#include "qdebug.h"
#include "fan_pwm.h"

TM_server* tm_server;

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * CSM SIMULATOR TMs
*/

QString psc_tm_conn_str() {

    uint32_t version;

    QString prefix = tm_server->get_tmtc_prefix();
    QString st = QString("%1 %2_MS %3 HV Sistemas %4 FW %5 "__DATE__" "__TIME__).arg(ts_st()).arg(prefix).arg(prefix).arg(SS_NAME).arg(SS_VERSION);

    version = fpga_get_version();
    st = st + QString(" PL%1 %2.%3\n").arg(version >> 16, 4, 16, QLatin1Char('0')).arg((version >> 8) & 0xff, 2, 16, QLatin1Char('0')).arg(version & 0xff, 2, 16, QLatin1Char('0'));
    return st;
}

void psc_tm_fwd() {

    QString hdr = ts_st() + " " + tm_server->get_tmtc_prefix() + "_TM";
    QString tm;
    int i;

    //CSM INTERFACE TMS
    tm += hdr + QString("_MECH_LIMITS");
    tm += QString(" %1").arg(csm_sim->get_mech_limit_lo());
    tm += QString(" %2").arg(csm_sim->get_mech_limit_hi());
    tm += "\n";

    tm += hdr + QString("_CSM_OPEN_POS_A_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_OPEN_POS_A));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_OPEN_POS_A));
    tm += "\n";

    tm += hdr + QString("_CSM_OPEN_POS_B_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_OPEN_POS_B));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_OPEN_POS_B));
    tm += "\n";

    tm += hdr + QString("_CSM_CLOSE_POS_A_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_CLOSE_POS_A));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_CLOSE_POS_A));
    tm += "\n";

    tm += hdr + QString("_CSM_CLOSE_POS_B_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_CLOSE_POS_B));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_CLOSE_POS_B));
    tm += "\n";

    tm += hdr + QString("_CSM_CAL_POS_A_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_CAL_POS_A));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_CAL_POS_A));
    tm += "\n";

    tm += hdr + QString("_CSM_CAL_POS_B_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_CAL_POS_B));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_CAL_POS_B));
    tm += "\n";

    tm += hdr + QString("_CSM_REF_POS_A_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_REF_POS_A));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_REF_POS_A));
    tm += "\n";

    tm += hdr + QString("_CSM_REF_POS_B_RANGE");
    tm += QString(" %1").arg(csm_sim->get_limit_lo(RSA_REF_POS_B));
    tm += QString(" %2").arg(csm_sim->get_limit_hi(RSA_REF_POS_B));
    tm += "\n";


    tm += hdr + QString("_CSM_REF_POS_STS_A_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_REF_POS_A));
    tm += "\n";
    tm += hdr + QString("_CSM_REF_POS_STS_B_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_REF_POS_B));
    tm += "\n";

    tm += hdr + QString("_CSM_CAL_POS_STS_A_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_CAL_POS_A));
    tm += "\n";
    tm += hdr + QString("_CSM_CAL_POS_STS_B_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_CAL_POS_B));
    tm += "\n";

    tm += hdr + QString("_CSM_CLOSE_POS_STS_A_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_CLOSE_POS_A));
    tm += "\n";
    tm += hdr + QString("_CSM_CLOSE_POS_STS_B_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_CLOSE_POS_B));
    tm += "\n";

    tm += hdr + QString("_CSM_OPEN_POS_STS_A_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_OPEN_POS_A));
    tm += "\n";
    tm += hdr + QString("_CSM_OPEN_POS_STS_B_ACT");
    tm += QString(" %1").arg(csm_sim->get_rsa_sts(RSA_OPEN_POS_B));
    tm += "\n";

    tm += hdr + QString("_CSM_POS_SIM_ACT");
    tm += QString(" %1").arg(csm_sim->csm_sim_get_rsa_sts());
    tm += "\n";

    tm += hdr + QString("_CSM_COIL1_LOAD");
    tm += QString(" %1").arg(csm_sim->get_coil1_load());
    tm += "\n";

    tm += hdr + QString("_CSM_COIL2_LOAD");
    tm += QString(" %1").arg(csm_sim->get_coil2_load());
    tm += "\n";

    tm += hdr + QString("_CSM_STEP_COUNT");
    tm += QString(" %1").arg(csm_sim->get_step_count());
    tm += "\n";

    //LLD INTERFACE TMS--------------------------------------------
    tm += hdr + QString("_LLD_LOAD");
    tm += QString(" %1").arg(lld_load->get_load_sel());
    tm += "\n";

    tm += hdr + QString("_LLD_RELEASE_TIME");
    tm += QString(" %1").arg(lld_load->get_lld_release_time());
    tm += "\n";

    tm += hdr + QString("_LLD_SIM_ACT");
    tm += QString(" %1").arg(lld_load->get_lld_sim_enabled());
    tm += "\n";

    tm += hdr + QString("_LOAD_TEMP");
    for(int i = 0; i<NUM_THERMISTOR_CHs; i++){
        tm += QString(" %1").arg(ltc2358_driver->R_to_Temp(ltc2358_driver->get_meas_adc_ther(i)));
    }
    tm += "\n";

    tm_server->tm_forward(tm);
}

// Functions for TCs

int tm_server_set_tm_period(QStringList args) {

    bool ok;

    if (args.count() != 1)
        return ENUMARGS;

    float f = args.at(0).toFloat(&ok);

    if (!(ok) || (f && ((f < 0.1) || (f > 10))))
        return EINVARG1;

    tm_server->set_tm_period(f);
    return 0;
}

