import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    width: 480
    height: 640
    title: qsTr("Web list")

    function sendData(){
        var http = new XMLHttpRequest();

        var url = "get_data.php";
        var params = "lorem=ipsum&name=binny";

        http.open("POST", url, true);

        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        http.onreadystatechange = function() {//Call a function when the state changes.
            if(http.readyState === XMLHttpRequest.DONE) {
                alert(http.responseText);
            }
        }
        http.send(params)
    }

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
        doc.open("GET", "http://mysafeinfo.com/api/data?list=englishmonarchs&format=json");
        doc.send();
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
                    refreshData();
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

    }
}
