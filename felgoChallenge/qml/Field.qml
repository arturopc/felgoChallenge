import QtQuick 2.0

Item {
    id: _field

    property string _backgroundColor: "#417B5A"
    property string _selectorColor: "#59855C"
    property string _buttonBackgroundColor: "#BE6E46"
    property string _buttonBackgroundColorPressed: "#84A190"
    property string _buttonBorderColor: "#FF9F1C"
    property string _buttonBorderColorPressed: "#FFF"
    property string _ballColor: "#FFFCF9"
    property string _fieldColor: "#39AD41"

    property int rotationSelected
    property int factorChange: 2
    property bool showDirectionBar
    property int ballMaxScale: 10
    property int ballMinScale: 20
    property int ballScalingFactor: ballMaxScale

    Timer {
        id: changeRotationTimer
        repeat: true
        interval: 20
        onTriggered: {
            changeRot()
        }
    }

    Timer {
        id: shotSetUpTimer
        repeat: false
        interval: 1500
        onTriggered: {
            ballScalingFactor = ballMinScale
            showDirectionBar = false
            _field.state = "shotTakenState"
            touchLog.text = " SSSSHOOOOOTTT"
            resultTimer.restart()
        }
    }

    Timer {
        id: resultTimer
        repeat: false
        interval: 1500
        onTriggered: {
            showDirectionBar = false
            _field.state = "bottom"
            touchLog.text = "ready to shoot"
            ballScalingFactor = ballMaxScale
        }
    }

    Rectangle {
        anchors {
            centerIn: parent
        }

        color: _fieldColor
        height: parent.height / 1.05
        width: parent.width / 1.1
        radius: 5
        clip: true

        Text {
            id: touchLog
            anchors.centerIn: parent
            font.pixelSize: 32
            color: "white"
            text: "Log: "
        }

        Rectangle {
            anchors {
                top: parent.top
                topMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
            color: "transparent"
            border.color: _ballColor
            border.width: 6
            height: parent.height / 4.2
            width: parent.width / 1.25

            Rectangle {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                color: _ballColor
                height: 10
                width: parent.width * 2
            }
        }

        Rectangle {
            id: directionBarSelected
            anchors {
                bottom: parent.bottom
                bottomMargin: 40
                horizontalCenter: parent.horizontalCenter
            }
            color: "transparent"
            height: parent.height - (70 * 1)//ball.height * 2
            width: 10//height / 10
            transformOrigin: Item.Bottom
            rotation: rotationSelected
            radius: 5

            Rectangle {
                id: directionBarSelectedTop
                anchors {
                    verticalCenter: parent.top
                    verticalCenterOffset: 5
                    horizontalCenter: parent.horizontalCenter
                }
                color: "transparent"
                height: 10
                width: height
                radius: height / 2
            }

            Rectangle {
                id: directionBarSelectedBottom
                anchors {
                    verticalCenter: parent.bottom
                    verticalCenterOffset: -5
                    horizontalCenter: parent.horizontalCenter
                }
                color: "transparent"
                height: 10
                width: height
                radius: height / 2
            }

            Rectangle {
                id: ball
                color: "white"
                height: parent.height / ballScalingFactor
                width: height
                radius: height / 2
                anchors.horizontalCenter: directionBarSelectedBottom.horizontalCenter
                anchors.verticalCenter: directionBarSelectedBottom.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        showDirectionBar = true
                        changeRotationTimer.restart()
                    }
                    onReleased: {
                        changeRotationTimer.stop()
                        shotSetUpTimer.restart()
                    }
                }
            }

            Rectangle {
                opacity: showDirectionBar
                anchors {
                    bottom: ball.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                color: _buttonBorderColor
                height: ball.height * 2
                width: 10
                transformOrigin: Item.Bottom
                rotation: rotationSelected
                radius: 5
                Behavior on rotation { NumberAnimation { duration: 200 }}
                Behavior on opacity { NumberAnimation { duration: 300 }}
                Behavior on scale { NumberAnimation { duration: 300 }}
            }
        }
    }

    states: [
        State {
            name: "shotTakenState"
            AnchorChanges {
                target: ball
                anchors.horizontalCenter: directionBarSelectedTop.horizontalCenter
                anchors.verticalCenter: directionBarSelectedTop.verticalCenter
            }
        },
        State {
            name: "bottom"
            AnchorChanges {
                target: ball
                anchors.horizontalCenter: directionBarSelectedBottom.horizontalCenter
                anchors.verticalCenter: directionBarSelectedBottom.verticalCenter
            }
        }
    ]

    transitions: Transition {
        AnchorAnimation { duration: 300 }
    }

    function changeRot() {
        if (rotationSelected > 30) {
            factorChange = -2
        } else if (rotationSelected < -30) {
            factorChange = 2
        }

        rotationSelected += factorChange
    }

}
