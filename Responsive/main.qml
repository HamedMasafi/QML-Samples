import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    GridLayout {
        anchors.fill: parent
        flow:  width > 400 ? GridLayout.LeftToRight : GridLayout.TopToBottom

        Rectangle{
            border.color: "black"
            Button{
                anchors.centerIn: parent
                text: qsTr('Button 1')
            }
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        Rectangle{
            border.color: "black"
            Button{
                anchors.centerIn: parent
                text: qsTr('Button 2')
            }
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
