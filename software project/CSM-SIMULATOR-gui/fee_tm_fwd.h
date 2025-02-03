#ifndef FEE_TM_FWD_H
#define FEE_TM_FWD_H

#include <QtCore>
#include "tm_server.h"

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * CSM SIMULATOR TMs
*/

QString psc_tm_conn_str();
void psc_tm_fwd();

extern TM_server* tm_server;

// Definitions for TCs

int tm_server_set_tm_period(QStringList);

#endif // FEE_TM_FWD_H
