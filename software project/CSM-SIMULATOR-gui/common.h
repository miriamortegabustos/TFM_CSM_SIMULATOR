
#ifndef COMMON_H
#define COMMON_H

#include <QString>
#include <QSettings>
#include <stdint.h>

#define DEF_TMTC_PREFIX "CSM"
#define SS_NAME "H2108-CSM"
#define SS_VERSION "1.00.00"

//#define CAL_DATA_FILE_NAME "/etc/h2108-csm.caldata"
#define SETTINGS_FILE_NAME "/etc/h2108-csm.ini"

#define GPIO_BASE (960)

extern QSettings* settings;

QString ts_st();
QString ts_st_ts(struct timespec ts);
QString ts_st_i(int s, int ns);
QString ts_st_u64(uint64_t ts);
void getnstimeofday(struct timespec* ts);
float timediffms(struct timespec t1, struct timespec t2);
int hex_to_byte(char*, unsigned char*);
QString cur_time_st();
void rawts2ts(uint64_t rts, struct timespec* ts);
int cal_float2raw(float, float, float);
float cal_raw2float(int,float, float);
QString get_random_bg_color();
int str_to_word_array(QString, uint16_t*, int);
QString getHeatMapColor(float);
float cal_raw2float(int i, float a, float b);
int cal_float2raw(float i, float a, float b);

#endif // COMMON_H
