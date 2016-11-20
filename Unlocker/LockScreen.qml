import QtQuick 2.4
import QtQuick.Particles 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0


Item{
    id:root
    signal unlocked()

    property double pixelDensity

    Component.onCompleted:{
        pixelDensity = Screen.logicalPixelDensity
    }


    onOpacityChanged: {
        if(opacity === 1)
            controller.completeToBeginning()
    }

    ParticleSystem {
        id: particleSystem
    }

    ImageParticle {
        system: particleSystem
        source: "qrc:/Nano.png"
        alpha: 0.7
        color: "white"
        blueVariation: 0.1
        redVariation: 0.1
        greenVariation: 0.1
    }

    Emitter {
        enabled: mouseArea.pressed
        x: mouseArea.mouseX
        y: mouseArea.mouseY
        width: 10
        height: 10
        system: particleSystem
        emitRate: 300
        lifeSpan: 900
        lifeSpanVariation: 20
        startTime: lifeSpan
        size: 4
        sizeVariation: 1
        velocity: AngleDirection {
            angle: 0
            angleVariation: 360
            magnitude: 20 * pixelDensity
        }
        acceleration: AngleDirection {
            angle: 0
            angleVariation: 360
            magnitude: 3* pixelDensity
        }
    }

    Emitter {
        enabled: mouseArea.pressed
        anchors.fill: parent


        system: particleSystem
        emitRate: 80
        lifeSpan: 600
        lifeSpanVariation: 20
        startTime: lifeSpan
        size: 4
        sizeVariation: 1
        velocity: AngleDirection {
            angle: 0
            angleVariation: 360
            magnitude: 5 * pixelDensity
        }
        acceleration: AngleDirection {
            angle: 0
            angleVariation: 360
            magnitude: 30 * pixelDensity
        }
    }

    MouseArea {
        id: mouseArea
        property int beginY
        property int level: mouseArea.pressed ? (Math.min(beginY - mouseY, 400) / 4) : 0
        anchors.fill: parent
        onPressed: {
            beginY = mouseY
        }
        onReleased: {
            if(level > 1)
                unlockAnim.start()
            else if(level === 0)
                blopAnim.start()
        }
    }
    ColumnLayout{
        id: clock
        anchors.horizontalCenter: parent.horizontalCenter
        y: pixelDensity * 15
        width:900


        Text{
            color: 'white'
            text: Qt.formatDateTime(new Date(), "HH:mm")
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: pixelDensity * 10
            horizontalAlignment: Text.AlignHCenter
        }
        Text{
            color: 'white'
            text: new Date().toLocaleDateString()
            //"Tuesday, November 1<br />Wed 07:00"
             Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: pixelDensity * 2.3
        }
    }

    Item {
        id: messages

        anchors.left: parent.left
        anchors.leftMargin: pixelDensity * 20
        anchors.right: parent.right
        anchors.rightMargin: pixelDensity * 20
        y: clock.y + clock.height + 150
        Repeater{
            model: ListModel{
                ListElement{
                    title: "Telegram"
                    descript: "You have 2 new message"
                }
                ListElement{
                    title: "ADM"
                    descript: "Download ended"
                }
                ListElement{
                    title: "Messaging"
                    descript: "You have new message"
                }
            }

            delegate: Rectangle{
                width: parent.width
                height: 18 * pixelDensity
                clip: true
                y: -(controller.progress * 100) + index * (height * (1 - controller.progress) + 10)
                opacity: (1 - controller.progress)

                Text {
                    id: notifTitle
                    text: title
                    font.bold: true
                    font.pointSize: 14
                    x: 35
                    y: pixelDensity * 2
                }
                Text {
                    text: descript
                    font.pointSize: 14
                    x: 40
                    y: notifTitle.y +  notifTitle.height + pixelDensity * 2
                }
            }
        }
    }
    AnimationController{
        id: controller
        progress : mouseArea.level / 100
        animation: ParallelAnimation{
            PropertyAnimation{
                target: clock
                property: "opacity"
                from: 1
                to: 0
            }
            PropertyAnimation{
                target: clock
                property: "scale"
                from: 1
                to: .7
            }
        }

    }
    SequentialAnimation{
        id: blopAnim
        NumberAnimation {
            target: controller
            property: "progress"
            duration: 300
            from: 0
            to: .35
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: controller
            property: "progress"
            duration: 350
            from: .35
            to: 0
            easing.type: Easing.OutElastic
        }
    }
    SequentialAnimation{
        id: unlockAnim
        NumberAnimation {
            target: controller
            property: "progress"
            duration: 350
            to: 1
        }
        ScriptAction{
            script: root.unlocked()
        }
    }
}
