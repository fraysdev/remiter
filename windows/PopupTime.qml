import QtQuick
import QtQuick.Layouts
import QtQuick.VectorImage

import "../commons"

Window {
    id: root
    width: 350
    height: 116
    visible: true
    color: "#202020"
    title: "Retimer - Time"

    CText {
        id: mainTime
        anchors.centerIn: parent
        text: {
            if (TimerService.state !== TimerService.State.Idle)
                return TimerService.display
            return Qt.formatDateTime(ClockService.currentTime, "hh:mm:ss")
        }
        font.pixelSize: 64
        font.family: Style.timeFont
        font.weight: 600
    }

    CText {
        anchors.left: mainTime.left
        anchors.bottom: mainTime.top
        anchors.leftMargin: 4
        anchors.bottomMargin: -8
        text: Qt.formatDateTime(ClockService.currentTime, "ddd, dd MMM yyyy")
        font.pixelSize: 14
    }

    CText {
        anchors.right: mainTime.right
        anchors.bottom: mainTime.top
        anchors.rightMargin: 4
        anchors.bottomMargin: -8
        text: Qt.formatDateTime(ClockService.currentTime, "hh:mm:ss")
        font.pixelSize: 14
        font.family: Style.timeFont
        font.weight: 600
        visible: TimerService.state !== TimerService.State.Idle
    }

    RowLayout {
        spacing: 4
        anchors.left: mainTime.left
        anchors.top: mainTime.bottom
        anchors.leftMargin: 4
        anchors.topMargin: -8

        SvgIcon {
            source: {
                if (TimerService.state !== TimerService.State.Idle) return "modules/timer.svg"
                return "modules/clock.svg"
            }
            color: "#FFFFFF"
            size: 14
        }

        CText {
            text: {
                if (TimerService.state !== TimerService.State.Idle) return "Timer"
                return "Clock"
            }
            font.pixelSize: 14
        }

        CText {
            text: "•"
            visible: timerStatus.visible
            font.pixelSize: 14
        }

        CText {
            id: timerStatus
            visible: TimerService.state === TimerService.State.Paused
                || TimerService.state === TimerService.State.Finished
                || (TimerService.state === TimerService.State.Running && TimerService.extending)
            text: {
                if (TimerService.state === TimerService.State.Running && TimerService.extending)
                    return "Extending"
                else if (TimerService.state === TimerService.State.Paused)
                    return "Paused"
                else if (TimerService.state === TimerService.State.Finished)
                    return "Finished"
                return ""
            }

            font.pixelSize: 14
        }
    }
}
