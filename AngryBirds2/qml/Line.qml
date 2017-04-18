import QtQuick 2.0

Item{
    id: root
    property int point1x: 0
    property int x2: 0
    property int point1y: 0
    property int y2: 0
    property alias lineColor: box.color
    property alias lineWidth: box.height
    height: 1

    Rectangle{
        id: box
        color: "#8d1b1b"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        height: 6
    }
    transformOrigin: Item.Left

    function __update(){
        var deg = Math.atan2(y2 - y, x2 - x) * 180 / Math.PI;

        root.rotation = deg;
        root.width = Math.sqrt(
                    Math.pow(x - x2, 2)
                    + Math.pow(y - y2, 2))
    }

    onXChanged: __update()
    onYChanged: __update()
    onX2Changed: __update()
    onY2Changed: __update()
}
