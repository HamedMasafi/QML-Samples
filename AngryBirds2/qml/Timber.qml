import QtQuick 2.0
import Box2D 2.0

BoxEntity {
    id: root
    source: "img/timber.png"
    density: 10;
    friction: 0.3;
    restitution: 0.5;
    damage: 30
    particleSource: "img/wood-slice.png"
}
