#include "common.h"
#include <Qt>
#include <QString>
#include <sys/time.h>
#include <stdio.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <math.h>

QSettings* settings;

QString ts_st() {

    struct timespec ts;

    clock_gettime(CLOCK_REALTIME, &ts);
    return QString("%1.%2").arg(ts.tv_sec).arg(ts.tv_nsec, 9, 10, QLatin1Char('0'));
}

QString ts_st_ts(struct timespec ts) {

    char st[64];

    return QString("%1.%2").arg(ts.tv_sec).arg(ts.tv_nsec, 9, 10, QLatin1Char('0'));
}

QString ts_st_i(int s, int ns) {

    char st[64];

    return QString("%1.%2").arg(s).arg(ns, 9, 10, QLatin1Char('0'));
}

QString ts_st_u64(uint64_t ts) {

    return QString("%1.%2").arg(ts/1000000000).arg(ts%1000000000, 9, 10, QLatin1Char('0'));
}

void getnstimeofday(struct timespec* ts) {

    struct timeval tv;

    gettimeofday(&tv, NULL);
    ts->tv_sec = tv.tv_sec;
    ts->tv_nsec = 1000*tv.tv_usec;
}

float timediffms(struct timespec t1, struct timespec t2) {

    float t;

    t = t2.tv_sec - t1.tv_sec;
    t += (t2.tv_nsec - t1.tv_nsec)*1e-9;
    return t*1000.0;

}


int hex_to_byte(char* h, unsigned char* p) {

    register unsigned char c;

    if ((*h >= '0') && (*h <= '9')) c = *h - '0';
    else if ((*h >= 'a') && (*h <= 'f')) c = *h - 'a' + 0x0a;
    else if ((*h >= 'A') && (*h <= 'F')) c = *h - 'A' + 0x0a;
    else return -1;
    c <<= 4;
    h++;
    if ((*h >= '0') && (*h <= '9')) c += *h - '0';
    else if ((*h >= 'a') && (*h <= 'f')) c += *h - 'a' + 0x0a;
    else if ((*h >= 'A') && (*h <= 'F')) c += *h - 'A' + 0x0a;
    else return -1;
    *p = c;
    return 1;
}

QString cur_time_st() {

    time_t itime;
    struct tm ts;
    char timest[64];

    itime = time(&itime);
    ts = *localtime(&itime);
    strftime(timest, 64, " %j:%T", &ts);
    return QString(timest);
}

QString get_random_bg_color() {

    return "#" + QString::number((random() & 0xffffff) | 0x808080, 16);
}

int str_to_word_array(QString s, uint16_t* p, int max_words) {

    int i;
    int count = 0;
    int len = s.length();
    bool ok;

    if(!len)
        return 0;

    if (len % 4)
        return -1;

    if (len > 4*max_words)
        len = 4*max_words;

    for(i = 0; i < len; i+= 4) {
        *p++ = s.mid(i, 4).toUInt(&ok, 16);
        count++;
        if (!ok)
            return -1;
    }

    return count;
}

QString getHeatMapColor(float value) {

  const int NUM_COLORS = 4;
  static float color[NUM_COLORS][3] = { {0,0,.60}, {0,.60,0}, {.60,.60,0}, {.60,0,0} };
  uint8_t red;
  uint8_t green;
  uint8_t blue;

  int idx1;
  int idx2;
  float fractBetween = 0;

  if (value <= 0) {
      idx1 = idx2 = 0;
  }
  else if (value >= 1) {
      idx1 = idx2 = NUM_COLORS-1;
  }
  else {
    value = value * (NUM_COLORS-1);
    idx1  = floor(value);
    idx2  = idx1+1;
    fractBetween = value - float(idx1);
  }

  red  = 255*((color[idx2][0] - color[idx1][0])*fractBetween + color[idx1][0] + 0.40);
  green = 255*((color[idx2][1] - color[idx1][1])*fractBetween + color[idx1][1] + 0.40);
  blue  = 255*((color[idx2][2] - color[idx1][2])*fractBetween + color[idx1][2] + 0.40);

  QString s = QString("#%1%2%3").arg(red, 2, 16, QLatin1Char('0')).arg(green, 2, 16, QLatin1Char('0')).arg(blue, 2, 16, QLatin1Char('0'));

  return s;
}

float cal_raw2float(int i, float a, float b) {

    return a*i+b;
}

int cal_float2raw(float f, float a, float b) {

    return (f-b)/a;
}

