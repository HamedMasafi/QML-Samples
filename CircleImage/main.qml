import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    CircleImage{
        width: 200
        height: 200
        anchors.centerIn: parent
        source: 'popeye.jpg'
        fillMode: Image.PreserveAspectCrop
    }

}
