import QtQuick 2.0
import Box2D 2.0

CircleEntity {
    id: root
    source: "img/bird.png"
    density: 50;			//تراکم
    friction: 1500;		//اصطکاک
    restitution: 0.5;		//بازتاب
    damage: 30
    particleSource: "img/bird-slice.png"
}
