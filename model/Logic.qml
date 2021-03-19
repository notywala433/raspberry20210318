import QtQuick 2.0

Item {

    

    signal retrieve()

    signal setCabinetPassword(var Cabinet,var password)

    signal openCabinet(int Cabinet)

    signal openCabinetWithPswd(int Cabinet, var password)

    signal wrongPassword()

    signal deposit()

    signal noCabinetAvailable()

    signal availableCabinet(var a)

    signal allCabinetsEmpty()
    }
