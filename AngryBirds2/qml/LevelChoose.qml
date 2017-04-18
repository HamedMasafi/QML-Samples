import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import Tooska 1.0

Item {


    Stack.onStatusChanged: {
        listView.model = factory.levels()
    }

    Component.onCompleted: listView.model = factory.levels()

    LevelFactory{
        id: factory
    }


    RowLayout{
        width: 400
        height: 300
        anchors.centerIn: parent
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            Layout.preferredWidth: 10
            ColumnLayout{
                anchors.centerIn: parent
                Button{
                    text: qsTr("Create new...")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: stackView.push(Qt.resolvedUrl("CreateLevel.qml"))
                }
                Text {
                    text: '
                <html>
                <body  dir="rtl">
                <a href="https://telegram.me/joinchat/BY6MdD8zELnu-u4vy6mxvg">گروه برنامه نویسان فارسی کیوت</a>
                <br />
                <a href="https://iostream.ir/">مرجع برنامه نویسان ++C</a>
                </body>
                </html>'
                    horizontalAlignment: Text.AlignHCenter
                    onLinkActivated: Qt.openUrlExternally(link);

                }
            }
        }
        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 10
            GroupBox {
                title: qsTr("Choose level")
                anchors.fill: parent
                ListView{
                    id: listView
                    anchors.fill: parent
                    clip: true

                    delegate: Text {
                        text: modelData
                        MouseArea{
                            anchors.fill: parent
                            onClicked: stackView.push(
                                           Qt.resolvedUrl("Play.qml"),
                                           {level: modelData}
                                           )
                        }
                    }
                }

            }

        }
    }
}
