import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

PageBase {
    id: item1

    title: "How to use"

    Text {
        id: label
        text: '
<html>
    <head>
    <style>
        body{
            direction:rtl;
        }
        1table{
            background-color:black;
        }
        t1d, 1th{
            background-color:white;
            width: 100%
        }
    </style>
    </head>
    <body  dir="rtl">
    برای استفاده از این مثال ابتدا فایلهای PagesView.qml و PageBase.qml را به پروژه خود کپی کنید.
در مرحله بعد تمام صفحات شما باید از نوع PageBase استفاده کنند.
سپس کافیست از متدهای زیر برای تسهیل امور استفاده کنید
<br />
<table border="1" cellspacing="1" width="100%">
    <tr>
        <th>کاربرد</th>
        <th>نام</th>
    </tr>

    <tr>
        <td>گشودن یه صفحه جدید</td>
        <td>showPage</td>
    </tr>

    <tr>
        <td>گشودن یه صفحه جدید همراه با ارسال پارامتر</td>
        <td>showPageWithArgs</td>
    </tr>

    <tr>
        <td>بستن صفحه جاری</td>
        <td>back</td>
    </tr>

</table>
    </body>
    </html>
'
        textFormat: Text.RichText
        horizontalAlignment: Text.AlignRight
        wrapMode: Text.WordWrap
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }
    RowLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        y: label.y + label.height + 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        Button {
            text: qsTr("Open page with parametere")

            onClicked: openPageWithArgs("Param", {p: "test"})
        }
        Button {
            text: qsTr("Back")

            onClicked: back()
        }
    }
}
