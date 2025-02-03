#ifndef LLD_LOAD_H
#define LLD_LOAD_H

#include <QtCore>
#include <QObject>

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * LLD INTERFACE: Pulse detected, release time and set pulse thresholds*/

#define FPGA_LLD_LOAD        0x43C70000
#define NUM_LOADs            3
#define LLD_LOAD_ENA         0x00000001

#define LLD_LOAD_MASK       0x00000007
#define LLD_LOAD_MIN        0x00000002
#define LLD_LOAD_MAX        0x00000003
#define LLD_LOAD_SC         0x00000004

#define LLD_LOAD_SIM_ENA    0x00000008

// TCs function to configure LLD INTERFACE
int lld_load_sim_disable(QStringList);
int lld_load_sim_enable(QStringList);
int lld_load_set_load_sel(QStringList);
int lld_load_release_time(QStringList);
int csm_sim_set_prst_val(QStringList);

// R/W register: IP core: LLD_LOAD
struct T_lld_load_regs {
    uint32_t ctrl;          // Register to set LLD loads and run the simulation
    uint32_t status;        // Status of the loads selected
    int16_t thres_lo;       // Low threshold to detect the start of the ICU pulse
    int16_t thres_hi;       // High threshold to detect the end of the ICU pulse
    uint32_t release_time;  // Time to release LLD
    int64_t rising_ts;      // Rising time of the pulse detected
    int64_t falling_ts;     // Falling time of the pulse detected
    int32_t reserved;       // not used
    int16_t pk_current;     // Max current value detected

}__attribute__((packed));

class LLD_LOAD: public QThread
{
    Q_OBJECT

public:
    LLD_LOAD(QString tmtc_prefix, uint32_t base);
    double pulse_width;     // Pulse width of the pulse detected
    double pulse_curr = 0;  //Current value of the pulse detected
    int64_t rising_ts;      // Rising time detected

    struct T_lld_load_regs* regs_lld_load;           
    void set_csm_sim_load_sel(int);     // Sets simulation mode
    void set_lld_release_time(float);   // Sets release time
    void set_lld_load_thres_hi(int);    // Sets high therhold
    void set_lld_load_thres_lo(int);    // Sets low threshold
    void set_lld_sim_enable();          // Activates simulation
    void set_lld_sim_disable();         // Deactivates simulation
    void set_load_sel(int);             // Sets LLD loads

    int32_t get_release_time();         // Gets release time
    int64_t get_rising_ts();            // Gets rising time of pulse detected
    int64_t get_falling_ts();           // Gets falling time of pulse detected
    uint64_t get_pulse_width();         // Return the width of the pulse detected
    int get_load_sel();                 // Return the load selected
    bool get_lld_sim_enabled();         // Gets the used mode
    float get_lld_release_time();       // Gets release time configured

private:
    void update_cal_from_data();        // Updates calibrated values of LLD interface
    void read_cal();                    // Reads calibration data of LLD interface
    QString tmtc_prefix;

    const char* calfile = "/etc/lld_load.caldatsa"; //Configuration file

public slots:
    void run();

signals:
    void tm_forward(QString);

};

extern LLD_LOAD* lld_load;

#endif // LLD_LOAD_H
