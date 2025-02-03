#include <iostream>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>
#include <math.h>
#include <sys/time.h>
#include <QApplication>
#include <QFrame>
#include <QGraphicsDropShadowEffect>
#include <QGridLayout>
#include <QStyle>
#include <Qt>
#include <QDateTime>
#include <QTimer>
#include <QDebug>
#include <QFile>
#include <QResizeEvent>
#include <QMessageBox>

#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "tc_server.h"
#include "tm_server.h"
#include "fee_tm_fwd.h"
#include "fee_tc_defs.h"

#include "config.h"
#include "timespec.h"
#include "common.h"
#include "styles.h"
#include "fpga.h"
#include "lld_load.h"
#include "csm_sim.h"
#include "ltc2358_driver.h"
#include "timestamp.h"
#include "fan_pwm.h"

#include "simple_io.h"
#include <QDebug>

/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * GRAPHICAL USER INTERFACE
*/


MainWindow::MainWindow(QWidget *parent) :
#ifdef __arm__
    QMainWindow(parent, Qt::FramelessWindowHint),
#else
    QMainWindow(parent, Qt::Dialog | Qt::MS rfsm_ctrl->rfsw_route(i);WindowsFixedSizeDialogHint),
    //QStyle * QApplication::setStyle ( const QString & style );
#endif

    ui(new Ui::MainWindow){
        int i, j;

        prev_status_dt = QDateTime::currentDateTime();



//        for(int i = 0; i<NUM_MOTORS; i++){
//            prev_motor_driver_regs[i].duty = -999.0;
//            prev_motor_driver_regs[i].period = -999.0;
//            prev_motor_driver_regs[i].step_n = -999.0;
//        }

        QFont fnt_name("Ubuntu Mono", 12);
        fnt_name.setBold(true);

        config = new QSettings("/etc/h2108-csm.ini", QSettings::IniFormat);

        ui->setupUi(this);

//        lbl_motor[0] = ui->lbl_motor_1;
//        lbl_motor[1] = ui->lbl_motor_2;
//        lbl_motor[2] = ui->lbl_motor_3;

        setFixedSize(800, 480);

        //simple_io_init(SIMPLE_IO_BASE);

        read_config();
        settings = new QSettings("/etc/h2108-csm.ini", QSettings::IniFormat);

        //pb3466 = new PB3466();

        //THREADs
        i = Config.tm_tcp_port;
        tm_server = new TM_server(this, DEF_TMTC_PREFIX,psc_tm_fwd, psc_tm_conn_str);
        connect(tm_server, SIGNAL(log(QString)), this, SLOT(log(QString)));
        connect(tm_server, SIGNAL(warning(QString)), this, SLOT(warning(QString)));
        connect(tm_server, SIGNAL(alarm(QString)), this, SLOT(alarm(QString)));
        tm_server->startServer(i);

        tc_parser = new TC_parser(tm_server, config->value("TMTC/prefix", DEF_TMTC_PREFIX).toString(), psc_init_tc_defs);

        i = Config.tc_tcp_port;
        tc_server = new TC_server(this, tc_parser);
        connect(tc_server, SIGNAL(log(QString)), this, SLOT(log(QString)));
        connect(tc_server, SIGNAL(warning(QString)), this, SLOT(warning(QString)));
        connect(tc_server, SIGNAL(alarm(QString)), this, SLOT(alarm(QString)));
        tc_server->startServer(i);

        //LTC2358
        ltc2358_driver = new LTC2358_DRIVER(FPGA_LTC2358);

        //CSM_SIM
        csm_sim =new CSM_SIM(FPGA_CSM_SIM);

        //PWM_FAN
        fan_pwm_ctrl = new FAN_PWM_ctrl(0X43C50000);

        //LLD LOAD
        lld_load = new LLD_LOAD(settings->value("TMTC/prefix", DEF_TMTC_PREFIX).toString(), FPGA_LLD_LOAD);
        QThread* thread_lld_load = new QThread;
        lld_load->moveToThread(thread_lld_load);
        connect(thread_lld_load, SIGNAL(started()), lld_load, SLOT(run()));
        connect(lld_load, SIGNAL(tm_forward(QString)), tm_server, SLOT(tm_forward(QString)));
        lld_load->start();



        timer_clock = new QTimer(this);                                                 //Timer instance for handling with GUI update
        connect(timer_clock, SIGNAL(timeout()), this, SLOT(show_status()));
        timer_clock->start(200);//50);

        connect(lld_load, SIGNAL(tm_warn(QString)), tm_server, SLOT(tm_warn(QString)));
        connect(csm_sim, SIGNAL(tm_warn(QString)), tm_server, SLOT(tm_warn(QString)));
        connect(fan_pwm_ctrl, SIGNAL(tm_warn(QString)), tm_server, SLOT(tm_warn(QString)));


        init_ui_vars();

        show_status();

        config->sync();
}

