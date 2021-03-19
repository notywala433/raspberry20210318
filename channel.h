#ifndef CHANNEL_H
#define CHANNEL_H

#include <QObject>
#include <QSerialPort>
class Channel : public QObject
{
    Q_OBJECT
public:
    explicit Channel(QObject *parent = nullptr);


        bool isOccupied();
        void setHex(QByteArray h);
        QByteArray getHex();
        void setNumber(int a);
        int getNumber();
signals:

public slots:
private:
        bool *opened;
        QByteArray *hex;
        int *number;
        bool *occupation;


};

#endif // CHANNEL_H
