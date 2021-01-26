import QtQuick 2.7
//import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0
import Box2D 2.0
import Tooska 1.0
import "data.js" as Data

Item{
    property string level



    LevelFactory{
        id: factory
    }

    onLevelChanged: {
        var levelData = factory.openLevel(level)
        var x = 900;
        var y = ground.y;
        __loadJson(x, y, levelData)
    }

    function __loadJson(x, y, jsonText){
        var json = JSON.parse(jsonText)
        var i
        for(i = 0; i < json.length; i++){
            var objectData = Data.getTexture(json[i].object.texture)
            if(objectData === null){
                console.log("Texture " + json[i].object.texture + " not found")
                return;
            }

            var qmlPage = ''
            if(json[i].object.shape === "rectangle")
                qmlPage = Qt.resolvedUrl("BoxEntity.qml");

            if(json[i].object.shape === "circle")
                qmlPage = Qt.resolvedUrl("CircleEntity.qml");

            if(qmlPage === ''){
                console.log("Shape is not valid")
                return;
            }

            var rotation = 0;
            if(json[i].rotation !== undefined)
                rotation = json[i].rotation;

            var component = Qt.createComponent(qmlPage)
            var object = component.createObject(worldItem,
                                                {
                                                    "source": "img/" + json[i].object.source,
                                                    "x": x + json[i].x,
                                                    "y": json[i].y,
                                                    "density": objectData.density,
                                                    "friction": objectData.friction,
                                                    "restitution": objectData.restitution,
                                                    "damage": json[i].object.damage,
                                                    "rotation": rotation,
                                                    "particleSource": objectData.particleSource
                                                });
        }
    }

    World{
        id: world
        //        gravity: Qt.point(0, 1)
    }

    Flickable{
        property bool isInViewMove : false
        id: view
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        anchors.fill: parent
        contentWidth: worldItem.width
        contentHeight: worldItem.height
        clip: true
        contentY: 500
        boundsBehavior: Flickable.StopAtBounds

        Behavior on contentX { NumberAnimation { duration: 500 } }
        Behavior on contentY { NumberAnimation { duration: 1000 } }

        onFlickStarted: {
            isInViewMove = true
        }
        onMovementStarted: {
            isInViewMove = true
        }

        function makeSureBirdIsVisible(){
            if(view.isInViewMove)
                return;

            var b = worldItem.activeBird
            if(b === null)
                return;
            var x = b.x;
            var y = b.y;

            var contentCenterX = Math.abs(x - worldItem.width / 2);
            var contentCenterY = Math.abs(y - worldItem.height / 2);

            if(contentCenterX > worldItem.width - view.width)
                contentCenterX = worldItem.width - view.width;
            if(contentCenterY > worldItem.height - view.height)
                contentCenterY = worldItem.height - view.height;

            if(Math.abs(contentCenterX - view.contentX) > 20
                    || Math.abs(contentCenterY - view.contentY) > 20 ){
                view.contentX = contentCenterX;
                view.contentY = contentCenterY;
            }
        }
        Item {
            id: worldItem
            height: bg.height
            width: bg.width

            property int activeBirdIndex: 0
            property Item activeBird: bird
            Image {
                id: bg
                source: "img/bg.png"
            }

            Bird{
                id: bird
                y: ground.y - height
                x: bird2.x + bird2.width + 5
                onXChanged: view.makeSureBirdIsVisible()
                onYChanged: view.makeSureBirdIsVisible()
            }

            Bird{
                id: bird2
                x: bird3.x + bird3.width + 5
                y: ground.y - height
                onXChanged: view.makeSureBirdIsVisible()
                onYChanged: view.makeSureBirdIsVisible()
            }

            Bird{
                id: bird3
                x: 20
                y: ground.y - height
                onXChanged: view.makeSureBirdIsVisible()
                onYChanged: view.makeSureBirdIsVisible()
            }

            Wall{
                id: ground
                width: worldItem.width
                height: 20
                y: 585
//                showRect: true
            }

            Archery{
                id: archery
                property int birdIndex: 1
                y: ground.y - height
                x: 200
                target: bird
                onShoot: {
                    view.isInViewMove = false

                    worldItem.activeBird = target

                    birdIndex++;
                    if(birdIndex === 2)
                        target = bird2
                    else if(birdIndex === 3)
                        target = bird3
                    else
                        target = null
                }
            }

        }
    }
}
