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

 //Open All Channels

 Q_INVOKABLE    void openAllChannels();

 //Open an individual Channel

 Q_INVOKABLE    void openChannel(int a);

 //List All available ports

 Q_INVOKABLE    QStringList availablePorts();

 //Set port to be used to speak to the relay board

 Q_INVOKABLE    void setPort(QString a);

 //Charge All devices on cabinets(Cellphone charging cabinets)

 Q_INVOKABLE    void chargeAllOn();

 //Charge a specific cabinet

 Q_INVOKABLE    void chargeCabinetOn(int a);

 //Switch off Charging on a cabinet

 Q_INVOKABLE    void chargeCabinetOff(int a);

 //Switch off charging on all

 Q_INVOKABLE    void chargeAllOff();

 //Get machines local ip

 Q_INVOKABLE    QString getLocalip();

 //

 void (consoleprint)(void);
    QSerialPort* getSerialport();

signals:

public slots:

 //Get incoming data from the serial port

 void printSerialData(QByteArray a);

private:

    QSerialPort *port;
    QSerialPortInfo *info;
    Channel channel[25];
    QByteArray *openHex;
    QStringList hexValues;
};

#endif // RELAY_H
