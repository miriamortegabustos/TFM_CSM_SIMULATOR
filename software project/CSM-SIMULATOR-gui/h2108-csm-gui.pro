#-------------------------------------------------
#
# Project created by QtCreator
# By Miriam Ortega Bustos
# February 2025
#
#-------------------------------------------------

QT += gui core
QT += core gui network
QT += widgets
CONFIG += static chart
target.path = /usr/bin

TARGET = h2108-csr-gui

INSTALLS += target

QMAKE_CXXFLAGS += -O2 -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -Wfatal-errors -I./ethercat
QMAKE_CFLAGS += -O2 -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -Wfatal-errors -I./ethercat

DEFINES += Q_COMPILER_INITIALIZER_LISTS

SOURCES += main.cpp\
    chrony.cpp \
    config.cpp \
    csm_sim.cpp \
    fan_pwm.cpp \
    fee_tc_defs.cpp \
    fee_tm_fwd.cpp \
    fpga.cpp \
    freq_ctr.cpp \
    lld_load.cpp \
    ltc2358_driver.cpp \
    sync_ts.cpp \
    mainwindow.cpp \
    minIni/minIni.c \
    simple_io.cpp \
    tc_parser.cpp \
    tc_server.cpp \
    timespec.c \
    timestamp.cpp \
    timestampv2.cpp \
    tm_server.cpp \
    common.cpp


HEADERS  += mainwindow.h \
    chrony.h \
    chrony/addressing.h \
    chrony/candm.h \
    chrony/cmac.h \
    chrony/hash.h \
    chrony/ntp.h \
    chrony/sysincl.h \
    chrony/util.h \
    config.h \
    csm_sim.h \
    ethercat/ecrt.h \
    fan_pwm.h \
    fee_tc_defs.h \
    fee_tm_fwd.h \
    fpga.h \
    freq_ctr.h \
    lld_load.h \
    ltc2358_driver.h \
    sync_ts.h \
    minIni/minGlue.h \
    minIni/minIni.h \
    simple_io.h \
    tc_defs.h \
    tc_parser.h \
    tc_server.h \
    timespec.h \
    timestamp.h \
    timestampv2.h \
    tm_server.h \
    common.h \
    styles.h

FORMS    += \
    mainwindow.ui

RESOURCES += \
    images.qrc \
    leds.qrc \
    icons.qrc
#INCLUDEPATH += "../qwt-5.2/src"

use_libs {

} else {
#LIBS += "../qwt-5.2/lib/libqwtd5.a"
#LIBS += "../CanFestival-3/src/libcanfestival.a"
linux-g++ {
    LIBS += -ldl -lrt
#./libs/libz.so.1 ./libs/libpng16.so.16

} else {
    LIBS += -ldl -lrt
#./libs/libz.so.1 ./libs/libpng16.so.16
}

#LIBS += -L$$PWD/ -L./ethercat -lethercat


QMAKE_LFLAGS = "-L/qt/mingw/lib -L/qt/2009.03/mingw/lib -L../../CanFestival-3/src -L../../CanFestival-3/drivers/unix"
#LIBS += "-lwinmm"
#LIBS += "-lsetupapi"
}

DISTFILES += \
    interruptor1-open.jpg