MainWindow::~MainWindow(){
    delete ui;
}

//void MainWindow::set_motor(int motor_index, int sts) {
//    if((sts == 1) && (motor_driver_ctrl[motor_index]->regs->step_n > 0)) {  // ON, so animation starts Clockwise if step_n > 0
//        lbl_motor[motor_index]->setStyleSheet("");
//        lbl_motor[motor_index]->setMovie(motorcw_act);
//        lbl_motor[motor_index]->setScaledContents(true);
//        motorcw_act->start();
//        if(sts == 0) motorcw_act->stop();

//        //fan_act->setSpeed(1000);
//    }

//    else if((sts == 1) && (motor_driver_ctrl[motor_index]->regs->step_n < 0)) {  // ON, so animation starts
//        lbl_motor[motor_index]->setStyleSheet("");
//        lbl_motor[motor_index]->setMovie(motorccw_act);
//        lbl_motor[motor_index]->setScaledContents(true);
//        motorccw_act->start();
//        if(sts == 0) motorccw_act->stop();

//        //fan_act->setSpeed(1000);
//    }
//    else {
//        lbl_motor[motor_index]->clear();
//        lbl_motor[motor_index]->setStyleSheet("QLabel {border-image: url(:/motor_cw.gif);}");
//    }
//}

void MainWindow::show_status() {

    QDateTime dt = QDateTime::currentDateTime();

    int i, j;
    int rsa;
    int prev_rsa = -1;


    static int prev_tc_conn_count = -1;
    static int prev_tm_conn_count = -1;

    //qDebug() << ltc2358_driver->get_meas_adc_curr(2);

    //fan_pwm
    fan_pwm_ctrl->thermal_control();

//    for(i = 0; i < NUM_MOTORS; i++) {
//        if(prev_status_motors[i] != motor_driver_ctrl[i]->get_motor_sts()) {
//            set_motor(i, motor_driver_ctrl[i]->get_motor_sts());
//            prev_status_motors[i] = motor_driver_ctrl[i]->get_motor_sts();
//        }
//    }

    if (dt != prev_status_dt) {
        ui->lbl_time->setText(dt.toString("yyyy.MM.dd hh:mm:ss"));
        prev_status_dt = dt;
    }

    i = tc_server->get_conn_count();
    if (i != prev_tc_conn_count) {
        prev_tc_conn_count = i;
        ui->lbl_tc_count->setText(QString("TC: %1 conn").arg(i));
        if (i)
            ui->lbl_tc_count->setStyleSheet(PROC_VAR_LABEL_STYLE + "background-color: " + get_random_bg_color() + ";");
        else
            ui->lbl_tc_count->setStyleSheet(PROC_VAR_LABEL_STYLE + "background-color: rgb(143, 197, 213);");
    }

    i = tm_server->get_conn_count();
    if (i != prev_tm_conn_count) {
        prev_tm_conn_count = i;
        ui->lbl_tm_count->setText(QString("TM: %1 conn").arg(i));
        if (i)
            ui->lbl_tm_count->setStyleSheet(PROC_VAR_LABEL_STYLE + "background-color: " + get_random_bg_color() + ";");
        else
            ui->lbl_tm_count->setStyleSheet(PROC_VAR_LABEL_STYLE + "background-color: rgb(172, 171, 171);");
    }

    if (current_frame == ui->frame_motor_loads)
        show_frame_motor_loads();
    else if (current_frame == ui->frame_lld_loads)
        show_frame_lld_loads();
    else select_frame(ui->frame_info);
}

