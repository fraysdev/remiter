import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../commons"

Item {
    id: root

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
                        text: "Timer Preset"
                        font.pixelSize: 18
                        font.weight: 700
                    }

                    CText {
                        text: "(Coming Soon)"
                        font.pixelSize: 12
                    }

                    Item { Layout.fillWidth: true }

                    CButton {
                        iconSource: "presets/remove.svg"
                        text: "Remove"
                        visible: presetList.currentIndex >= 0
                        onClicked: {
                            if (presetList.currentIndex >= 0)
                                presetModel.remove(presetList.currentIndex)
                        }
                    }

                    CButton {
                        iconSource: "presets/edit.svg"
                        text: "Edit"
                        visible: presetList.currentIndex >= 0
                        onClicked: console.log("Edit preset", presetList.currentIndex)
                    }

                    CButton {
                        iconSource: "presets/add.svg"
                        text: "Add"
                        onClicked: {
                            presetModel.append({
                                "name": "New Preset",
                                "duration": "00:00:00",
                                "extend": "+00:00:00"
                            })
                        }
                    }
                }

                ListView {
                    id: presetList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    currentIndex: -1

                    model: ListModel {
                        id: presetModel
                    }

                    delegate: Rectangle {
                        width: presetList.width
                        height: itemLayout.implicitHeight + 16
                        color: model.index % 2 === 0 ? "#404040" : "#484848"

                        ColumnLayout {
                            id: itemLayout
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.margins: 8
                            spacing: 0

                            CText {
                                text: model.index + ". " + model.name
                                font.pixelSize: 14
                            }

                            RowLayout {
                                spacing: 4

                                CText {
                                    text: model.duration
                                    font.family: Style.timeFont
                                    font.weight: 600
                                    font.pixelSize: 14
                                }

                                CText {
                                    text: model.extend
                                    font.family: Style.timeFont
                                    font.weight: 600
                                    font.pixelSize: 10
                                }
                            }

                        }
                    }
                }
            }
        }

        Rectangle {
            color: "#303030"
            Layout.fillWidth: true
            Layout.preferredHeight: timerInputLayout.implicitHeight + 16
            radius: 4

            ColumnLayout {
                id: timerInputLayout
                spacing: -8
                anchors.fill: parent
                anchors.margins: 8

                CTextField {
                    id: nameTimerInput
                    Layout.fillWidth: true
                    placeholderText: "New Timer"
                }

                // Time display
                CTextField {
                    id: mainTimerInput
                    Layout.fillWidth: true

                    text: "00:00:00"
                    placeholderText: "00:00:00"
                    inputMask: "99:99:99"
                    validator: RegularExpressionValidator {
                        regularExpression: /[0-9][0-9]\:[0-5][0-9]\:[0-5][0-9]/
                    }

                    font.family: Style.timeFont
                    font.weight: 600
                    font.pixelSize: 32
                }

                CTextField {
                    id: extendTimerInput
                    Layout.fillWidth: true

                    text: "+00:00:00"
                    placeholderText: "+00:00:00"
                    inputMask: "+99:99:99"
                    validator: RegularExpressionValidator {
                        regularExpression: /\+[0-9][0-9]\:[0-5][0-9]\:[0-5][0-9]/
                    }

                    font.family: Style.timeFont
                    font.weight: 600
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            CButton {
                visible: TimerService.state === TimerService.State.Idle
                iconSource: "controls/play.svg"
                text: "Play"
                onClicked: {
                    let [hm, mm, sm] = mainTimerInput.text.split(":")
                    let durMain = (parseInt(hm) * 3600 + parseInt(mm) * 60 + parseInt(sm)) * 1000
                    if (durMain <= 0) return messageLog.error("Timer cannot start at 0 or less!")
                    else durMain += 900

                    let [he, me, se] = extendTimerInput.text.split(":")
                    let durExtend = (parseInt(he) * 3600 + parseInt(me) * 60 + parseInt(se)) * 1000
                    if (durExtend > 0) durExtend += 900

                    TimerService.start(durMain, durExtend)
                }
            }

            CButton {
                visible: TimerService.state !== TimerService.State.Idle
                iconSource: "controls/stop.svg"
                text: "Stop"
                onClicked: TimerService.stop()
            }

            CButton {
                visible: (TimerService.state === TimerService.State.Running
                    || TimerService.state === TimerService.State.Paused)
                iconSource: TimerService.state === TimerService.State.Running
                    ? "controls/pause.svg"
                    : "controls/play.svg"
                text: TimerService.state === TimerService.State.Running
                    ? "Pause"
                    : "Resume"
                onClicked: TimerService.toggleRunning()
            }

            CButton {
                visible: TimerService.state !== TimerService.State.Idle
                iconSource: "controls/restart.svg"
                text: "Restart"
                onClicked: {
                    let [hm, mm, sm] = mainTimerInput.text.split(":")
                    let durMain = (parseInt(hm) * 3600 + parseInt(mm) * 60 + parseInt(sm)) * 1000
                    if (durMain <= 0) return messageLog.error("Timer cannot restart at 0 or less!")
                    else durMain += 900

                    let [he, me, se] = extendTimerInput.text.split(":")
                    let durExtend = (parseInt(he) * 3600 + parseInt(me) * 60 + parseInt(se)) * 1000
                    if (durExtend > 0) durExtend += 900

                    TimerService.start(durMain, durExtend)
                }
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

    function presetSelected(model) {
        nameTimerInput.text = model.name
        mainTimerInput.text = model.duration
    }
}
