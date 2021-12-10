import Felgo 3.0
import QtQuick 2.0
import VPlayApps 1.0

App {
    onInitTheme: {
        Theme.navigationBar.backgroundColor = DataModel.backgroundColor
        Theme.colors.backgroundColor = DataModel.backgroundColor
        Theme.colors.dividerColor = DataModel.backgroundColor
    }

    NavigationStack {
        Page {
            id: landingPage
            title: "SoccerMania"

            Text {
                anchors{
                    top: parent.top
                    topMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }
                text: "Max. Score: " + DataModel.maxScore
                font.family: "Arial"
                font.pointSize: 31
                color: "#ffffff"

            }

            Rectangle {
                anchors {
                    centerIn: parent
                }
                color: DataModel.selectorColor
                height: parent.height / 1.7
                width: parent.width / 1.5
                radius: 5
                clip: true

                Column {
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    spacing: 50

                    AppButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height / 4
                        width: parent.width - 10
                        text: "Easy Mode"
                        radius: 5
                        backgroundColor: DataModel.buttonBackgroundColor
                        backgroundColorPressed: DataModel.buttonBackgroundColorPressed
                        borderColor: DataModel.buttonBorderColor
                        borderColorPressed: DataModel.buttonBorderColorPressed
                        borderWidth: 5
                        textSize: 27
                        onClicked: {
                            DataModel.difficultyLevel = DataModel.DifficultyLevels.Easy
                            DataModel.resetGame()
                            landingPage.navigationStack.push(Qt.resolvedUrl("PlayArea.qml"))
                        }
                    }

                    AppButton {
                        height: parent.height / 4
                        width: parent.width
                        text: "Medium Mode"
                        radius: 5
                        backgroundColor: DataModel.buttonBackgroundColor
                        backgroundColorPressed: DataModel.buttonBackgroundColorPressed
                        borderColor: DataModel.buttonBorderColor
                        borderColorPressed: DataModel.buttonBorderColorPressed
                        borderWidth: 5
                        textSize: 27
                        onClicked: {
                            DataModel.difficultyLevel = DataModel.DifficultyLevels.Medium
                            DataModel.resetGame()
                            landingPage.navigationStack.push(Qt.resolvedUrl("PlayArea.qml"))
                        }
                    }

                    AppButton {
                        height: parent.height / 4
                        width: parent.width
                        text: "Hard Mode"
                        radius: 5
                        backgroundColor: DataModel.buttonBackgroundColor
                        backgroundColorPressed: DataModel.buttonBackgroundColorPressed
                        borderColor: DataModel.buttonBorderColor
                        borderColorPressed: DataModel.buttonBorderColorPressed
                        borderWidth: 5
                        textSize: 27
                        onClicked: {
                            DataModel.difficultyLevel = DataModel.DifficultyLevels.Hard
                            DataModel.resetGame()
                            landingPage.navigationStack.push(Qt.resolvedUrl("PlayArea.qml"))
                        }
                    }
                }
            }
        }
    }
}
