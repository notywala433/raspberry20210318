import QtQuick 2.0
import "../pages"
Item {

    property alias homePageCmp: homePage

    property alias passwordPageCmp: passwordPage

    property alias retrievePageCmp: retrievePage

    Component{
        id:homePage
        Home{}}



    Component{
        id:passwordPage
       PasswordPage{}}
    
    Component{
        id:retrievePage
        Retrieve{}}
}
