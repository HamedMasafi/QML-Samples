import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Hamed 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World") + LanguageTranslator.p

    Text {
        id: name
        text: qsTr("This is a sample text for translate") + LanguageTranslator.p
    }
    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        Button{
            text: "English"
            onClicked: LanguageTranslator.currentLanguage = "en"
        }
        Button{
            text: "Persian"
            onClicked: LanguageTranslator.currentLanguage = "fa"
        }
    }
}
