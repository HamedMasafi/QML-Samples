import QtQuick 2.0
import Box2D 2.0

Rectangle {
    id: chainBall

    width: size
    height: size
    color: isWhite ? "red" : "black"
    radius: size / 2
    border.color: 'gray'

    property Body body: circleBody

    property int size: 40
    property alias restitution: circle.restitution
    property alias density: circle.density
    property alias friction: circle.friction
    property bool isWhite: true
    property bool isActive: false

    signal moveStarted()
    signal moveEnded()

    signal mousePressed();
    signal mouseMoved();
    signal mouseReleased();



    Body {
        id: circleBody
        target: chainBall
    //        world: physicsWorld
        linearDamping: 1
        angularDamping: 2
        bodyType: Body.Dynamic

//        property alias fixture: circle

//        property alias density: circle.density
//        property alias friction: circle.friction
//        property alias restitution: circle.restitution
//        property alias sensor: circle.sensor
//        property alias categories: circle.categories
//        property alias collidesWith: circle.collidesWith
//        property alias groupIndex: circle.groupIndex

//        property alias x: circle.x
//        property alias y: circle.y
//        property alias radius: circle.radius

        signal beginContact(Fixture other)
        signal endContact(Fixture other)

        Circle {
            id: circle
            restitution: 0.2        // بازگشت
            friction: 50            // اصطکال
            density: 60             // تراکم
            radius: 40

            onBeginContact: body.beginContact(other)
            onEndContact: body.endContact(other)
        }
    }
}
