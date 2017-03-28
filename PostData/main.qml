import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import Tooska 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Post data to web page")

    Postman{
        id: postman
        onFinished: output.text = "Data post successfully\n" + data
    }

    FileDialog{
        id: fileDialog
        nameFilters: [ "Image files (*.jpeg *.jpg *.bmp *.gif *.png)", "All files (*)" ]
        onAccepted: filePath.text = fileUrl
    }

    ColumnLayout{
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent
        RowLayout{
            Layout.fillWidth: true
            Text {
                text: "File path:"
            }
            TextField{
                id: filePath
                Layout.fillWidth: true
            }
            Button{
                text: "..."
                onClicked: fileDialog.open()
            }
        }

        Button{
            text: "Send data"
            onClicked: {
                output.text = "Sending file...";
                postman.sendFile(filePath.text)
            }
        }
        TextArea{
            id: output
            readOnly: true
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
