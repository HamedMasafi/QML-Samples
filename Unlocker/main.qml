import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow{
    id: window1
    visible: true
    width: 480
    height: 640
    title: qsTr("Hello World")

    style: ApplicationWindowStyle{
        background: Rectangle{
            anchors.fill: parent
            color: "#aac2ea"
        }
    }


    Item{
        id: win
        anchors.fill: parent

        LockScreen{
            id: lock
            anchors.fill: parent
            visible: opacity != 0

            onUnlocked: {
                //showHomeAnim.start()
                win.state = "home"
            }
        }

        Home{
            id: home
            anchors.fill: parent
            visible: opacity != 0

            onLocked:{
                //                lock.opacity = 1
                //                home.visible = false
                //                lock.visible = true
                //                home.opacity = 1
                win.state = "locked"
            }
        }
        state: "locked"
        states: [
            State {
                name: "locked"
                PropertyChanges {
                    target: lock
                    opacity: 1
                }
                PropertyChanges {
                    target: home
                    opacity: 0
                }
            },
            State {
                name: "home"
                PropertyChanges {
                    target: lock
                    opacity: 0
                }
                PropertyChanges {
                    target: home
                    opacity: 1
                }
            }
        ]

        transitions: [Transition{
                from: "locked"
                to: "home"
                animations: SequentialAnimation{
                    PropertyAnimation{
                        target: lock
                        property: 'opacity'
                        from: 1
                        to: 0
                        duration: 30
                    }

                    ParallelAnimation{
                        PropertyAnimation{
                            target: home
                            property: 'opacity'
                            from: 0
                            to: 1
                        }
                        PropertyAnimation{
                            target: home
                            property: 'scale'
                            from: .6
                            to: 1
                        }
                    }
                }
            },
            Transition {
                from: "home"
                to: "locked"
                animations: ParallelAnimation{
                    PropertyAnimation{
                        target: home
                        property: 'opacity'
                        from: 1
                        to: 0
                        duration: 200
                    }
                    PropertyAnimation{
                        target: lock
                        property: 'opacity'
                        from: 0
                        to: 1
                        duration: 400
                    }
                }
            }]
    }

}
