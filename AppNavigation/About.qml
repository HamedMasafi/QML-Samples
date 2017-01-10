import QtQuick 2.0
import QtQuick.Controls 2.0

PageBase {
    id: item1

    title: "Page 2"
    Text {
        id: label
        text: '
<html>
    <body  dir="rtl">
    <a href="https://github.com/HamedMasafi/QML-Samples/">مثالهای qml</a>
    <br />
    <a href="https://telegram.me/joinchat/BY6MdD8zELnu-u4vy6mxvg">گروه برنامه نویسان فارسی کیوت</a>
    <br />
    <a href="https://iostream.ir/">مرجع برنامه نویسان ++C</a>
    </body>
    </html>'
        horizontalAlignment: Text.AlignRight
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        onLinkActivated: Qt.openUrlExternally(link);

    }
    Button {
        text: qsTr("Back")
        anchors.horizontalCenter: parent.horizontalCenter
        y: label.y + label.height + 10

        onClicked: back()
    }
}
