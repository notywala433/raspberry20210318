#ifndef MYTCPSERVER_H
#define MYTCPSERVER_H

#include <QObject>
#include<QTcpServer>
#include<QTcpSocket>
#include<QSerialPort>

class MyTcpServer : public QObject
{
    Q_OBJECT
public:
    explicit MyTcpServer(QObject *parent = nullptr);

signals:

public slots:
    void newConnection();
    void setSerialport(QSerialPort *a);
private:
    QTcpServer *server;
    QSerialPort *port;
};

#endif // MYTCPSERVER_H
