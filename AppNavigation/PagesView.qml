import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QQC14
import QtQuick.Layouts 1.1

ApplicationWindow{
    property string initialPage: ""

    onInitialPageChanged: showPage(initialPage, {})


    function back(){
        if(stackView.depth >= 1)
            stackView.pop()
        else
            Qt.quit()
    }

    function gotoMainPage(){
        while(stackView.depth > 1)
            stackView.pop();
    }

    function showPage(page){
        showPageWithArgs(page, {})
    }

    function showPageWithArgs(page, properties){
        page += ".qml";

        var component = Qt.createComponent(Qt.resolvedUrl(page));
        var i;

        var loadObject = function(){
            if (component.status === Component.Ready) {

                var item = component.createObject();

                stackView.push({
                                   item: item,
                                   properties: properties,
                                   destroyOnPop: true
                               });

                if(item.openPage !== undefined)
                    item.openPage.connect(showPage);
                if(item.openPageWithArgs !== undefined)
                    item.openPageWithArgs.connect(showPageWithArgs)

                if(item.back !== undefined)
                    item.back.connect(back);
            } else if (component.status === Component.Error) {
                console.log("Error loading item:", component.errorString());
            }
        }

        if (component.status === Component.Ready)
            loadObject();
        else if(component.status === Component.Error)
            console.log("Error loading component:", component.errorString());
        else
            component.statusChanged.connect(loadObject);
    }

    header: ToolBar{
        height: 40
            ToolButton {
                id: backButton
//                text: "back"
                opacity: stackView.depth > 1 ? 1 : 0
                onClicked: back()

                Image {
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    anchors.fill: parent
                    source: "back.png"
                }
                Behavior on opacity { NumberAnimation{} }
            }
            Text {
                id: name
                text: stackView.currentItem == null ? "" : stackView.currentItem.title
                font.bold: true
                x: (backButton.x + backButton.width) * backButton.opacity + 5

                anchors.verticalCenter: parent.verticalCenter
            }
    }


    QQC14.StackView{
        id: stackView
        anchors.fill: parent

        Keys.onBackPressed: {
            back()
            return false;
        }

        Keys.onPressed: {
            if(event.key === Qt.Key_Backspace)
                back()
        }
    }
}
