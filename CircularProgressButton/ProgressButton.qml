import QtQuick 2.5

Item {
    id: root
    height: 100
    width: 300

    property int value: 0
    property int lineWidth: 8
    property bool success: true

    property alias font: buttonText.font

    property color successColor: "#1ecd97"
    property color errorColor: "#fb797e"
    property color grayColor: "#dddddd"
    property color color: "#f9f9f9"

    function reset(){
        value = 0;
        iconContainer.width = iconContainer.height = 0;
    }

    onValueChanged: {
        if(root.value === 0){
            state = "normal";
            btn.color = Qt.binding(function() {return mouseArea.containsMouse ? successColor : root.color} );
            btn.border.color = successColor
        }

        if(root.value === 100){
            animShowIcon.start();
            if(success)
                btn.color = btn.border.color = successColor
            else
                btn.color = btn.border.color = errorColor
        }

        canvas.requestPaint();
    }

    Rectangle{
        id: btn
        Behavior on width { NumberAnimation {duration: 150} }

        height: parent.height
        width: (root.value > 0 && root.value < 100) ? height : root.width
        color: mouseArea.containsMouse ? successColor : root.color

        border.color: successColor
        border.width: 4
        anchors.centerIn: parent
        radius: height / 2

        Text {
            id: buttonText
            color: mouseArea.containsMouse ? "white" : successColor
            opacity: root.value === 0 ? 1 : 0;
            Behavior on opacity { NumberAnimation {duration: 150} }

            text: qsTr("text")
            anchors.centerIn: parent
        }
    }
    Canvas {
        id: canvas

        opacity: (btn.width === btn.height) ? 1 : 0
        height: parent.height
        width: parent.height
        anchors.centerIn: parent
        antialiasing: true

        Behavior on opacity { NumberAnimation {duration: 150} }

        property real angleOffset: (-Math.PI / 2)

        onPaint: {
            var angle = (root.value) / (100) * 2 * Math.PI
            var ctx = getContext("2d");
            ctx.save();

            ctx.clearRect(0, 0, canvas.width, canvas.height);

            ctx.beginPath();
            ctx.lineWidth = root.lineWidth;
            ctx.strokeStyle = grayColor;
            ctx.arc(canvas.width / 2,
                    canvas.height / 2,
                    btn.radius - (lineWidth / 2),
                    (-Math.PI / 2) + angle,
                    (-Math.PI / 2) + 2 * Math.PI);
            ctx.stroke();

            ctx.beginPath();
            ctx.lineWidth = root.lineWidth;
            ctx.strokeStyle = successColor
            ctx.arc(canvas.width / 2,
                    canvas.height / 2,
                    btn.radius - (lineWidth / 2),
                    (-Math.PI / 2),
                    (-Math.PI / 2) + angle);
            ctx.stroke();

            ctx.restore();
        }
    }

    Item{
        id: iconContainer
        anchors.centerIn: parent
        clip: true
        width: 0
        height: 0

        NumberAnimation {
            id: animShowIcon
            target: iconContainer
            properties: "width,height"
            duration: 200
            from: 0
            to: root.height * .66
        }
        Image {
            id: finishIconOK
            visible: root.success
            anchors.centerIn: parent
            fillMode: Image.Stretch
            source: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAABmJLR0QAAAAAAAD5Q7t/AAAACXBI
WXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4AkPDBcrL8ZHtwAAABl0RVh0Q29tbWVudABDcmVhdGVk
IHdpdGggR0lNUFeBDhcAAAH1SURBVGje3dm/SgNBEAbwb49UIijBwjKQyiZ2WosKPoOQZ7QRQSGN
lX8wkFSCnRYWivgAgc8mwTPe5W53Zvb2MnBFIGzyu73d2ZlzJOEbzjmkFh20IOrc7E7bAUlDQh73
bB0QSc1IKCAZiBSQxKOlhWgUooloDCJAbAHoJQERIq4B3ALoFw7se0kQgdcWyTv+xivJ/p//FAMi
ABQhCjGmECFgFeIfxlmcfpV2pMWaOKz43huAI3WIIuIGwEHN71+oQiLPxCLGAE6zBLZVMQLAV7YO
CPGhUfGYIUKIMntKiDLIBoBLAMO2IIqS1ibJ0TzZzEgOFZJaaLJbjieS3dIknfvQLRjYCqOKyEN2
SU5LBtHGqCMWkB7Jl4rBtDAmiAVkUnPQGclzIeLeA/FAcrv2QZbkHsl3D8wwpZlYXiMDkh9GGHPE
8q5lgYmCKCqsNDHREGUVogYmKmJVqSvBREdU1ewhmEYQdZoPvphnqzxRddUpdQcARgB2FPt05adY
w5bpFMAxgM9UET6FlRbGBOFbIUoxZoiQUncK4CQA8zi/CSaI0Jp94jkzYwBnAL6tEM65sJapx25m
+jjlG4WSvlbVmomG0OqYFyVNtYxd+02A0g/kMWaIGBCQ3Cd5pXns8IFIFnsjUfYmIFsHROsgyb1n
154NAPgBPLUoKuOQaTAAAAAASUVORK5CYII="

        }
        Image {
            id: finishIconError
            visible: !root.success
            anchors.centerIn: parent
            fillMode: Image.Stretch
            source: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAABmJLR0QAAAAAAAD5Q7t/AAAACXBI
WXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4AkPDBkK/Sx6ZwAAABl0RVh0Q29tbWVudABDcmVhdGVk
IHdpdGggR0lNUFeBDhcAAAIRSURBVGje1dm/btRAEMfxH5auQRGBAkspSNIEIlFQ8ADJS9DwHPRH
4wopZZJ3uHcIUgqIAg3EShr+NEAe40uDJd/F9tm7s38YaSpbo/nc6nb35u4B6oh9SSeSXku61X8Q
RQ/ivaRDSWeStjLpdSFp1vsUaOc+cMty3ABbK+/FziYWwKzrnXWI1Ji6o5dOTBvxh+GIjakHermD
GYuIjalH9LKEEXDFtLgCysSIO5ipKxJ6ZWqmxwKYTfmOhMZc4x6v2oWeAb8TYWoPxHx1+02F8UZ0
QQQ8jYgxQfRBGsyvgJjSEjEEEbAXCGOOWAcJgQmCGAMRsAv8NMAEQ4yFWGCCIqZABOwAPxwwL0Ij
pkJcMYRGuEBiYuZT+nI9jbeB77kgfCAhMXOXfnwve9vAt9QIC4iAJ0aYuU8fVr8lXqZEWEF8D7tT
iw+z8Byalf+GeM89ahxYDAGLxIhmsuk90SwSI8wwRQYIE0yRCcIbU2SE8MIUkRDHkuqgmIiDgtJh
PDt6oBF72lECX0Ngok87gMchMLERwTApEG3MFytMKkSTj4DPFpiUiDbmky8mNaLJh76YHBBtzKUr
RsAbD8Rb47/enDFNgSrhSlhsAKftAlUGiCY3gYuRvZwDG6sFqgwQUzDnwEbfgVhlgGhjPq5DDF1R
qgwQQ5glxLpLY5UBoskHwIc+xJhr/LsAW6wP5gi43/X8L4oaqVvsxIYMAAAAAElFTkSuQmCC"

        }
    }

    MouseArea{
        id: mouseArea
        enabled: btn.width !== btn.height
        anchors.fill: parent
        hoverEnabled: true
    }
}
