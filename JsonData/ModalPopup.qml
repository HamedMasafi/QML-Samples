import QtQuick 2.0

Item {
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