void MainWindow::show_frame_motor_loads(void)
{
    float prev_temp[1];

    prev_temp[0] = -99.999;
    prev_temp[1] = -99.999;
    int prev_coil1_sts = 0;
    int prev_coil2_sts = 0;


    int rsa = (int)csm_sim->regs_csm_sim->rsa;

    if (csm_sim->regs_csm_sim->step_count != prev_regs_csm_sim.step_count){
        lbl_step_count->setText(QString::number(csm_sim->get_step_count(), 'f', 2));
        prev_regs_csm_sim.step_count = csm_sim->regs_csm_sim->step_count;
    }
    else
        lbl_step_count->setText("");

    for(int i; i < NUM_THERMISTOR_CHs; i++){
        if (ltc2358_driver->R_to_Temp(ltc2358_driver->get_meas_adc_ther(i))!= prev_temp[i]){
            lbl_tempt[i]->setText(QString::number(ltc2358_driver->R_to_Temp(ltc2358_driver->get_meas_adc_ther(i)), 'f', 1));
            prev_regs_csm_sim.step_count = ltc2358_driver->R_to_Temp(ltc2358_driver->get_meas_adc_ther(i));
        }
        else
            lbl_tempt[i]->setText("");
    }

    if (csm_sim->get_coil1_load() != prev_coil1_sts){
        if(csm_sim->get_coil1_load() == 1)
            lbl_coil1_load->setText("Min Load");
        if(csm_sim->get_coil1_load() == 2)
            lbl_coil1_load->setText("Max Load");
        if(csm_sim->get_coil1_load() == 3)
            lbl_coil1_load->setText("SC");
        if(csm_sim->get_coil1_load() == 0)
            lbl_coil1_load->setText("Open");
        prev_coil1_sts = csm_sim->get_coil1_load();
    }
    else
        lbl_coil1_load->setText("Open");

    if (csm_sim->get_coil2_load() != prev_coil2_sts){
        if(csm_sim->get_coil2_load() == 1)
            lbl_coil2_load->setText("Min Load");
        if(csm_sim->get_coil2_load() == 2)
            lbl_coil2_load->setText("Max Load");
        if(csm_sim->get_coil2_load() == 3)
            lbl_coil1_load->setText("SC");
        if(csm_sim->get_coil2_load() == 0)
            lbl_coil2_load->setText("Open");
        prev_coil2_sts = csm_sim->get_coil2_load();
    }
    else
        lbl_coil2_load->setText("Open");


   if (rsa != prev_rsa) {
       ui->frame_sw_1->setStyleSheet((rsa & 0x01) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));
       ui->frame_sw_2->setStyleSheet((rsa & 0x02) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));
       ui->frame_sw_3->setStyleSheet((rsa & 0x04) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));
       ui->frame_sw_4->setStyleSheet((rsa & 0x08) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));
       ui->frame_sw_5->setStyleSheet((rsa & 0x10) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));
       ui->frame_sw_6->setStyleSheet((rsa & 0x20) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));
       ui->frame_sw_7->setStyleSheet((rsa & 0x40) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));
       ui->frame_sw_8->setStyleSheet((rsa & 0x80) ? QString("image: url(:/sw_closed.png);") : QString("image: url(:/sw_open.png);"));

       prev_rsa = rsa;
   }

}

