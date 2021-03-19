import QtQuick 2.0
import QtQuick.Controls 2.0
import "../model/"
import "../model/"

Page {
    id:root

    property alias buttonRetrieveClick: button

    property alias buttonDepositClick: button1

    property alias popup: popUpMessage


    title: qsTr("Home")
    Keys.onPressed: {


     Qt.quit()
        event.accepted = true




    }
    header: ToolBar{

                    height:60

                    background: Rectangle{color: "white"}

                    Image {
                       id:imageImg

                       anchors.verticalCenter: parent.verticalCenter

                       anchors.leftMargin: 30

                       x:30

                       width: 153

                       height: 47

                       source: model.imageUrl

                       fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: name

                        anchors.horizontalCenter: parent.horizontalCenter

                        anchors.verticalCenter: parent.verticalCenter

                     }



    }
    footer:ToolBar{
        height:60

        background: Rectangle{color: "white"}
        Text {
            id: nameIp

            anchors.horizontalCenter: parent.horizontalCenter

            anchors.verticalCenter: parent.verticalCenter
            text:controller.getLocalip()
         }
    }

    background: Rectangle {

                            color: 'white'

                            }

Row{

    anchors.centerIn: parent

    spacing: 100

    Button {
        id: button

        width: 100

        height: 46

        background: Rectangle{
                                id: bgcolor

                                color: model.themeColor}
        text: "Retrieve"

        onClicked: logic.retrieve()

        onPressed: bgcolor.color = "white"

        onReleased: bgcolor.color= model.themeColor

    }

    Button {
        id: button1

        width: 100

        height: 46

        background: Rectangle{id: bgcolor2

             color: model.themeColor}

        text: "Deposit"

        onClicked:{logic.deposit()}

        onPressed: bgcolor2.color = "white"

        onReleased: bgcolor2.color= model.themeColor

    }

}

Connections{

target: model

onTimeUpdate:name.text = a

onNoCabinet:{homePopup.text = "No cabinets are available for rental"

homePopup.open()}

onAllEmpty:{homePopup.text = "Nothing to retrieve, all cabinets are empty"

    homePopup.open()}

}

Popup{

    property alias text:popUpMessage.text

    id:homePopup

    Component.onCompleted: {

     timer.running = true

     timer.start()

}

onOpened: timer.start()

onClosed: timer.stop()

Timer{

    id:timer

    interval: 4000

    running: false

    onTriggered: homePopup.close()



}

width:300

height: 300

modal: true

x:this.width

Text {

    anchors.fill: parent

    id: popUpMessage

    wrapMode: Text.WrapAtWordBoundaryOrAnywhere

    horizontalAlignment: Text.AlignHCenter

    verticalAlignment: Text.AlignVCenter

}

Button{

text: "OK"

anchors.horizontalCenter: parent.horizontalCenter

anchors.bottom: parent.bottom

onClicked: homePopup.close()

}

}
}
