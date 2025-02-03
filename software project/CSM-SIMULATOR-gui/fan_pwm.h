#ifndef FAN_PWM_H
#define FAN_PWM_H

#include <QtCore>
#include <QObject>

#define PWM_100         100.0
#define PWM_0           0.0
#define PWM_TMAX        55.0
#define PWM_TMIN        30.0
#define DC_MIN          22
#define DC_MAX_RANGE    255

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * Thermal control: Set duty cicle*/

// TC functions
int fan_pwm_set_duty(QStringList);

// R/W register: IP core: FAN_PWM
struct T_fan_pwm_tc_regs {
    uint8_t pwm;
}__attribute__((packed));

class FAN_PWM_ctrl: public QObject
{
    Q_OBJECT

public:
     FAN_PWM_ctrl(uint32_t base);

    void set_fan_pwm (float pwm);   // set duty cicle

    void thermal_control();         // Modifies duty cicle depending on the temperature

    T_fan_pwm_tc_regs* regs;

private:
    QTimer* timer;

signals:
    void tm_warn(QString);
    void tm_log(QString);


};

extern FAN_PWM_ctrl* fan_pwm_ctrl;

#endif // FAN_PWM_H
