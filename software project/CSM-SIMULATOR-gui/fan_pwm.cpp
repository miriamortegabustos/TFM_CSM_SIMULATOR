#include <fcntl.h>
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <math.h>
#include <QDebug>
#include "fpga.h"
#include "fan_pwm.h"
#include "tc_defs.h"
#include "simple_io.h"
#include "tm_server.h"
#include "ltc2358_driver.h"

#define  FAN_PWM_BASE 0X43C50000 //Motor Driver address from FPGA's Processing System

#define PAGE_SIZE ((size_t)getpagesize())
#define PAGE_MASK ((uint64_t)(long)~(PAGE_SIZE - 1))

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * Thermal control: Set duty cicle*/

FAN_PWM_ctrl* fan_pwm_ctrl;

 FAN_PWM_ctrl::FAN_PWM_ctrl(uint32_t base) {
    int fd;

    fd = open("/dev/mem", O_RDWR);
    if (fd < 0) {
        printf("open(/dev/mem) failed (%d)\n", errno);
        return;
    }

    regs = (struct T_fan_pwm_tc_regs*)mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, base);
    if (regs == MAP_FAILED) {
        printf("mmap64(0x%x@0x%lx) failed (%d)\n", PAGE_SIZE, base, errno);
        return;
    }

    timer = new QTimer(this);                                                 //Timer instance for handling with GUI update
    //connect(timer, SIGNAL(timeout()), this, SLOT(check_end_sequence()));
    timer->start(10);

}

 void FAN_PWM_ctrl::set_fan_pwm (float pwm) {

     int i = pwm*2.55;

     if (i > DC_MAX_RANGE)
         i = DC_MAX_RANGE;
     else if (i < 0)
         i = 0;

     fan_pwm_ctrl->regs->pwm = i;
 }


 void FAN_PWM_ctrl::thermal_control() {

     float t, t2;
     float p;

     t = ltc2358_driver->R_to_Temp(ltc2358_driver->get_meas_adc_ther(0)); //First temperature acquired
     t2 =ltc2358_driver->R_to_Temp(ltc2358_driver->get_meas_adc_ther(1)); //Second temperature acquired

     if (t2 > t) t = t2;
     if (t < PWM_TMIN)
     {
         if(!(fan_pwm_ctrl->regs->pwm) || t < (PWM_TMIN-1))
             set_fan_pwm(PWM_0);
     }
     else if (t > PWM_TMAX)
         set_fan_pwm(PWM_100);
     else {
         p = DC_MIN + ((PWM_100-DC_MIN)*(t-PWM_TMIN)/(PWM_TMAX-PWM_TMIN));
         set_fan_pwm(p);
     }
 }
