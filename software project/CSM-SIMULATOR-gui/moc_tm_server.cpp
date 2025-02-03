/****************************************************************************
** Meta object code from reading C++ file 'tm_server.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "tm_server.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'tm_server.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_TM_timer_thread_t {
    QByteArrayData data[4];
    char stringdata0[32];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_TM_timer_thread_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_TM_timer_thread_t qt_meta_stringdata_TM_timer_thread = {
    {
QT_MOC_LITERAL(0, 0, 15), // "TM_timer_thread"
QT_MOC_LITERAL(1, 16, 5), // "timed"
QT_MOC_LITERAL(2, 22, 0), // ""
QT_MOC_LITERAL(3, 23, 8) // "timed_1s"

    },
    "TM_timer_thread\0timed\0\0timed_1s"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_TM_timer_thread[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   24,    2, 0x06 /* Public */,
       3,    0,   25,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void TM_timer_thread::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<TM_timer_thread *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->timed(); break;
        case 1: _t->timed_1s(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (TM_timer_thread::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_timer_thread::timed)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (TM_timer_thread::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_timer_thread::timed_1s)) {
                *result = 1;
                return;
            }
        }
    }
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject TM_timer_thread::staticMetaObject = { {
    QMetaObject::SuperData::link<QThread::staticMetaObject>(),
    qt_meta_stringdata_TM_timer_thread.data,
    qt_meta_data_TM_timer_thread,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *TM_timer_thread::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TM_timer_thread::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_TM_timer_thread.stringdata0))
        return static_cast<void*>(this);
    return QThread::qt_metacast(_clname);
}

