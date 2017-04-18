import QtQuick 2.7
//import QtQuick.Controls 2.0
import QtQuick.Controls 1.4// as QQC14
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import Box2D 2.0
import Tooska 1.0
import "data.js" as Data

Item {

    QtObject{
        id: __serializer
        property var objects: []
        function serialize(){
            var o = []
            var i
            for(i = 0; i < objects.length; i++)
                o.push({
                           "object": objects[i].data,
                           "x": objects[i].obj.x,
                           "y": objects[i].obj.y,
                           "rotation": objects[i].obj.rotation
                       })

//            jsonTextS.text = JSON.stringify(o)
            return JSON.stringify(o)
        }
    }

    World{
        id: world
    }

    MessageDialog {
         id: messageDialogSaved
         title: qsTr("Saved!")
         text: qsTr("Your level saved successfully.")
         onAccepted: {
             stackView.pop()
         }
     }
    ColumnLayout{
        id: toolbox
        width: 200
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        LevelFactory{
            id: levelFactory
        }

        TextField{
            id: levelName
            placeholderText: "Name"
            Layout.fillWidth: true
        }

        Button{
            text: "Save"
            Layout.alignment: Qt.AlignRight
            onClicked: {
                var data = __serializer.serialize()
                levelFactory.addLevel(levelName.text, data)
                messageDialogSaved.open()
            }
        }

        Text {
            text: qsTr("Toolbox")
        }
        ListView{
            Layout.fillWidth: true
            Layout.fillHeight: true

            model: Data.objects
            delegate: Image {
                id: rect
                source: "img/" + modelData.source
                property point beginDrag
                property var file: modelData
                property var objectData: modelData
                Drag.active: dragArea.drag.active
                Drag.hotSpot.x: 10
                Drag.hotSpot.y: 10
                Drag.keys: ['object']
                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    drag.target: parent

                    onPressed: {
                        beginDrag = Qt.point(rect.x, rect.y);
                    }
                    onReleased: {
                        backAnimX.from = rect.x;
                        backAnimX.to = beginDrag.x;
                        backAnimY.from = rect.y;
                        backAnimY.to = beginDrag.y;
                        backAnim.start()
                    }
                    drag.onActiveChanged: {
                        rect.Drag.drop();
                    }
                }
                ParallelAnimation {
                    id: backAnim
                    SpringAnimation { id: backAnimX; target: rect; property: "x"; duration: 500; spring: 2; damping: 0.2 }
                    SpringAnimation { id: backAnimY; target: rect; property: "y"; duration: 500; spring: 2; damping: 0.2 }
                }
            }
        }
    }

    Item {
        id: worldItem
        anchors.leftMargin: toolbox.width
        anchors.fill: parent
        Image {
            id: bg
            source: "img/bg.png"
        }

        DropArea {
            anchors.fill: parent
            keys: ['object']
            onDropped: {
                var objectData = Data.getTexture(drop.source.objectData.texture)
                if(objectData === null)
                    return;

                var qmlPage = ''
                if(drop.source.objectData.shape === "rectangle")
                    qmlPage = Qt.resolvedUrl("BoxEntity.qml");

                if(drop.source.objectData.shape === "circle")
                    qmlPage = Qt.resolvedUrl("CircleEntity.qml");

                if(qmlPage === '')
                    return;

                var component = Qt.createComponent(qmlPage)



                var object = component.createObject(worldItem,
                                                    {
                                                        "source": drop.source.source,
                                                        "x": dropShadow.x,
                                                        "y": dropShadow.y,
                                                        "density": objectData.density,
                                                        "friction": objectData.friction,
                                                        "restitution": objectData.restitution,
                                                        "damage": 999999
                                                    });

                __serializer.objects.push({
                                              "data": drop.source.objectData,
                                              "obj": object
                                          })

                object.selected = Qt.binding(function(){
                    return object === itemEditor.target
                })
                object.onClicked.connect(function(){
                    itemEditor.target = object
                })
            }

            Image {
                id: dropShadow
                x:parent.drag.x
                y: parent.drag.y
                source: parent.containsDrag ? parent.drag.source.source : ''
                visible: parent.containsDrag
            }
        }
        Wall{
            id: ground
            width: 2000
            height: 20
            y: 585
            showRect: true

        }
        ItemEditor{
            id: itemEditor
        }
    }

//    Rectangle{
//        anchors.fill: parent
//        visible: jsonTextS.text !== ''
//        Text {
//            id: jsonTextS
//            text: ""
//        }
//    }
}
