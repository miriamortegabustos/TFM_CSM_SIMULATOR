#ifndef CSM_SIM_H
#define CSM_SIM_H

#include <QtCore>
#include <QObject>

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * MOTOR INTERFACE: STEP COUNT, RELES CONTROL AND LOAD SELECT*/

#define FPGA_CSM_SIM        0x43C40000
#define NUM_RSAs            8
#define NUM_MECH_ENDs       2
#define CSM_SIM_ENA         0x00000001

#define CSM_SIM_MASK_1        0x00000007
#define CSM_SIM_MIN_1         0x00000004
#define CSM_SIM_MAX_1         0x00000006
#define CSM_SIM_SC_1          0x00000001

#define CSM_SIM_MASK_2        0x00000038
#define CSM_SIM_MIN_2         0x00000020
#define CSM_SIM_MAX_2         0x00000030
#define CSM_SIM_SC_2          0x00000008

#define RSA_CAL_POS_A           0
#define RSA_REF_POS_A           1
#define RSA_CLOSE_POS_A         2
#define RSA_OPEN_POS_A          3
#define RSA_CAL_POS_B           4
#define RSA_REF_POS_B           5
#define RSA_OPEN_POS_B          6
#define RSA_CLOSE_POS_B         7

// TCs function to configure CSM INTERFACE
int csm_sim_set_enable(QStringList);
int csm_sim_set_forced_rsa(QStringList);
int csm_sim_prst_val(QStringList);
int csm_sim_adc_th_neg_hi(QStringList );
int csm_sim_adc_th_neg_lo(QStringList );
int csm_sim_adc_th_pos_hi(QStringList );
int csm_sim_adc_th_pos_lo(QStringList );
int csm_sim_mech_end(QStringList);
int csm_sim_rsa_limit(QStringList);
int csm_sim_rsa_ena(QStringList);
int csm_set_mech_lim(QStringList);
int csm_sim_coil1_load(QStringList);
int csm_sim_coil2_load(QStringList);
int csm_rsa_act(QStringList);
int csm_rsa_deact(QStringList);

// R/W registers: IP core: CSM_SIM
struct T_csm_sim_regs {
    uint8_t sim_enable;         // Simulation mode
    uint8_t forced_rsa;         // Force activation/deactivation of each relay
    uint8_t rsa;                // Activation/deactivation of each relay
    uint8_t status;             // Status of all coil loads: CSM_COIL1_SC & CSM_COIL1_SEL1 & CSM_COIL1_SEL2 & CSM_COIL2_SC & CSM_COIL2_SEL1 & CSM_COIL2_SEL2, and status of mechanical end 1 or 2
    int32_t step_count;         // step_count on read, prst_val on write
    int16_t adc_th_pos_lo;      // Low threshold of the positive pulse
    int16_t adc_th_pos_hi;      // High threshold of the positive pulse
    int16_t adc_th_neg_lo;      // Low threshold of the negative pulse
    int16_t adc_th_neg_hi;      // High threshold of the negative pulse
    int32_t mech_end1;          // Min number of steps
    int32_t mech_end2;          // Max number of steps
    int32_t rsa_min[NUM_RSAs];  // Min number of steps to activate each relay
    int32_t rsa_max[NUM_RSAs];  // Max number of steps to deactivate each relay

}__attribute__((packed));

class CSM_SIM: public QObject
{
    Q_OBJECT

public:
    CSM_SIM(uint32_t );

    T_csm_sim_regs* regs_csm_sim;

    void set_csm_sim_prst_val(int);         // Sets step count
    void set_csm_sim_adc_th_pos_lo(int);    // Sets Low threshold of the positive pulse
    void set_csm_sim_adc_th_pos_hi(int);    // Sets High threshold of the positive pulse
    void set_csm_sim_adc_th_neg_lo(int);    // Sets Low threshold of the negative pulse
    void set_csm_sim_adc_th_neg_hi(int);    // Sets Min number of steps
    void set_csm_sim_mech_end(int,int);     // Sets Max number of steps
    void set_csm_sim_enable();              // Enables simulation mode
    void set_forced_rsa(int);               // Forces activation/deactivation of each relay
    void rsa_ena(uint8_t);                  // Activates each relay
    void rsa_limit(int, int, int);          // Modifies min and max step number of each relay
    void set_coil1_load(int);               // Sets coil1 load
    void set_coil2_load(int);               // Sets coil2 load
    void set_mech_lim(int, int);            // Sets min and max number of step limited by the mechanism
    void csm_selected_out_dis(int);         // Forces the deactivation of the relay selected
    void csm_selected_out_ena(int);         // Forces the activation of the relay selected

    int get_coil1_load();                   // Returns the coil1 load selected
    int get_coil2_load();                   // Returns the coil2 load selected
    uint8_t csm_sim_get_rsa_sts();          // Indicates if simulation mode is enabled of all relays
    int  get_rsa_sts(int);                  // Gets status of all relays
    int  get_step_count();                  // Returns the value of the step counter
    int get_mech_limit_lo();                // Gets mechanical low limit
    int get_mech_limit_hi();                // Gets mechanical high limit
    int get_limit_lo(int);                  // Gets min step count to activate each relay
    int get_limit_hi(int);                  // Gets max step count to deactivate each relay



private:

    int simple_io_fd;

    const char* calfile = "/etc/csm_sim.caldata"; //Configuration file


signals:

};

extern CSM_SIM* csm_sim;

#endif // CSM_SIM_H