void MainWindow::show_frame_lld_loads(void)
{
    int prev_load_sts = 0;
    int prev_pulse_width = 0;
    uint64_t prev_rising_ts = 0;
    double prev_pulse_curr = 0;
    prev_regs_lld.release_time =0;
    prev_regs_lld.ctrl = 0;


    if (lld_load->get_load_sel() != prev_load_sts){
        if(lld_load->get_load_sel() == 1)
            lbl_sts_load->setText("Min Load");
        if(lld_load->get_load_sel() == 2)
            lbl_sts_load->setText("Max Load");
        if(lld_load->get_load_sel() == 3)
            lbl_sts_load->setText("SC");
        if(lld_load->get_load_sel() == 0)
            lbl_sts_load->setText("Open");
        prev_load_sts = lld_load->get_load_sel();
    }
    else
        lbl_sts_load->setText("Open");

    if (lld_load->get_lld_release_time() != prev_regs_lld.release_time){
        lbl_release_time->setText(QString::number(lld_load->get_lld_release_time(), 'f', 2));
        prev_regs_lld.release_time = lld_load->get_lld_release_time();
    }
    else
        lbl_release_time->setText("-.---");

    if (!!(lld_load->regs_lld_load->ctrl & LLD_LOAD_SIM_ENA) != !!(prev_regs_lld.ctrl & LLD_LOAD_SIM_ENA)){
        if(lld_load->get_lld_sim_enabled() == 1)
            lbl_sts_sim->setText("Active");
        else
            lbl_sts_sim->setText("Inactive");
        prev_regs_lld.ctrl = lld_load->regs_lld_load->ctrl;
    }
    else
        lbl_release_time->setText("Inactive");

    //Not cyclic

    if (lld_load->pulse_width != prev_pulse_width){
        lbl_lld_curr->setText(QString::number((lld_load->pulse_width)*1e-6, 'f', 2));
        prev_pulse_width = lld_load->pulse_width;
    }
    else
        lbl_lld_curr->setText("-.---");

    if (lld_load->rising_ts != prev_rising_ts){
        lbl_lld_ts->setText(QString::number(monoraw_to_ts(lld_load->regs_lld_load->rising_ts)*1e-9, 'f', 2));
        prev_rising_ts = lld_load->rising_ts;
    }
    else
        lbl_lld_ts->setText("-.---");

    if (lld_load->pulse_curr != prev_pulse_curr){
        lbl_lld_ts->setText(QString::number(lld_load->pulse_curr, 'f', 2));
        prev_pulse_curr = lld_load->pulse_curr;
    }
    else
        lbl_lld_ts->setText("-.---");

}


void MainWindow::init_ui_vars(){

    uint32_t version;
    QString s;

    lbl_step_count = ui->lbl_step_count;
    lbl_coil1_load = ui->lbl_coil1_load;
    lbl_coil2_load = ui->lbl_coil2_load;
    lbl_tempt[0]     = ui->lbl_tempt1;
    lbl_tempt[1]     = ui->lbl_tempt2;

    lbl_sts_load = ui->lbl_sts_loads;
    lbl_release_time = ui->lbl_release_time;
    lbl_sts_sim = ui->lbl_sts_sim;
    lbl_lld_curr = ui->lbl_lld_curr;
    lbl_lld_ts = ui->lbl_lld_ts;

    ui->lbl_sw_version->setText(QString("%1 %2").arg(SS_NAME).arg(SS_VERSION));
    version = fpga_get_version();
    s = QString("PL%1 %2.%3").arg(version >> 16, 4, 16, QLatin1Char('0')).arg((version >> 8) & 0xff, 2, 16, QLatin1Char('0')).arg(version & 0xff, 2, 16, QLatin1Char('0'));
    ui->lbl_fpga_version->setText(s);

    current_frame = ui->frame_info;
    ui->frame_lld_loads->hide();
    ui->frame_motor_loads->hide();

    select_frame(ui->frame_motor_loads);

}

void MainWindow::do_log(QString st, int level) {

    struct tm ts;
    char timest[64];
    char tst[64];
    QString qst;
    struct timeval tv;
    QString color;

    switch (level) {
        case LOG_LVL_MSG: color = QString("green"); break;
        case LOG_LVL_WARN: color = QString("#838300"); break;
        case LOG_LVL_ERR: color = QString ("red"); break;
    }

    gettimeofday(&tv, NULL);
    ts = *localtime(&tv.tv_sec);
    strftime(timest, 64, " %j:%T", &ts);
    sprintf(tst, "%s.%06d", timest, tv.tv_usec);

}

void MainWindow::log(QString st) {

    do_log(st, LOG_LVL_MSG);
}

void MainWindow::warning(QString st) {

    do_log(st, LOG_LVL_WARN);
}

void MainWindow::alarm(QString st) {

    do_log(st, LOG_LVL_ERR);
}

void MainWindow::select_frame(QFrame* f) {

    if (f == current_frame) //breakpoint
        return;
    last_frame = current_frame;
    f->show();
    if (current_frame)
        current_frame->hide();
    current_frame = f;
}

void MainWindow::on_btn_motor_clicked()
{
    select_frame(ui->frame_motor_loads);
}

void MainWindow::on_btn_lld_sim_clicked()
{
    select_frame(ui->frame_lld_loads);
}


void MainWindow::on_btn_info_ok_clicked()
{
    select_frame(ui->frame_motor_loads);
}

void MainWindow::on_btn_logo_clicked()
{
    select_frame(ui->frame_info);
}
