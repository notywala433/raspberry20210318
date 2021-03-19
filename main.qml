import QtQuick 2.0
import QtQuick.Controls 2.0
import "./pages/"
import "./model/"
ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Stack")


    Logic{
    id:logic
    }
    Model{

    id:model
    target: logic
    }
    StackView {
        id: stackView
        initialItem: components.homePageCmp

        anchors.fill: parent
    }

    Components{
    id:components
    }
    Connections{
    target: logic


    }
}
