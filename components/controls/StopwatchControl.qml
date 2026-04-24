import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../presets"
import "../../commons"

Item {
    id: timerControl
    property alias printMessageLog: messageLog

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 8

        Rectangle {
            color: "#303030"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 4

            ColumnLayout {
                id: timerPresetLayout
                anchors.fill: parent
                spacing: 0

                RowLayout {
                    Layout.fillWidth: true
                    Layout.margins: 8

                    CText {
                        text: "Stopwatch Laps"
                        font.pixelSize: 16
                        font.weight: 700
                    }
                }

                ListView {
                    id: presetList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    model: ListModel {
                        id: lapsModel
                    }

                    Connections {
                        target: StopwatchService
                        function onLapsChanged() { presetList.syncModel() }
                    }

                    Component.onCompleted: syncModel()

                    function syncModel() {
                        lapsModel.clear();
                        StopwatchService.laps.forEach(lap => lapsModel.append(lap));
                    }

                    delegate: Rectangle {
                        width: presetList.width
                        height: presetInfo.implicitHeight + 16
                        color: model.index % 2 === 0 ? "#404040" : "#484848"

                        ColumnLayout {
                            id: presetInfo
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.margins: 8
                            spacing: 0

                            CText {
                                text: "#" + (model.index + 1)
                                font.pixelSize: 16
                            }
                        }

                        RowLayout {
                            id: presetActionButton
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.margins: 8
                            spacing: 4

                            CText {
                                text: "+" + model.lapFormat
                                font.family: Style.timeFont
                                font.weight: 600
                                font.pixelSize: 14
                            }

                            CText {
                                text: model.totalFormat
                                font.family: Style.timeFont
                                font.weight: 600
                                font.pixelSize: 14
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            CButton {
                visible: StopwatchService.state === StopwatchService.State.Idle
                iconSource: "controls/play.svg"
                text: "Play"
                onClicked: StopwatchService.start()
            }

            CButton {
                visible: StopwatchService.state === StopwatchService.State.Running
                iconSource: "controls/pause.svg"
                text: "Pause"
                onClicked: StopwatchService.pause()
            }

            CButton {
                visible: StopwatchService.state === StopwatchService.State.Paused
                iconSource: "controls/play.svg"
                text: "Resume"
                onClicked: StopwatchService.resume()
            }

            CButton {
                visible: StopwatchService.state !== StopwatchService.State.Idle
                iconSource: "controls/stop.svg"
                text: "Stop"
                onClicked: StopwatchService.stop()
            }

            CButton {
                visible: StopwatchService.state !== StopwatchService.State.Idle
                iconSource: "controls/lap.svg"
                text: "Lap"
                onClicked: StopwatchService.lap()
            }

            Item { Layout.fillWidth: true }

            CText {
                id: messageLog
                text: ""
                font.pixelSize: 14

                function log(message, timeout = 3000) {
                    this.text = message
                    this.color = "#FFFFFF"
                    this._showMessage(timeout)
                }

                function warn(message, timeout = 3000) {
                    this.text = message
                    this.color = "#C79777"
                    this._showMessage(timeout)
                }

                function error(message, timeout = 3000) {
                    this.text = message
                    this.color = "#C77777"
                    this._showMessage(timeout)
                }

                function _showMessage(timeout) {
                    this.visible = true
                    messageLogTimer.interval = timeout
                    messageLogTimer.start()
                }
            }
        }
    }

    Timer {
        id: messageLogTimer
        running: false
        repeat: false
        onTriggered: messageLog.visible = false
    }
}
