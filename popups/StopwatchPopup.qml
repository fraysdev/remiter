import QtQuick
import QtQuick.Layouts

import "../commons"

PopupLayout {
    id: root
    name: "Stopwatch"
    iconSource: "modules/stopwatch.svg"
    timeDisplay: StopwatchService.state !== StopwatchService.State.Idle ? StopwatchService.display : ""
    timeColor: {
        if (StopwatchService.state === StopwatchService.State.Idle)
            return Style.textColor

        let color = Style.textColorRunning
        if (StopwatchService.state === StopwatchService.State.Paused)
            color = Qt.tint(color, "#60202020")

        return color
    }
    status: {
        if (StopwatchService.state === StopwatchService.State.Paused)
            return "Paused"
        return ""
    }
    extendedStatus: RowLayout {
        visible: StopwatchService.laps.length !== 0
        spacing: maximize ? 16 : 4

        RowLayout {
            spacing: 0

            SvgIcon {
                Layout.bottomMargin: maximize ? 8 : 2
                source: "controls/lap.svg"
                color: "#FFFFFF"
                size: maximize ? 60 : 15
            }

            CText {
                text: StopwatchService.laps.length !== 0 ? "#" + StopwatchService.getLastLap().number : ""
                font.pixelSize: maximize ? 80 : 20
            }
        }

        CText {
            text: StopwatchService.laps.length !== 0 ? StopwatchService.getLastLap().totalFormat : ""
            font.pixelSize: maximize ? 80 : 20
            font.family: Style.timeFont
            font.weight: 600
        }
    }
}
