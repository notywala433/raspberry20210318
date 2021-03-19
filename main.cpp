#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<relay.h>
#include <QDebug>
#include<QStringList>
#include<QFileDevice>
#include<QFile>
#include<QProcess>
#include<QThread>
#include<QByteArray>
#include<QIODevice>
#include<QObject>
#include<QFileSystemWatcher>
#include<QDir>
#include<QFileInfoList>
#include<wiringPi.h>
#include<QQmlContext>
#include<QDebug>
#include"mytcpserver.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    MyTcpServer server;

   

    Relay relay;
server.setSerialport(relay.getSerialport());






        qDebug()<<digitalRead(5);
qDebug()<<relay.availablePorts().join(",");


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.rootContext()->setContextProperty("controller",&relay);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

