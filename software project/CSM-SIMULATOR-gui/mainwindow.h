#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTableWidgetItem>
#include <QPushButton>
#include <QLabel>
#include <QProgressBar>
#include "csm_sim.h"

#ifndef __arm__
//#include "ui_sim_values.h"
#endif


/* MIRIAM ORTEGA BUSTOS
 * FEBRERO 2025
 * GRAPHICAL USER INTERFACE
*/

#include "tm_server.h"
#include "tc_server.h"
#include "tc_parser.h"
#include "sync_ts.h"
#include "ltc2358_driver.h"
#include "lld_load.h"

#define LOG_LVL_MSG     0
#define LOG_LVL_WARN    1
#define LOG_LVL_ERR     2
#define SIMPLE_IO_BASE  0x43c60000


namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT    

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();


private:

    Ui::MainWindow *ui;
    TC_server* tc_server;
    QTimer* timer_clock;
    QTimer* idle_timer;
    int page_auto_switch;

    QTimer* change_tab_timer;
    QFrame* current_frame;      // Selected Window
    QFrame* last_frame;         // Last window selected

    QLabel* lbl_step_count;     // Shows step count value
    QLabel* lbl_coil1_load;     // Shows coil1 load selected
    QLabel* lbl_coil2_load;     // Shows coil2 load selected
    QLabel* lbl_tempt[2];       // Shows both temperatures
    QLabel* lbl_sts_load;       // Shows LLD load selected
    QLabel* lbl_release_time;   // Shows release time configures
    QLabel* lbl_sts_sim;        // Shows simulation mode status
    QLabel* lbl_lld_curr;       // Shows LLD current
    QLabel* lbl_lld_ts;         // Shows LLD pulse timestamp

    // Definition of previous values to updates
    int prev_status_tc_conn_count;
    int prev_status_tm_conn_count;
    int prev_rsa = -1;
    QDateTime prev_status_dt;

    void init_ui_vars();                    // Initialize all variables
    void do_log(QString st, int level);     // Configures current time

    void select_frame(QFrame*);         //Select each window

    //Definition of the previous value of both interfaces
    T_csm_sim_regs prev_regs_csm_sim;
    T_lld_load_regs prev_regs_lld;

public slots:
    void log(QString);          // Signal & slot: Logs of all TCs and TMs
    void alarm(QString);        // Signal & slot: Alarm of all TCs and TMs
    void warning(QString);      // Signal & slot Warning of all TCs and TMs


private slots:
    void show_status();             // Main function, is called each processor cicle
    void show_frame_motor_loads();  // Displays all funcionalities related to CSM interface
    void show_frame_lld_loads();    // Displays all funcionalities related to LLD interface


    void on_btn_motor_clicked();    // Botton of CSM interface window
    void on_btn_lld_sim_clicked();  // Botton of LLD window
    void on_btn_info_ok_clicked();  // Botton of HV Sistemas info window
    void on_btn_logo_clicked();     // Botton to return
};

#endif // MAINWINDOW_H
