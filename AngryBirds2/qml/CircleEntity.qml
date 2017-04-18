import QtQuick 2.0
import Box2D 2.0

Entity {
    id: root
    property alias density: circle.density
    property alias friction: circle.friction
    property alias restitution: circle.restitution

    fixture: Circle{
        id: circle
        radius: image.width / 2
        density: 50;			//تراکم
        friction: 90;		//اصطکاک
        restitution: 0.2;		//بازتاب

        onBeginContact: {
            var totalX = body.linearVelocity.x - other.getBody().linearVelocity.x;
            var totalY = body.linearVelocity.y - other.getBody().linearVelocity.y;

            var t = Math.sqrt(totalX * totalX + totalY * totalY);

            damage -= Math.round(t)
        }
    }
}
