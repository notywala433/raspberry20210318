import QtQuick 2.0
import QtQuick.Controls 2.0

Page {
    id:root
    property var bo: model.dbalias
    property var dbResult
    property alias gridModel: grid.model
    Component.onCompleted: {
    console.log("retrieve: " +dbResult.rows.item(2).Occupied)
        thami.activeFocusOnPress = true
        thami.forceActiveFocus()
    }
header:ToolBar{
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

GridView{
        id:grid
        width: 350
        height: 350
anchors.horizontalCenter: parent.horizontalCenter
cellHeight: 150
cellWidth: 150

header: Text{text: "Please click on the cabinet you want to open"

    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    horizontalAlignment: Text.AlignHCenter

    verticalAlignment: Text.AlignVCenter}


delegate: Rectangle{
        border.color: "black"
        height: 120
        width: 120
       color: (dbResult.rows.item(index).Occupied) ? "red":"green"
        Text {

            text: (dbResult.rows.item(index).Occupied ? "Occupied\n":"Vacant\n")+(index+1)
            anchors.centerIn: parent
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            horizontalAlignment: Text.AlignHCenter

            verticalAlignment: Text.AlignVCenter
        }
        MouseArea{
        anchors.fill: parent
        onClicked: stackView.push(components.passwordPageCmp,{emptyCabinet:index+1,deposit:false})
        enabled: dbResult.rows.item(index).Occupied

        }

}
TextField{
    id:thami
onAccepted:  {console.log(thami.text)
thami.remove(0,thami.text.length)
controller.openAllChannels()

}
visible: false

}
}



Connections{
target: model
onTimeUpdate:name.text = a



}

}





