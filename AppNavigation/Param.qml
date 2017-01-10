import QtQuick 2.0
import QtQuick.Controls 2.0

PageBase {
    id: item1

    property string p: ""

    title: "Parametere test"
    Text {
        id: label
        text: "The parametere is " + p
        font.pointSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    Button {
        text: qsTr("Back")
        anchors.horizontalCenter: parent.horizontalCenter
        y: label.y + label.height + 10

        onClicked: back()
    }
}
