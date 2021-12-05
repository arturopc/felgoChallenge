import Felgo 3.0
import QtQuick 2.0
import VPlayApps 1.0

App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    property string _backgroundColor: "#417B5A"
    property string _selectorColor: "#59855C"
    property string _buttonBackgroundColor: "#BE6E46"
    property string _buttonBackgroundColorPressed: "#84A190"
    property string _buttonBorderColor: "#FF9F1C"
    property string _buttonBorderColorPressed: "#FFF"

    NavigationStack {
        navigationBar.backgroundColor: _backgroundColor

        Page {
            id: landingPage
            backgroundColor: _backgroundColor

            Rectangle {
                anchors {
                    centerIn: parent
                }
                color: _selectorColor
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
                        text: "Best of 3 Mode"
                        radius: 5
                        backgroundColor: _buttonBackgroundColor
                        backgroundColorPressed: _buttonBackgroundColorPressed
                        borderColor: _buttonBorderColor
                        borderColorPressed: _buttonBorderColorPressed
                        borderWidth: 5
                        textSize: 27
                        onClicked: {
                            landingPage.navigationStack.push(Qt.resolvedUrl("Best3Mode.qml"))
                        }
                    }

                    AppButton {
                        height: parent.height / 4
                        width: parent.width
                        text: "Best of 5 Mode"
                        radius: 5
                        backgroundColor: _buttonBackgroundColor
                        backgroundColorPressed: _buttonBackgroundColorPressed
                        borderColor: _buttonBorderColor
                        borderColorPressed: _buttonBorderColorPressed
                        borderWidth: 5
                        textSize: 27
                        onClicked: {
                            landingPage.navigationStack.push(Qt.resolvedUrl("Best3Mode.qml"))
                        }
                    }

                    AppButton {
                        height: parent.height / 4
                        width: parent.width
                        text: "High Score Mode"
                        radius: 5
                        backgroundColor: _buttonBackgroundColor
                        backgroundColorPressed: _buttonBackgroundColorPressed
                        borderColor: _buttonBorderColor
                        borderColorPressed: _buttonBorderColorPressed
                        borderWidth: 5
                        textSize: 27
                        onClicked: {
                            landingPage.navigationStack.push(Qt.resolvedUrl("Best3Mode.qml"))
                        }
                    }
                }
            }
        }
    }
}
