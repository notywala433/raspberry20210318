#include "mytcpserver.h"

MyTcpServer::MyTcpServer(QObject *parent) : QObject(parent)
{
server = new QTcpServer(this);

connect(server,SIGNAL(newConnection()),this,SLOT(newConnection()));

if(!server->listen(QHostAddress::Any,9999))
{
    qDebug()<<"Server could not not start ";
}
else
{
    qDebug()<<"Server started";
}

}

void MyTcpServer::newConnection()
{
    QTcpSocket *socket = server->nextPendingConnection();
    socket->waitForReadyRead(3000);
    QByteArray *array = new QByteArray();
    *array = socket->readAll();
    port->write(*array);
    qDebug()<<socket->localAddress().toString();
    socket->close();

}

void MyTcpServer::setSerialport(QSerialPort *a)
{
    port = a;
}

