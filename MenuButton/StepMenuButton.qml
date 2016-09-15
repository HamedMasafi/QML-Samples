import QtQuick 2.0
import QtQuick.Controls 1.2

ToolButton {
    id: button
    width: (60)
    height: (60)
    //    border.color: foreColor
    //    radius: barSize / 3
    clip: true

    property int barSize: 6
    property string foreColor: 'gray'

    function release(){
        if(step !== 100)
        closeAnimation.start()
    }


    property int step: 0


    onStepChanged: {
        var s = Math.abs(step)

        s = Math.max(s, 0);
        s = Math.min(s, 100);

        if(s !== step)
            step = s;
    }
    NumberAnimation {
        id: closeAnimation
        target: button
        property: "step"
        duration: 200
        easing.type: Easing.InOutQuad
        to: 0
    }

    Item{
        id: p
        anchors.fill: parent
        anchors.rightMargin: (4)
        anchors.leftMargin: (4)
        anchors.bottomMargin: 1.5
        anchors.topMargin: 1.5

        Rectangle{
            id: bar1
            height: barSize
            color: foreColor
            radius: barSize / 3

            width: p.width
            x: 0
            y: (p.height * .2) - (barSize / 2)

            transform: Rotation {
                id: bar1Rotation
                origin.y: barSize / 2
                origin.x: 0
            }
        }
        Rectangle{
            id: bar2
            height: barSize
            color: foreColor
            radius: barSize / 3

            opacity: 1
            width: p.width
            x: 0
            y: (p.height / 2) - (barSize / 2)
        }
        Rectangle{
            id: bar3
            height: barSize
            color: foreColor
            radius: barSize / 3

            width: p.width
            x: 0
            y: (p.height * .8) - (barSize / 2)

            transform: Rotation {
                id: bar3Rotation
                origin.y: barSize / 2
                origin.x: 0
            }
        }
    }

    AnimationController{
        progress: step / 100


        animation: ParallelAnimation{
            PropertyAnimation{
                target: p
                property: 'rotation'
                from: 0
                to: 180
            }

            PropertyAnimation{
                target: bar1
                property: 'width'
                from: p.width
                to: (p.width * .4) * Math.sqrt(2)
            }
            PropertyAnimation{
                target: bar1
                property: 'y'
                from: (p.height * .2) - (barSize / 2)
                to: (p.height / 2) - (barSize / 2)
            }

            PropertyAnimation {
                target: bar1Rotation
                property: 'angle'
                from: 0
                to: -45
            }

            PropertyAnimation{
                target: bar3
                property: 'width'
                from: p.width
                to: (p.width * .4) * Math.sqrt(2)
            }
            PropertyAnimation{
                target: bar3
                property: 'y'
                from: (p.height * .8) - (barSize / 2)
                to: (p.height / 2) - (barSize / 2)
            }

            PropertyAnimation {
                target: bar3Rotation
                property: 'angle'
                from: 0
                to: 45
            }
        }
    }

}

