#include "mainwindow.h"
#include <QApplication>


class MyApp : public QApplication
{
    public:
        MyApp(int& argc, char **argv) :
        QApplication(argc, argv) {
            installEventFilter(this);
        }

private:

    /*!
    Intercept events at the topmost level.
    @param o The object watched (in this case, it is MyApp and can be ignored.
    @param e The event.
    @return true to consume the event.
    */
    /*bool eventFilter(QObject *o, QEvent *e) {

        static QTime t;
        static bool isBounced = false;
        int msec;

        if ((e->type() == QEvent::Timer) || (e->type() == QEvent::LayoutRequest) || (e->type() == QEvent::UpdateRequest) || (e->type() == 12))
             return QApplication::eventFilter(o, e);


        printf("event filter %d\n", e->type());


        switch(e->type())
        {
            case QEvent::MouseButtonPress:
            case QEvent::MouseButtonDblClick:
                msec = t.elapsed();
                isBounced = (msec < 300); // Experiment with this number
                if (isBounced)
                    return true;
                break;
            case QEvent::MouseButtonRelease:
                t.restart();
                if (isBounced)
                    return true;
                break;
            default:
                break;
        }
        // Let Qt handle events that were not consumed here.
        return QApplication::eventFilter(o, e);
    }*/

};


/*int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}*/

int main(int argc, char **argv)
{
    MyApp a(argc, argv);
    MainWindow w;
    w.show();

    // your code
    return a.exec();

}
