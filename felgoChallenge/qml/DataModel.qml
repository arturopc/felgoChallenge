pragma Singleton
import QtQuick 2.0

Item {

    //Colors
    property color backgroundColor: "#417B5A"
    property color selectorColor: "#59855C"
    property color buttonBackgroundColor: "#BE6E46"
    property color buttonBackgroundColorPressed: "#84A190"
    property color buttonBorderColor: "#FF9F1C"
    property color buttonBorderColorPressed: "#FFF"
    property color ballColor: "#FFFCF9"
    property color fieldColor: "#59855C"


    //Logic and Data
    property int difficultyLevel: DataModel.DifficultyLevels.Easy
    readonly property int intervalTimer: difficultyIntervalTimers[difficultyLevel]
    property int maxScore
    property int currentScore
    property int missedShots
    property int scoreMultiplier
    property int rotationSelected
    property int selectorFactorChange: 10
    property int goalieFactorChange: 20
    property int goaliePosition
    readonly property int ballMaxScale: 10
    readonly property int ballMinScale: 20
    property int ballScalingFactor: ballMaxScale
    property bool resetMultiplier
    property bool showDirectionBar
    property bool shotTaken
    readonly property bool gameOver: isGameOver()

    enum DifficultyLevels {
        Easy,
        Medium,
        Hard
    }

    property var difficultyIntervalTimers: [
        70,
        55,
        40
    ]

    onGameOverChanged: if (gameOver) updateMaxScore()

    function updateMaxScore() {
        if (currentScore > maxScore) {
            maxScore = currentScore
        }
    }

    function increaseScore() {
        currentScore += scoreMultiplier
    }

    function isGameOver() {
        return missedShots >= 3
    }

    function goalScored() {
        scoreMultiplier += 100
        increaseScore()
    }

    function missedShot() {
        missedShots++
        scoreMultiplier = 0
    }

    function resetGame() {
        updateMaxScore()
        currentScore = 0
        missedShots = 0
        rotationSelected = 0
        scoreMultiplier = 0
        selectorFactorChange = 10
        goalieFactorChange = 20
        goaliePosition = 0
        showDirectionBar = false
        shotTaken = false
        ballScalingFactor = ballMaxScale
    }
}
