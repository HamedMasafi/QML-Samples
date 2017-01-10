import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

PageBase {
    id: item1

    title: "Main page"

    Text {
        id: label
        text: qsTr("App navigation demo")
        font.pointSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        y: label.y + label.height + 10
        Button {
            text: qsTr("How to use")

            onClicked: openPage("Usage")
        }
        Button {
            text: qsTr("About")

            onClicked: openPage("About")
        }
    }
}
