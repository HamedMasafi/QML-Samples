import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: applicationWindow1
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    visibility: "Maximized"
    color: '#fefefe'

    Rectangle{
        id: header
        height: 50
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        Button{
            id: buttonBack
            text: qsTr("Back")
            anchors.verticalCenter: parent.verticalCenter
            visible: stackView.depth > 1
            onClicked: stackView.pop()
        }
        Button{
            text: qsTr("Quit")
            anchors.verticalCenter: parent.verticalCenter
            onClicked: Qt.quit()
            x: buttonBack.visible ? buttonBack.x + buttonBack.width + 10 : 10
            Behavior on x { NumberAnimation{} }
        }
    }

    StackView{
        id: stackView
        anchors.fill: parent
        anchors.topMargin: header.height
        initialItem: LevelChoose{}
    }
}