int TM_timer_thread::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QThread::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void TM_timer_thread::timed()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void TM_timer_thread::timed_1s()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
struct qt_meta_stringdata_TM_server_t {
    QByteArrayData data[19];
    char stringdata0[156];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_TM_server_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_TM_server_t qt_meta_stringdata_TM_server = {
    {
QT_MOC_LITERAL(0, 0, 9), // "TM_server"
QT_MOC_LITERAL(1, 10, 17), // "tm_client_forward"
QT_MOC_LITERAL(2, 28, 0), // ""
QT_MOC_LITERAL(3, 29, 2), // "tm"
QT_MOC_LITERAL(4, 32, 12), // "forward_data"
QT_MOC_LITERAL(5, 45, 4), // "data"
QT_MOC_LITERAL(6, 50, 3), // "log"
QT_MOC_LITERAL(7, 54, 2), // "st"
QT_MOC_LITERAL(8, 57, 7), // "warning"
QT_MOC_LITERAL(9, 65, 5), // "alarm"
QT_MOC_LITERAL(10, 71, 8), // "sigtimed"
QT_MOC_LITERAL(11, 80, 5), // "timed"
QT_MOC_LITERAL(12, 86, 8), // "timed_1s"
QT_MOC_LITERAL(13, 95, 10), // "tm_forward"
QT_MOC_LITERAL(14, 106, 13), // "set_tm_period"
QT_MOC_LITERAL(15, 120, 8), // "tm_error"
QT_MOC_LITERAL(16, 129, 6), // "tm_log"
QT_MOC_LITERAL(17, 136, 7), // "tm_warn"
QT_MOC_LITERAL(18, 144, 11) // "client_disc"

    },
    "TM_server\0tm_client_forward\0\0tm\0"
    "forward_data\0data\0log\0st\0warning\0alarm\0"
    "sigtimed\0timed\0timed_1s\0tm_forward\0"
    "set_tm_period\0tm_error\0tm_log\0tm_warn\0"
    "client_disc"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_TM_server[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   84,    2, 0x06 /* Public */,
       4,    1,   87,    2, 0x06 /* Public */,
       6,    1,   90,    2, 0x06 /* Public */,
       8,    1,   93,    2, 0x06 /* Public */,
       9,    1,   96,    2, 0x06 /* Public */,
      10,    0,   99,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      11,    0,  100,    2, 0x0a /* Public */,
      12,    0,  101,    2, 0x0a /* Public */,
      13,    1,  102,    2, 0x0a /* Public */,
      14,    1,  105,    2, 0x0a /* Public */,
      15,    1,  108,    2, 0x0a /* Public */,
      16,    1,  111,    2, 0x0a /* Public */,
      17,    1,  114,    2, 0x0a /* Public */,
      18,    0,  117,    2, 0x08 /* Private */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::Float,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void,

       0        // eod
};

void TM_server::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<TM_server *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->tm_client_forward((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->forward_data((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->log((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->warning((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->alarm((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->sigtimed(); break;
        case 6: _t->timed(); break;
        case 7: _t->timed_1s(); break;
        case 8: _t->tm_forward((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->set_tm_period((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 10: _t->tm_error((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 11: _t->tm_log((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: _t->tm_warn((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 13: _t->client_disc(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (TM_server::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_server::tm_client_forward)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (TM_server::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_server::forward_data)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (TM_server::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_server::log)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (TM_server::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_server::warning)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (TM_server::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_server::alarm)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (TM_server::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_server::sigtimed)) {
                *result = 5;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject TM_server::staticMetaObject = { {
    QMetaObject::SuperData::link<QTcpServer::staticMetaObject>(),
    qt_meta_stringdata_TM_server.data,
    qt_meta_data_TM_server,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *TM_server::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TM_server::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_TM_server.stringdata0))
        return static_cast<void*>(this);
    return QTcpServer::qt_metacast(_clname);
}

int TM_server::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QTcpServer::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 14)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 14;
    }
    return _id;
}

// SIGNAL 0
void TM_server::tm_client_forward(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void TM_server::forward_data(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void TM_server::log(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void TM_server::warning(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void TM_server::alarm(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void TM_server::sigtimed()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}
struct qt_meta_stringdata_TM_client_t {
    QByteArrayData data[10];
    char stringdata0[96];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_TM_client_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_TM_client_t qt_meta_stringdata_TM_client = {
    {
QT_MOC_LITERAL(0, 0, 9), // "TM_client"
QT_MOC_LITERAL(1, 10, 5), // "error"
QT_MOC_LITERAL(2, 16, 0), // ""
QT_MOC_LITERAL(3, 17, 23), // "QTcpSocket::SocketError"
QT_MOC_LITERAL(4, 41, 11), // "socketerror"
QT_MOC_LITERAL(5, 53, 5), // "timed"
QT_MOC_LITERAL(6, 59, 9), // "readyRead"
QT_MOC_LITERAL(7, 69, 12), // "disconnected"
QT_MOC_LITERAL(8, 82, 10), // "tm_forward"
QT_MOC_LITERAL(9, 93, 2) // "tm"

    },
    "TM_client\0error\0\0QTcpSocket::SocketError\0"
    "socketerror\0timed\0readyRead\0disconnected\0"
    "tm_forward\0tm"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_TM_client[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   39,    2, 0x06 /* Public */,
       5,    0,   42,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       6,    0,   43,    2, 0x0a /* Public */,
       7,    0,   44,    2, 0x0a /* Public */,
       8,    1,   45,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    9,

       0        // eod
};

void TM_client::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<TM_client *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->error((*reinterpret_cast< QTcpSocket::SocketError(*)>(_a[1]))); break;
        case 1: _t->timed(); break;
        case 2: _t->readyRead(); break;
        case 3: _t->disconnected(); break;
        case 4: _t->tm_forward((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (TM_client::*)(QTcpSocket::SocketError );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_client::error)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (TM_client::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&TM_client::timed)) {
                *result = 1;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject TM_client::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_TM_client.data,
    qt_meta_data_TM_client,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *TM_client::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TM_client::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_TM_client.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int TM_client::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void TM_client::error(QTcpSocket::SocketError _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void TM_client::timed()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
