#include "channel.h"
#include<QSerialPort>
#include<QDebug>
Channel::Channel(QObject *parent) : QObject(parent)
{
 occupation = new bool;
 *occupation = false;
   hex = new QByteArray();
   number = new int;
}

bool Channel::isOccupied(){

    return *occupation;


}
void Channel::setHex(QByteArray h){

   *hex = h;

}

QByteArray Channel::getHex(){
    return *hex;
}
void Channel::setNumber(int a){
    
    *number = a;
}
int Channel::getNumber(){
    return  *number;
    
}
