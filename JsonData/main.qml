import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Component.onCompleted: {
        var model = JSON.parse(JsonData)
        list.model = model
    }

    function openData(d) {
//        popup.open();
//        popupAnimation.start();
        dim.opacity = .4
        popup.scale = 1
    }

    ListView{
        id: list
        anchors.fill: parent
        delegate: RowLayout{
            Item{
                height: 84
                width: 84
                CircleImage {
                    anchors{
                        fill: parent
                        leftMargin: 5
                        topMargin: 5
                        bottomMargin: 5
                        rightMargin: 5
                    }

                    source: modelData.picture
                }
            }
            ColumnLayout{
                Layout.fillWidth: true
                Text{
                    text: modelData.name.first + ' ' + modelData.name.last
                    font.bold: true
                    Layout.fillWidth: true
                }
                Text{
                    text: modelData.greeting
                    elide: Text.ElideMiddle
                    Layout.fillWidth: true
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: openData(modelData)
            }
        }
    }

    ParallelAnimation{
        id: popupAnimation


    }
    Rectangle{
        id: dim
        anchors.fill: parent
        opacity: 0
        color: 'black'
        visible: opacity > 0
        MouseArea{
            anchors.fill: parent
            preventStealing: true
            onClicked: {
                dim.opacity = 0
                popup.scale = .4
            }
        }
        Behavior on opacity { NumberAnimation { } }
    }

    Pane{
        id: popup
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 200
        height: 300
        scale: .4
        visible: scale > .4

        Text{
            text: "Hi"
        }

        Behavior on scale { NumberAnimation { } }
    }
}
