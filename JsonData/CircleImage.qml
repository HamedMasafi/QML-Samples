import QtQuick 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2

Item {
    id: item

    property alias source: image.source
    property alias fillMode: image.fillMode

    Rectangle {
        id: circleMask
        anchors.fill: parent

        smooth: true
        visible: false

        radius: Math.max(width/2, height/2)
    }

    Image {
        id: image
        visible: false
    }

    OpacityMask {
        anchors.fill: parent
        maskSource: circleMask
        source: image
    }


}
