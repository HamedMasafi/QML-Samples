import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0
import Box2D 2.0

Item {
    id: root
    signal clicked()
    property int damage: 0
    property bool selected: false
    property alias source: image.source
    property alias particleSource: imageParticle.source
    property alias body: body
    property alias fixture: body.fixtures
    property alias image: image

    height: image.height
    width: image.width

    onFixtureChanged: {
        console.log("onFixtureChanged")
        fixture.onBeginContact.connect(function(){
            console.log("onBeginContact")
            var totalX = body.linearVelocity.x - other.getBody().linearVelocity.x;
            var totalY = body.linearVelocity.y - other.getBody().linearVelocity.y;

            var t = Math.sqrt(totalX * totalX + totalY * totalY);

            damage -= Math.round(t) /// 100;

//            body.beginContact(other)
        })
    }

    onDamageChanged: {
        if(damage< 0){
            emmiter.burst(50)
            image.visible = false
            body.active = false
        }
    }

    Body{
        id: body
        bodyType: Body.Dynamic
        target: root
    }

    RectangularGlow{
        visible: selected
        anchors.fill: parent
        glowRadius: 10
        spread: 0.2
        color: "yellow"
    }

    Image {
        id: image
        source: "img/bird.png"
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
//            emmiter.burst(50)
            root.clicked()
        }
    }



    ParticleSystem {
        id: particleSystem
        //        running: gameIsRunning
    }


    ImageParticle {
        id: imageParticle
        system: particleSystem
        source: "img/bird-slice.png"
        alpha: 0.7
        alphaVariation: .1
        color: "yellow"
        //        blueVariation: 0.1
        blueVariation: .2
        redVariation: .2
//        entryEffect: ImageParticle.Scale

    }
    Emitter {
        id: emmiter
        enabled: false
        anchors.fill: parent
//        width: 2
//        height: 3
        system: particleSystem
        emitRate: 80
        lifeSpan: 300
        lifeSpanVariation: 20
        startTime: lifeSpan
        size: 5
        endSize: 6
        sizeVariation: 0
        velocity: AngleDirection {
            angle: 0
            angleVariation: 360
            magnitude: 50 //* pixelDensity
        }
        acceleration: AngleDirection {
            angle: 0
            angleVariation: 360
            magnitude: 30 //* pixelDensity
        }
    }

//    Text {
//        y:-20
//        text: damage
//    }
}
