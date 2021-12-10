import QtQuick 2.0
import Felgo 3.0

AppImage {
    id: goal
    source: "../assets/footballGoal.png"

    Rectangle {
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        color: "#FFFCF9"
        height: 10
        width: parent.width * 2
    }
}
