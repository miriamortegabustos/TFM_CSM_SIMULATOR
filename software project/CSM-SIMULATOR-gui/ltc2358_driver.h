#ifndef LTC2358_DRIVER_H
#define LTC2358_DRIVER_H

#include <QtCore>
#include <QObject>

#define NUM_CURRENT_CHs 3
#define NUM_THERMISTOR_CHs 2
#define NUM_ADC_CH  NUM_CURRENT_CHs + NUM_THERMISTOR_CHs

#define FPGA_LTC2358        0x43C30000

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * LTC2358: Calibration of all measures acquired by ADC*/

// TCs function for temperatures and currents calibration
int LTC2358_TC_cal_meas_zero_adc(QStringList);
int LTC2358_TC_cal_meas_scale_adc(QStringList);

int LTC2358_TC_cal_meas_sc(QStringList);
int LTC2358_TC_cal_meas_open(QStringList);
int LTC2358_TC_cal_meas_10K(QStringList);
int LTC2358_TC_write_cal(QStringList);

// Calibration of the current acquires by ADC
struct T_2p_cal {
    float x1;
    float x2;
    float y1;
    float y2;
};

struct T_slope {
    float a;
    float b;
};

struct T_ADC_curr_caldata {

    struct T_2p_cal  data_cal_curr[NUM_CURRENT_CHs];
};

struct T_ADC_curr_cal {

    struct T_slope   data_cal_curr[NUM_CURRENT_CHs];
};

// Calibration of the temperatures acquired by thermistors
typedef struct T_2p_R_cal {
    int16_t x_sc;
    int16_t x_o;
    int16_t xcal;
    float r_cal;
}T_2p_R_cal;

typedef struct T_Cal {
//    float a;
//    float b;
    float Rb;
}T_Cal;

struct T_ADC_ther_caldata {

    struct T_2p_R_cal  data_cal_ther[NUM_THERMISTOR_CHs];
};

struct T_ADC_ther_cal {

    struct T_Cal   data_cal_ther[NUM_THERMISTOR_CHs];
};

// R/W register: IP core: LTC2358
struct T_ltc2358_driver_regs {
    int16_t adc_data_raw[8];
    int16_t adc_data_avg[8];
}__attribute__((packed));

class LTC2358_DRIVER: public QObject
{
    Q_OBJECT

public:
    LTC2358_DRIVER(uint32_t );
    //~PYROS_ctrl();

    struct T_ltc2358_driver_regs* regs_ltc2358_driver;

    struct T_2p_R_cal ADC[NUM_THERMISTOR_CHs];

    void cal_meas_zero_adc(int);                // Sets zero
    void cal_meas_scale_avg_adc(int , float );  // Sets current measured by oscilloscope
    float get_meas_adc_curr(int);               // Gets calibrated current

    void cal_meas_sc(int n_ch);                 // Sets short-circuit measurement
    void cal_meas_open(int n_ch);               // Sets open-circuit measurement
    void cal_meas_Rcal(int n_ch, float f);      // Sets resistor value measured by multimeter
    float get_meas_adc_ther(int n_ch);          // Gets resistor calibrated value

    void write_cal();                           // Write in a configuration file all the calibrations

    float R_to_Temp(float);                     // Conversion method, obtains temperature depending of the resistor value

    struct T_ADC_curr_caldata caldata_curr;
    struct T_ADC_curr_cal Cal_curr;
    struct T_ADC_ther_caldata caldata_ther;
    struct T_ADC_ther_cal Cal_ther;

private:

    void update_cal_from_data();        // Updates calibrated values of LLD interface
    void read_cal();                    // Reads calibration data of LLD interface

    int simple_io_fd;

    const char* calfile = "/etc/ltc2358_driver.caldata"; // Configuration file


signals:

};

extern LTC2358_DRIVER* ltc2358_driver;

#endif // LTC2358_DRIVER_H
