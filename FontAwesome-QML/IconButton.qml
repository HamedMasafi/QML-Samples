import QtQuick 2.0

Item {
    id: button
    width: dpix * .8
    height: dpiy * .6
    opacity: enabled ? 1 : .3

    property alias text: label.text
    property alias textColor: label.color
    property string color: "white"
    property string pressedColor: "#ddd"
    signal clicked()

    Rectangle{
        id: bg
        color: mouse.pressed ? button.pressedColor : button.color
        anchors.fill: parent
        border.color: 'gray'
        radius: 4
    }

    Text {
        id: label
        text: button.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        color: 'gray'
        font.pointSize: 20
        font.family: "FontAwesome"
    }
    MouseArea{
        id: mouse
        anchors.fill: parent
        onClicked: button.clicked()
    }
}

