import QtQuick 2.0
import Box2D 2.0

Entity {
    id: root
    property alias density: box.density
    property alias friction: box.friction
    property alias restitution: box.restitution

    fixture: Box{
        id: box
        density: 50;			//تراکم
        friction: 90;		//اصطکاک
        restitution: 0.2;		//بازتاب
        width: image.width
        height: image.height

        onBeginContact: {
            var totalX = body.linearVelocity.x - other.getBody().linearVelocity.x;
            var totalY = body.linearVelocity.y - other.getBody().linearVelocity.y;

            var t = Math.sqrt(totalX * totalX + totalY * totalY);

            damage -= Math.round(t)
        }
    }
}
