import QtQuick 2.0
import Box2D 2.0

CircleEntity {
    id: root
    source: "img/bird.png"
    density: 50;			//تراکم
    friction: 90;		//اصطکاک
    restitution: 0.2;		//بازتاب
    damage: 100
    particleSource: "img/bird-slice.png"
}
