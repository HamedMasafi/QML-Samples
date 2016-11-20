import QtQuick 2.0

Rectangle{
    id: button
    radius: size / 2
    color: "transparent"
    border.color: Qt.rgba(230, 230, 230, 50)
    height: size
    width: size
    clip: true

    property int size: 100
    property alias backgroundColor: background.color
    property alias backgroundOpacity: background.opacity
    property string hoverColor: Qt.rgba(230, 230, 250, 50)
    property string hoverBorderColor: Qt.rgba(70, 70, 100, 50)
    property string pressedColor: 'gray'
    property string pressedBorderColor: ''
    property string text: 'Button'
    property string icon: ''
    property bool isAwesome: false
    signal clicked()

    Rectangle{
        id: background
        radius: size / 2
        anchors.fill: parent
        border.color: Qt.rgba(230, 230, 230, 50)
        color: Qt.rgba(250, 250, 250, 50)
        opacity: .4
    }

    Item{
        id: item1
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        height: size / 2

        Text {
            id: name
            text: button.icon
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "FontAwesome"
            font.pointSize: 16
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
//        Rectangle{
//            width: 20
//            height: 20
//            color: "#000000"
//            border.color: "#129b5e"
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//        }
    }
    Item{
        id: item2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        x: size / 2
        height: size / 2

        Text {
            font.family: "B Traffic"
            text: button.text
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
        }
    }

    states: [
        State {
            name: "hover"
            when: mouser.isInCircle() && mouser.containsMouse && !mouser.pressed
            PropertyChanges {
                target: background
                color: hoverColor
                border.color: hoverBorderColor
            }
        },
        State {
            name: "active"
            when: mouser.isInCircle() && mouser.pressed
            PropertyChanges {
                target: background
                color: pressedColor
                border.color: pressedBorderColor
            }
        }
    ]
    MouseArea{
        id: mouser

        anchors.fill: parent
        hoverEnabled: true

        onClicked: if(isInCircle()) button.clicked()
        function isInCircle(){
            return Math.sqrt(Math.pow(mouseX - size/2, 2)
                         + Math.pow(mouseY - size/2, 2)) < size/2
        }

    }


}
