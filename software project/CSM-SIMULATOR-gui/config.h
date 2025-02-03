#ifndef __CONFIG_H__
#define __CONFIG_H__

#include <QtCore>
#include <QString>
#include <QSettings>

#define CONFIG_FILE_NAME "/etc/h2108-csm.ini"

struct TConfig {
    int 	tm_tcp_port;
    int 	tc_tcp_port;
    QString	ntp_server_address;
};

extern struct TConfig Config;
extern QSettings *config;

void read_config(void);

#endif // __CONFIG_H__
