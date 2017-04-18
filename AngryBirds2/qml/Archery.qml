import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    width: archeryImage.width
    height: archeryImage.height

    signal shoot

    property Item target

    property int archeryD: 73 - (mouseArea.pressed ? Math.min((line1.width + line2.width) / 200, .8) : 0) * 35

    Image{
        id: archeryImage
        source: "img/archery.png"
        visible: false
    }

    Image {
        id: displacement
        visible: false
        source: "img/archery-displace.png"
    }

    Displace {
        id: displace
        anchors.fill: parent
        source: archeryImage
        displacementSource: displacement
        displacement: mouseArea.pressed ? Math.min(mouseArea.power / 200, .8) : 0
    }

    Line{
        id: line1
        x: 81 - (mouseArea.power / 5)
        y: 25
        x2: targetShadow.x + (targetShadow.width / 2)
        y2: targetShadow.y + (targetShadow.height / 2)
        visible: mouseArea.pressed
    }
    Image {
        id: targetShadow
        source: target === null ? "" : target.source
        x: mouseArea.shadowX - (width / 2)
        y: mouseArea.shadowY - (height / 2)
        visible: mouseArea.pressed
    }
    Line{
        id: line2
        x: 111 - (mouseArea.power / 5)
        y: 28
        x2: targetShadow.x + (targetShadow.width / 2)
        y2: targetShadow.y + (targetShadow.height / 2)
        visible: mouseArea.pressed
    }
    MouseArea{
        id: mouseArea
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        height: root.height / 2
        preventStealing: true
        enabled: target !== null

        property point pressPoint: Qt.point(0, 0)
        property int shadowX: Math.min(Math.max(pressPoint.x - 100, mouseX), pressPoint.x + 50)
        property int shadowY: Math.min(Math.max(pressPoint.y - 50, mouseY), pressPoint.y + 50)
        property int power: Math.max(pressPoint.x - shadowX, 0)
        onPressed: {
            if(target === null)
                return

            target.visible = false
            pressPoint = Qt.point(mouse.x, mouse.y)
        }

        onReleased: {
            if(target === null)
                return

            var xx = (line1.x + line2.x ) / 2
            var yy = (line1.y + line2.y ) / 2
            var birdCenterX = targetShadow.x + (targetShadow.width / 2)
            var birdCenterY = targetShadow.y + (targetShadow.height / 2)
            var impulseX = (xx - birdCenterX) * 6
            var impulseY = (yy - birdCenterY) * 6

            var globalPos = root.mapToItem(root.parent, targetShadow.x, targetShadow.y)
            target.visible = true
            target.x = globalPos.x
            target.y = globalPos.y
            target.body.applyLinearImpulse(Qt.point(impulseX, impulseY),
                                         target.body.getWorldCenter())

            root.shoot()
        }
    }


}
