import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0
import Tooska.qml.samples 1.0

ApplicationWindow {
    visible: true
    width: 480
    height: 640
    title: qsTr("Web list")

    WebRequest{
        id: webRequest
        onDataRecived: {
            settings.json = data;
        }
    }

    Item {
        id: rootItem
        anchors.fill: parent

        Settings {
            id: settings
            property string json: ''

            onJsonChanged: {
                listView.model = JSON.parse(json);
            }
        }

        ColumnLayout{
            anchors.fill: parent
            ListView{
                id: listView
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true
                delegate: ColumnLayout{
                    Text{
                        text: modelData.nm
                        font.bold: true
                    }
                    Text{
                        text: modelData.cty + " - " + modelData.hse + "(" + modelData.yrs + ")"
                    }
                }
            }
            Button{
                text:'Refresh'
                onClicked:{
                    webRequest.get("http://mysafeinfo.com/api/data?list=englishmonarchs&format=json")
                }
            }
        }

        Item{
            id: loadingDim
            visible: webRequest.isLoading
            anchors.fill:parent
            Rectangle{
                anchors.fill:parent
                color: 'black'
                opacity: .6
            }
            BusyIndicator{
                anchors.centerIn: parent
            }
        }

    }
}
