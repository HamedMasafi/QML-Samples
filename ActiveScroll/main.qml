import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: window1
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    property int headerMin: 60
    property int headerMax: 150

    ListView{
        id: listView
        visible: true
        anchors.fill: parent
        model: 50
        clip: true

        property int step: Math.min(Math.max(listView.contentItem.y, headerMin), headerMax)

        onStepChanged: console.log((step - headerMin)/100)
        headerPositioning: ListView.OverlayHeader
        header: Rectangle {
            id: header
            z:2
            width: listView.width


            AnimationController{
                progress: listView.contentItem.y / headerMax
                animation: ParallelAnimation{


                    NumberAnimation {
                        target: header
                        property: "height"
                        from: headerMin
                        to: headerMax
                    }
                    NumberAnimation {
                        target: logo
                        property: "x"
                        from: back.x + back.width + 20
                        to: back.x
                    }

                    NumberAnimation {
                        target: logo
                        property: "y"
                        from: 10
                        to: back.y + back.height + 20
                    }

                    NumberAnimation {
                        target: logo
                        property: "height"
                        from: 40
                        to: 60
                    }
                }
            }

            Rectangle{
                anchors.fill: parent
                color: '#6389a8'
            }

            Image{
                id: back
                width: height
                height: 20
                y: 20
                x: 20
                source: "qrc:/Back.png"
            }


            ColumnLayout{
                id: menu
                width: height
                height: 20
                y: 20
                anchors.rightMargin: 20
                anchors.right: parent.right

                Repeater{
                    model: 3

                    Rectangle{
                        height: 4
                        width: 4
                        radius: 2
                    }
                }
            }

            Rectangle{
                id: logo
                width: height
                radius: width / 2
            }

            Item{
                id: camera
                width: height
                height: 60
                y: parent.height - 30
                anchors.right: parent.right
                anchors.rightMargin: 35
                Rectangle{
                    id: cameraButton
                    property bool v: header.height > headerMin + 5

                    height: v ? 60 : 0
                    opacity: v ? 1 : 0

                    Behavior on opacity { NumberAnimation{} }
                    Behavior on height { NumberAnimation{} }

                    width: height
                    radius: width / 2
                    anchors.centerIn: parent
                    color: "#eee"
                    Image {
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10
                        anchors.topMargin: 10
                        anchors.fill: parent
                        source: "qrc:/Camera.png"
                    }
                }
            }

            Column{
                anchors.verticalCenter: logo.verticalCenter
                x: logo.x + logo.width + 20
                Text {
                    color: "#ffffff"
                    text: qsTr("Hamed Masafi")
                    font.bold: true
                }
                Text {
                    color: "#ffffff"
                    text: qsTr("Online")
                }
            }
        }

        delegate: Text{
            text: index
            height: 30
        }
    }
}
