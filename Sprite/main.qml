import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    color: "#ebeff1"
    title: qsTr("Hello World")

    Frame{
        anchors.centerIn: parent
        background: Rectangle{
            Layout.margins: -10
            border.color: Qt.darker("#fbfcff")
            anchors.fill: parent
            radius: 5
            color: "white"
        }

        ColumnLayout{
            Item{
                height: 96
                width: 96
                Layout.alignment: Qt.AlignHCenter

                SpriteSequence{
                    id: sprite
                    running: true
                    height: 96
                    width: 96
                    visible: !username.focus
                    Sprite{
                        name: "idle"
                        frameCount: 4
                        frameWidth: 96
                        frameHeight: 96
                        frameRate: 20
                        source: "qrc:/out.jpg"
                        to: {"watching": 0, "hiding-eyes": 0}
                    }

                    Sprite{
                        name: "watching"
                        frameCount: 37 // 41 - 5 + 1
                        frameX: 4 * 96
                        frameWidth: 96
                        frameHeight: 96
                        frameRate: 20
                        source: "qrc:/out.jpg"
                        to: {"idle": 1}
                    }
                    Sprite{
                        name: "hiding-eyes"
                        frameCount: 3
                        frameX: 41 * 96
                        frameWidth: 96
                        frameHeight: 96
                        duration: 300
                        source: "qrc:/out.jpg"
                        to: {"hidden-eyes": 1}
                    }
                    Sprite{
                        name: "hidden-eyes"
                        frameCount: 1
                        frameX: 44 * 96
                        frameWidth: 96
                        frameHeight: 96
                        frameRate: 20
                        source: "qrc:/out.jpg"
                        to: {"idle": 0}
                    }
                }

                AnimatedSprite{
                    id: anim
                    visible: !sprite.visible
                    height: 96
                    width: 96
                    frameCount: 35 // 41 - 5 + 1
                    frameX: 6 * 96
                    frameWidth: 96
                    frameHeight: 96
                    frameRate: 20
                    source: "qrc:/out.jpg"
                    loops: 1
                }
            }

            TextField{
                id: username
                placeholderText: "info@sample.com"
                onTextChanged: anim.currentFrame = Math.min(33,
                                                            username.text.length * 1.5)

            }
            TextField{
                id: password
                echoMode: TextField.Password
                onFocusChanged: {
                    if(password.focus)
                        sprite.jumpTo("hiding-eyes")
                    else
                        sprite.jumpTo("idle")
                }
            }

            Button{
                id: buttonlogin
                text: "Login"

                Layout.fillWidth: true

                contentItem: Label{
                    text: "Hello"
                    font.bold: true
                    color: "white"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle{
                    color: buttonlogin.pressed
                               ? Qt.darker("#45b6d4")
                               : "#45b6d4"
                    radius: 4
                }
            }
        }
    }
}
