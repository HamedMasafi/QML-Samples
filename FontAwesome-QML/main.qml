import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: applicationWindow1
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    Rectangle{
        anchors.fill: parent
        color: "#afafaf"
    }


    Rectangle{
        id: rectangle1
        height: 120
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        Layout.fillWidth: true

        RowLayout{
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.verticalCenter: parent.verticalCenter

            IconButton{
                text: fa_bars
                height: 60
                width: 60
            }
            IconButton{
                text: fa_search
                height: 60
                width: 60
            }
            IconButton{
                text: fa_area_chart
                height: 60
                width: 60
            }
        }
    }


    GridLayout{
        anchors.topMargin: 120
        anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        columns: 3
        layoutDirection: Qt.RightToLeft

        CircleButton{
            text: "اخبار"
            Layout.alignment: Qt.AlignHCenter
            icon: fa_newspaper_o
        }

        CircleButton{
            text: "نقشه"
            Layout.alignment: Qt.AlignHCenter
            icon: fa_map_marker
        }

        CircleButton{
            text: "راهنما"
            Layout.alignment: Qt.AlignHCenter
            icon: fa_info_circle
        }

        CircleButton{
            text: "تصاویر"
            Layout.alignment: Qt.AlignHCenter
            icon: fa_file_image_o
        }

        CircleButton{
            text: "درباره"
            Layout.alignment: Qt.AlignHCenter
            icon: fa_info
        }

        CircleButton{
            text: "به روز رسانی"
            Layout.alignment: Qt.AlignHCenter
            icon: fa_cloud_upload
        }

        CircleButton{
            text: "تنظیمات"
            Layout.alignment: Qt.AlignHCenter
            icon: fa_gears
        }
    }
}
