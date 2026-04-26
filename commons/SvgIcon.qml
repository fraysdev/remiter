import QtQuick
import QtQuick.VectorImage
import Qt5Compat.GraphicalEffects

Item {
    id: svgIcon
    property string source: ""
    property int size: 20
    property color color: "#FFFFFF"

    implicitWidth: size
    implicitHeight: size
    visible: source !== ""

    VectorImage {
        id: icon
        source: `qrc:/qt/qml/remiter/assets/icons/${svgIcon.source}`
        anchors.centerIn: parent
        width: svgIcon.size
        height: svgIcon.size
        fillMode: VectorImage.PreserveAspectFit
        preferredRendererType: VectorImage.CurveRenderer
        visible: false
    }

    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: svgIcon.color
    }
}