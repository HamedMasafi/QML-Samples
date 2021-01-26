import QtQuick 2.0
import Box2D 2.0

CircleEntity {
    id: root
    source: "img/pig.png"
    density: 50;			//تراکم
    friction: 90;		//اصطکاک
    restitution: 0.2;		//بازتاب
    particleSource: "img/pig-slice.png"
    damage: 5
}
