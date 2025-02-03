#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QSettings>
#include "config.h"
#include "lld_load.h"

struct TConfig Config;

QSettings *config;


const QStringList config_defaults[] = {

    QStringList() << "TMTC/tc_tcp_port" << "12345",
    QStringList() << "TMTC/tm_tcp_port" << "12346",
    QStringList() << "misc/ntp_server_address" << "10.21.8.3",

    QStringList() << "" << ""

};

/************************************************************************************************
 * @brief read_config                                                                           *
 * @desc: Create the file config and put the inicialize values of powe supply. Vuvp<95%.Vset    *
 ************************************************************************************************/
void read_config (void)
{
    QStringList keys;
    QStringList v;
    int i;

    config = new QSettings(CONFIG_FILE_NAME, QSettings::IniFormat);
    keys = config->allKeys();

    i = 0;
    while(config_defaults[i].at(0) != "")
    {
        if (!keys.contains(config_defaults[i].at(0)))
            config->setValue(config_defaults[i].at(0), config_defaults[i].at(1));

        i++;
    }

    Config.tc_tcp_port = config->value("TMTC/tc_tcp_port", "12345").toUInt();
    Config.tm_tcp_port = config->value("TMTC/tm_tcp_port", "12346").toUInt();
    Config.ntp_server_address = config->value("misc/ntp_server_address", "10.21.8.3").toString();

//    regs_lld_load->thres_hi = cal_float2raw(0.1, ltc2358_driver->Cal_curr.data_cal_curr[2].a, ltc2358_driver->Cal_curr.data_cal_curr[2].b); //100mA
//    regs_lld_load->thres_lo = cal_float2raw(0.08, ltc2358_driver->Cal_curr.data_cal_curr[2].a, ltc2358_driver->Cal_curr.data_cal_curr[2].b); //80mA
//    regs_lld_load->release_time = 10*1e5;

}
