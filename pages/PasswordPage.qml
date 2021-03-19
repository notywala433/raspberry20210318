import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0

Page {
    property var emptyCabinet

    property var deposit

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

        ToolButton{

        id:toolButton

        text: "<Back"

        font.pixelSize: 24

        onClicked: stackView.pop()

        anchors.right: parent.right

        anchors.verticalCenter: parent.verticalCenter

        }

    }




    Column{

    spacing: 10

    anchors.margins: 15

    anchors.left: parent.left

    anchors.right: parent.right

    anchors.top: parent.top

    anchors.centerIn: parent

    width: parent.width


    Text {
        id: name2

        text: deposit? "Please use cabinet:"+ emptyCabinet:"Please retrive your luggage from cabinet: "+emptyCabinet

        font.pixelSize: 12

        font.bold: true

        anchors.horizontalCenter: parent.horizontalCenter

    }

    Text {
        id: name1

        text: deposit ? "Please set your password for retrieval": "Please Enter your Password"

        font.pixelSize: 12

        font.bold: true

        anchors.horizontalCenter: parent.horizontalCenter


    }
    TextField{

        id:inputField

        text: ""

        width: parent.width/2

        anchors.horizontalCenter: parent.horizontalCenter

        validator:IntValidator{

            bottom: 0

            top:9
    }

    echoMode: TextInput.Password

    maximumLength: 4

    }


    Grid{


    anchors.margins: 10

    width: parent.width/2

    columns: 3

    spacing: 3

        anchors.horizontalCenter: parent.horizontalCenter

   Button{

   text: "1"

   width: 130

   background: Rectangle{color:model.themeColor}

   onClicked:{

    inputField.text = inputField.text+this.text

   }

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   }
   Button{

   text: "2"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }

   Button{

   text: "3"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }
   Button{

   text: "4"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }
   Button{

   text: "5"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }
   Button{

   text: "6"

   width:130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   }

   Button{
   text: "7"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }

   Button{

   text: "8"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }
   Button{

   text: "9"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }
   Button{

   text: "<-"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked: inputField.remove(0,4)

   }

   Button{

   text: "0"

   width: 130

   background: Rectangle{color:model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked:{

    inputField.text = inputField.text+this.text

   }
   }
   Button{

   text: "X"

   width: 130

   background: Rectangle{color : model.themeColor}

   onPressed: this.background.color = "white"

   onReleased:this.background.color= model.themeColor

   onClicked: inputField.remove(0,4)

   }





    }

    Button {

        id: buttonSubmit

        width: parent.width/2

        height: 46

        anchors.horizontalCenter: parent.horizontalCenter

        background: Rectangle{id: bgcolor2

        color: model.themeColor}

        text: "Submit"

        onClicked: {if(deposit){
                if(inputField.text === "" || inputField.text.length < inputField.maximumLength)
                {popup.text = "Password cannot be shorter than 3 characters or Empty "
                popup.open()}
                else
               { model.setCabinetPasswd(emptyCabinet,inputField.text)

                        inputField.text=""}}

            else

            {
                if(inputField.text === "" || inputField.text.length < inputField.maximumLength)
                {popup.text = "Password cannot be shorter than 3 characters or Empty "
                popup.open()}
                else{
                model.openCabinet(emptyCabinet,inputField.text) }}

                        }
        onPressed: this.background.color = "white"

        onReleased:this.background.color= model.themeColor

    } }

    Connections{
    target: model
    onTimeUpdate:name.text = a
    onFailedAuth: {popup.text = "Wrong Password"
                    popup.open()

    }


    }
    Popup{

        property alias text:popUpMessage.text

        id:popup

        Component.onCompleted: {

         timer.running = true

         timer.start()

    }

    onOpened: timer.start()

    onClosed: {timer.stop()
    inputField.text = ""}

    Timer{

        id:timer

        interval: 4000

        running: false

        onTriggered: popup.close()



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

    onClicked: popup.close()

    }

    }

}
