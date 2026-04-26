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

        TimerPreset {
            Layout.fillWidth: true
            Layout.fillHeight: true
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
                    id: timerNameInput
                    Layout.fillWidth: true
                    placeholderText: "New Timer"
                    font.pixelSize: 16
                }

                // Time display
                CTextField {
                    id: timerDurationInput
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
                    id: timerExtendInput
                    Layout.fillWidth: true

                    text: "+00:00:00"
                    placeholderText: "+00:00:00"
                    inputMask: "+99:99:99"
                    validator: RegularExpressionValidator {
                        regularExpression: /\+[0-9][0-9]\:[0-5][0-9]\:[0-5][0-9]/
                    }

                    font.family: Style.timeFont
                    font.weight: 600
                    font.pixelSize: 16
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
                    const timer = parseTimer();
                    if (timer !== null) TimerService.start(...timer);
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
                    const timer = parseTimer();
                    if (timer !== null) TimerService.start(...timer);
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

    function setFieldsFromPreset(preset) {
        timerNameInput.text = preset.name
        timerDurationInput.text = preset.duration
        timerExtendInput.text = preset.extend
    }

    function getFieldsAsPreset(preset) {
        return {
            "name": timerNameInput.text,
            "duration": timerDurationInput.text,
            "extend": timerExtendInput.text,
        }
    }

    function parseTimer() {
        let [hm, mm, sm] = timerDurationInput.text.split(":");
        let durMain = (parseInt(hm) * 3600 + parseInt(mm) * 60 + parseInt(sm)) * 1000;
        if (durMain <= 0) {
            messageLog.error("Timer value is 0 or less!");
            return null;
        }
        else durMain += 900;

        let [he, me, se] = timerExtendInput.text.split(":");
        let durExtend = (parseInt(he) * 3600 + parseInt(me) * 60 + parseInt(se)) * 1000;
        if (durExtend > 0) durExtend += 900;

        return [durMain, durExtend];
    }
}
