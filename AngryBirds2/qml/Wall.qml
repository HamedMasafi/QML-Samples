import QtQuick 2.5
import Box2D 2.0

Item{
    id: root

    property bool showRect: false
    Rectangle{
        anchors.fill: parent
        visible: showRect
        color: 'red'
        opacity: .6
    }

    Body {
        target: root
        bodyType: Body.Static
        Box {
            width: root.width
            height: root.height

            density: 50;			//تراکم
            friction: 10;		//اصطکاک
            restitution: 0.2;		//بازتاب

        }
    }
}
