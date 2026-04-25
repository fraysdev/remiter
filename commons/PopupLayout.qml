import QtQuick
import QtQuick.Layouts

Item {
    id: root
    anchors.fill: parent

    property string name: ""
    property string iconSource: ""
    property string timeDisplay: ""
    property string status: ""
    property Component extendedStatus: null
    property alias timeColor: mainTime.color

    CText {
        id: mainTime
        anchors.centerIn: parent
        text: timeDisplay || Qt.formatDateTime(ClockService.currentTime, "hh:mm:ss")
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
        font.pixelSize: 15
    }

    RowLayout {
        visible: timeDisplay
        anchors.right: mainTime.right
        anchors.bottom: mainTime.top
        anchors.rightMargin: 4
        anchors.bottomMargin: -8
        spacing: 4

        SvgIcon {
            Layout.bottomMargin: 2
            source: "modules/clock.svg"
            color: "#FFFFFF"
            size: 15
        }

        CText {
            text: Qt.formatDateTime(ClockService.currentTime, "hh:mm:ss")
            font.pixelSize: 15
            font.family: Style.timeFont
            font.weight: 600
        }
    }

    RowLayout {
        anchors.left: mainTime.left
        anchors.top: mainTime.bottom
        anchors.leftMargin: 4
        anchors.topMargin: -8
        spacing: 4

        SvgIcon {
            source: timeDisplay ? root.iconSource : "modules/clock.svg"
            color: "#FFFFFF"
            size: 15
        }

        CText {
            text: timeDisplay ? root.name : "Clock"
            font.pixelSize: 15
        }

        CText {
            visible: status
            text: "•"
            font.pixelSize: 15
        }

        CText {
            visible: status
            text: status || ""
            font.pixelSize: 15
        }
    }

    Item {
        id: extendedStatusLayout
        anchors.right: mainTime.right
        anchors.top: mainTime.bottom
        anchors.rightMargin: 4
        anchors.topMargin: -8
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height

        Loader {
            sourceComponent: root.extendedStatus
        }
    }
}
