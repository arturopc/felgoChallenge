import QtQuick 2.0
import Felgo 3.0

Item {
    id: _field

    Timer {
        id: changeRotationTimer
        repeat: true
        interval: DataModel.intervalTimer
        onTriggered: {
            moveKeeper()
            changeRot()
        }
    }

    Timer {
        id: shotSetUpTimer
        repeat: false
        interval: 1500
        onTriggered: {
            DataModel.shotTaken = true
            DataModel.ballScalingFactor = DataModel.ballMinScale
            _field.state = "shotTakenState"
            touchLog.text = getResult()
            resultTimer.restart()
        }
    }

    Timer {
        id: resultTimer
        repeat: false
        interval: 1500
        onTriggered: {
            if (DataModel.isGameOver()) {
                touchLog.text = "Game Over."
            } else {
                DataModel.shotTaken = false
                _field.state = "bottom"
                touchLog.text = "Ready to shoot."
                DataModel.ballScalingFactor = DataModel.ballMaxScale
            }
        }
    }

    Rectangle {
        id: playarea
        anchors.centerIn: parent
        color: DataModel.fieldColor
        height: parent.height / 1.05
        width: parent.width / 1.1
        radius: 5
        clip: true

        AppButton {
            anchors {
                bottom: parent.bottom
                bottomMargin: 100
                horizontalCenter: parent.horizontalCenter
            }
            height: 50
            width: 100
            text: "Restart game."
            radius: 5
            backgroundColor: DataModel.buttonBackgroundColor
            backgroundColorPressed: DataModel.buttonBackgroundColorPressed
            borderColor: DataModel.buttonBorderColor
            borderColorPressed: DataModel.buttonBorderColorPressed
            borderWidth: 5
            textSize: 27
            visible: DataModel.gameOver
            onClicked: {
                DataModel.resetGame()
                _field.state = "bottom"
                touchLog.text = "Ready to shoot."
            }
        }

        Text {
            id: touchLog
            anchors.centerIn: parent
            font.pixelSize: 32
            color: "white"
            text: DataModel.isGameOver() ? "Game Over!" : "Hold football to start aiming."
            horizontalAlignment: Text.AlignHCenter
        }

        Goal {
            id: goal
            scale: 0.6
            anchors {
                top: parent.top
                topMargin: -20
                horizontalCenter: parent.horizontalCenter
            }
        }

        AppImage {
            id: goalie
            x: 40 + ((goal.width/2) * goal.scale) - (width / 2) + DataModel.goaliePosition
            y: 40
            width: 112
            height: 120
            source: DataModel.shotTaken ? "../assets/goalKeeperAction.png" :
                                "../assets/goalKeeperWaiting.png"
        }

        Rectangle {
            id: ballFinalPosition
            x: (playarea.width / 2) - (ball.width / 4) + getBallPosition()
            y: 75
            color: "transparent"
            height: 50
            width: 30
        }

        Rectangle {
            id: directionBarSelected
            anchors {
                bottom: parent.bottom
                bottomMargin: 40
                horizontalCenter: parent.horizontalCenter
            }
            color: "transparent"
            height: 630
            width: 10
            transformOrigin: Item.Bottom
            rotation: DataModel.rotationSelected
            radius: 5

            Ball {
                id: ball
                width: 60
                height: 60
                x: parent.width - 30
                y: DataModel.shotTaken ? -30 : parent.height -30
                scale: DataModel.shotTaken ? 0.4 : 1.0

                MouseArea {
                    enabled: !DataModel.shotTaken
                    anchors.fill: parent
                    onPressed: {
                        DataModel.showDirectionBar = true
                        changeRotationTimer.restart()
                    }
                    onReleased: {
                        changeRotationTimer.stop()
                        shotSetUpTimer.restart()
                        DataModel.showDirectionBar = false
                    }
                }
            }

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
                anchors {
                    bottom: ball.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                height: ball.height * 2
                width: 10
                opacity: DataModel.showDirectionBar
                color: DataModel.buttonBorderColor
                transformOrigin: Item.Bottom
                rotation: DataModel.rotationSelected
                radius: 5

                Behavior on opacity { NumberAnimation { duration: 500 }}
                Behavior on scale { NumberAnimation { duration: 200 }}
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
        if (DataModel.rotationSelected >= 20) {
            DataModel.selectorFactorChange = -DataModel.selectorFactorChange
        } else if (DataModel.rotationSelected <= -20) {
            DataModel.selectorFactorChange = Math.abs(DataModel.selectorFactorChange)
        }

        DataModel.rotationSelected += DataModel.selectorFactorChange
    }

    function moveKeeper() {
        if (goalie.x < 45) {
            DataModel.goalieFactorChange = Math.abs(DataModel.goalieFactorChange)
        } else if (goalie.x >= (45 + ((goal.width * goal.scale) - goalie.width))) {
            DataModel.goalieFactorChange = -DataModel.goalieFactorChange
        }

        DataModel.goaliePosition += DataModel.goalieFactorChange
    }

    function getResult() {
        let insideGoalAngle = (Math.asin((goal.width / 2) / directionBarSelected.height) / 2)
        insideGoalAngle = (insideGoalAngle * 180) / Math.PI

        let ballPosition = getBallPosition()

        if (DataModel.rotationSelected > -insideGoalAngle && DataModel.rotationSelected < insideGoalAngle) {
            if (!(((ballFinalPosition.x + ballFinalPosition.width) > (goalie.x + goalie.width / 2 - 20)) &&
                    (ballFinalPosition.x < (goalie.x + goalie.width / 2 + 10)))) {
                DataModel.goalScored()
                return "GOOOAAAALLL!!!!\nScore x" + DataModel.scoreMultiplier
            }
        }

        DataModel.missedShot()
        return "BOOOOOOO!!!"
    }

    function getBallPosition() {
        let shotAngle = (DataModel.rotationSelected * Math.PI) / 180
        let ballPosition = Math.sin(shotAngle) * directionBarSelected.height
        return ballPosition
    }
}
