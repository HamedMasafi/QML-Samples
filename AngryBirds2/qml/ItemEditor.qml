import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import Box2D 2.0

Rectangle {
    id: root
    width: layout.width
    height: layout.height
    border.color: "#00000000"
    property Entity target
    visible: target != null

    onTargetChanged: {
        if(target === null)
            return;

        root.x = target.x
        root.y = target.y - root.height
        checkBoxIsActive.checked = (target.body.bodyType === Body.Dynamic)
        spinAngle.value = target.rotation
        spinDamage.value = target.damage
    }

    RowLayout{
        id: layout
        Rectangle {
            Layout.fillHeight: true
            width: 20
            color: "#bebebe"

            Drag.active: dragArea.drag.active
            Drag.hotSpot.x: 10
            Drag.hotSpot.y: 10

            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: root

                onPositionChanged: {
                    target.x = root.x
                    target.y = root.y + root.height
                }
            }
        }
        CheckBox {
            id: checkBoxIsActive
            text: qsTr("Active")
            onCheckedChanged: target.body.bodyType = checked ? Body.Dynamic : Body.Static
        }
        Label{
            text: qsTr("Angle:")
        }
        SpinBox{
            id: spinAngle
            minimumValue: 0
            maximumValue: 359
            onValueChanged: {
                if(target !== null)
                    target.rotation = value
            }
        }

        Label{
            text: qsTr("Damage:")
        }
        SpinBox{
            id: spinDamage
            minimumValue: 1
            maximumValue: 300
            onValueChanged: {
                if(target !== null)
                    target.damage = value
            }
        }
        Button{
            text: "Remove"
            onClicked: {
                target.destroy()
                target = null;
            }
        }
    }
}
