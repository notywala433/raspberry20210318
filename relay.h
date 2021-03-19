#ifndef RELAY_H
#define RELAY_H
#include<QtSerialPort/QSerialPort>
#include <QObject>
#include"channel.h"
#include<QStringList>
class Relay : public QObject
{
    Q_OBJECT
public:
    explicit Relay(QObject *parent = nullptr);
   Q_INVOKABLE  void openAllChannels();
     Q_INVOKABLE  void openChannel(int a);
    Q_INVOKABLE QStringList availablePorts();
     Q_INVOKABLE  void setPort(QString a);
    Q_INVOKABLE void chargeAllOn();
    Q_INVOKABLE void chargeCabinetOn(int a);
    Q_INVOKABLE void chargeCabinetOff(int a);
    Q_INVOKABLE void chargeAllOff();
    Q_INVOKABLE QString getLocalip();

    void (consoleprint)(void);
    QSerialPort* getSerialport();
signals:

public slots:
    void printSerialData(QByteArray a);

private:
    QSerialPort *port;
    QSerialPortInfo *info;
    Channel channel[25];
    QByteArray *openHex;
    QStringList hexValues;
};

#endif // RELAY_H
