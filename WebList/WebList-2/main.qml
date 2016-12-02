import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    width: 480
    height: 640
    title: qsTr("Web list")

    function refreshData(){
        loadingDim.visible = true
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {


            /*
            {
                "nm": "Edmund lronside",
                "cty": "United Kingdom",
                "hse": "House of Wessex",
                "yrs": "1016"
            }

            */

            if (doc.readyState === XMLHttpRequest) {

            }

            if (doc.readyState === XMLHttpRequest.DONE) {
                settings.json = doc.responseText;
                loadingDim.visible = false
            }
        }
        doc.open("GET", "http://instagrama.ir/app-new.json");
        doc.send();
    }


    Settings {
        id: settings
        property string json: ''

        onJsonChanged: {
            listView.model = JSON.parse(json);
        }
    }
    ListView{
        id: listView
        anchors.fill: parent

        highlightFollowsCurrentItem: true
        highlightMoveDuration: 200
        clip: true
        spacing: 10
        focus: true

        highlight: Rectangle {
            color: "lightsteelblue";
            radius: 5
        }


        delegate: RowLayout{
            width: listView.width
            height: 50
            layoutDirection: Qt.RightToLeft

            Item{
                height: 50
                width: 50
                Layout.preferredWidth: 50

                Image {
                    id: thumb
                    anchors.fill: parent
                    clip: true
                    fillMode: Image.PreserveAspectFit
                    source: modelData.image[0]
                    cache: false

                }
                BusyIndicator{
                    anchors.centerIn: parent
                    visible: thumb.status === Image.Loading
                }
            }
            ColumnLayout{
                Layout.fillWidth: true
                Text{
                    text: modelData.title
                    font.bold: true
                    Layout.fillWidth: true
                    clip: true
                    wrapMode: Text.WordWrap
                }
                Text{
                    text: "نوشته شده در تاریخ " + modelData.date + " (" + modelData.view + "بازدید)"
                    Layout.fillWidth: true
                    clip: true
                    wrapMode: Text.WordWrap
                }
            }

            MouseArea{
                anchors.fill: parent
                Layout.preferredWidth: 0
                onClicked: {
                    listView.currentIndex = index
                    details.dataItem = modelData
                    details.open();
                }
            }
        }
    }



    Item{
        id: loadingDim
        visible: false
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

    Popup{
        id: details
        width: 300
        height: 400
        x: (parent.width - details.width) / 2
        y: (parent.height - details.height) / 2
        dim: true
        modal: true

        property var dataItem: null

        ColumnLayout{
            id: popupLayout
            anchors.fill: parent
            SwipeView{
                id: popupImages
                height: 200
                Layout.fillWidth: true
                clip: true
                Repeater{
                    model: details.dataItem == null ? 0 : details.dataItem.image
                    Image {
                        source: modelData
                    }
                }
            }

            PageIndicator{
                count: details.dataItem == null ? 0 : details.dataItem.image.length
                currentIndex: popupImages.currentIndex
                Layout.alignment: Qt.AlignHCenter
            }

            GridLayout{
                columns: 2
                layoutDirection: Qt.RightToLeft
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text{
                    Layout.columnSpan: 2
                    text: details.dataItem == null ? "" : details.dataItem.title
                    font.bold: true
                    horizontalAlignment: Text.AlignRight
                    Layout.fillWidth: true
                    clip: true
                    wrapMode: Text.WordWrap
                }

                Text{
                    text: "تاریخ"
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignRight
                    clip: true
                    wrapMode: Text.WordWrap
                }

                Text{
                    text: details.dataItem == null ? "" : details.dataItem.date
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignRight
                    clip: true
                    wrapMode: Text.WordWrap
                }

                Text{
                    text: "تعداد بازدید"
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignRight
                    clip: true
                    wrapMode: Text.WordWrap
                }

                Text{
                    text: details.dataItem == null ? "0" : details.dataItem.view
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignRight
                    clip: true
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    footer: RowLayout{
        spacing: 10
        Button{
            text:'Refresh'
            onClicked:{
                refreshData();
            }
        }
    }
}
