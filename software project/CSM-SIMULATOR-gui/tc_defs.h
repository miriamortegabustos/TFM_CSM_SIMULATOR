#ifndef TC_DEFS_H
#define TC_DEFS_H

#include <QtCore>
//#include "tc_parser.h"

#define TC_LATE_CONFIRMATION    1
#define TC_OK                   0
#define EINVARG1               -1
#define EINVARG2               -2
#define EINVARG3               -3
#define EINVARG4               -4
#define EINVARG5               -5
#define EINVARG6               -6
#define ENUMARGS             -101
#define ERRWMSG              -102
#define WARNWMSG             -103

class T_TC_def {
    public:
        QString id;
        int (*method)(QStringList);
        int operator == (T_TC_def c1) {
            return id == c1.id;
        }
};

Q_DECLARE_TYPEINFO(class T_TC_def, Q_PRIMITIVE_TYPE);

typedef void(*t_tc_init_funct)(QVector<T_TC_def>* tc_def);

#endif // TC_DEFS_H
