import Felgo 3.0
import QtQuick 2.0

Page {

    title: DataModel.gameOver ? "Press arrow to go back." : "Current score: " + DataModel.currentScore

    backNavigationEnabled: true

    Field {
        anchors.fill: parent
    }
}
