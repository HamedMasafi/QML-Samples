import QtQuick 2.0
import Box2D 2.0

BoxEntity {
    source: "img/wood-box.png"
    density: 10;
    friction: 0.3;
    restitution: 0.5;
    particleSource: "img/wood-slice.png"
    damage: 25
}
