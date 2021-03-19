import QtQuick 2.0
import QtQuick.Controls 2.0
import "./model/"
Page {
    id: root
    width: Screen.width
    height: Screen.height
    property alias buttonOnClick: button
    property alias buttonOffClick: button1
    signal off
    title: qsTr("Home")
    background: Rectangle {
        color: 'white'
    }
    Label {
        text: qsTr("You are on the home page.")
        anchors.centerIn: parent
    }
    Button {
        id: button
        y: 226
        text: "On"
        anchors.horizontalCenterOffset: 119
        width: 100
        height: 46
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        id: button1
        x: 0
        y: 226
        width: 100
        height: 46
        text: "Off"
        anchors.horizontalCenterOffset: -81
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image {
        id: image
        x: 45
        y: 13
        width: 153
        height: 47
        source: "http://zemtech.co.za/images/logocropped.png"
        fillMode: Image.PreserveAspectFit
    }
}
