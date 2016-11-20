import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

Item {
    id: item1
    signal locked();


    ColumnLayout{
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: name
            text: qsTr("Home screen")
            font.pointSize: 50
        }
        Button{
            text: qsTr("Lock")
            onClicked: locked()
        }
    }
}
