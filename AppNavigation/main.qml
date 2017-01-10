import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

PagesView{
    //ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    id: view
//    anchors.fill: parent

    initialPage: "Page1"
}
//}
