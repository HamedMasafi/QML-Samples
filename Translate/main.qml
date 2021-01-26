import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Hamed 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480

    /*
        برای اینکه ترجمه در هنگام اعمال نشون داده بشه از یک پراپرتی سوری استفاده شده
        در هر متنی که قراره ترجمه بشه این پراپرتی باید بهش اضافه بشه تا هر موقعی که
        عوض شد اون متن دوباره درخواست بشه. مقدار این پراپرتی خالیه و اضافه کردن به
        یک متن دیگه اون متن رو تغییر نمیده
        LanguageTranslator.p
    */
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
