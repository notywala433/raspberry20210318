import QtQuick 2.0
import QtQuick.Controls 2.0

Page {
    width: 600
    height: 400
    property alias back: button
    title: qsTr("Page 1")

    Button {
        id: button
        x: 270
        y: 267
        text: qsTr("Back")
    }
}
