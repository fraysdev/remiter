import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.VectorImage

Button {
    id: control

    // property item icon
    property string iconSource: ""
    property int iconSize: 18

    background: Rectangle {
        color: "transparent"
        radius: 5
    }

    contentItem: RowLayout {
        spacing: 2

        SvgIcon {
            source: control.iconSource
            size: control.iconSize
            color: control.down ? "#C0FFFFFF" : "#FFFFFF"
        }

        CText {
            text: control.text
            color: control.down ? "#C0FFFFFF" : "#FFFFFF"
            visible: control.text
            font.family: Style.textFont
        }
    }
}
