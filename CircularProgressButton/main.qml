import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: window1
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ProgressButton{
        id: btn
        anchors.centerIn: parent
        font.pixelSize: 30
    }

    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        Button{
            id: btnSuccess
            text: "Start success"
            onClicked: {
                btn.success = true
                anim.start()
            }
        }
        Button{
            id: btnError
            text: "Start error"
            onClicked: {
                btn.success = false
                anim.start()
            }
        }
    }

    SequentialAnimation{
        id: anim
        ScriptAction{
            script: {
                btnSuccess.enabled = btnError.enabled = false
            }

        }

        NumberAnimation{
            duration: 3000
            target: btn
            property: 'value'
            from: 0
            to: 100
        }


        PauseAnimation {
            duration: 2000
        }

        ScriptAction{
            script: {
                btn.reset();
                btnSuccess.enabled = btnError.enabled = true
            }
        }
    }
}
