import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs.Commons
import qs.Services.System
import qs.Widgets

Item {
    id: root
    property var pluginApi: null

    // SmartPanel properties
    readonly property var geometryPlaceholder: panelContainer
    readonly property bool allowAttach: true
    property real contentPreferredWidth: 300 * Style.uiScaleRatio
    property real contentPreferredHeight: 300 * Style.uiScaleRatio

    anchors.fill: parent

    Rectangle {
        id: panelContainer
        anchors.fill: parent
        color: Color.transparent

        Rectangle {
            anchors.fill: parent
            anchors.margins: Style.marginL
            color: Color.mSurface
            radius: Style.radiusL
            border.color: Color.mOutline
            border.width: Style.borderS

            ColumnLayout {
                anchors.centerIn: parent
                spacing: Style.marginL

                // Big Cat
                Item {
                    id: bigCatItem
                    Layout.preferredWidth: 128 * Style.uiScaleRatio
                    Layout.preferredHeight: 128 * Style.uiScaleRatio
                    Layout.alignment: Qt.AlignHCenter

                    property int frameIndex: 0
                    property bool isRunning: true 
                    
                    readonly property var icons: [
                        "icons/my-active-0-symbolic.svg",
                        "icons/my-active-1-symbolic.svg",
                        "icons/my-active-2-symbolic.svg",
                        "icons/my-active-3-symbolic.svg",
                        "icons/my-active-4-symbolic.svg"
                    ]
                    
                    property int idleFrameIndex: 0
                    readonly property var idleIcons: [
                        "icons/my-idle-0-symbolic.svg",
                        "icons/my-idle-1-symbolic.svg",
                        "icons/my-idle-2-symbolic.svg",
                        "icons/my-idle-3-symbolic.svg"
                    ]

                    Timer {
                        interval: Math.max(30, 200 - SystemStatService.cpuUsage * 1.7)
                        running: bigCatItem.isRunning && SystemStatService.cpuUsage >= (root.pluginApi?.pluginSettings?.minimumThreshold || 10)
                        repeat: true
                        onTriggered: bigCatItem.frameIndex = (bigCatItem.frameIndex + 1) % bigCatItem.icons.length
                    }
                    
                    Timer {
                        interval: 400
                        running: bigCatItem.isRunning && SystemStatService.cpuUsage < (root.pluginApi?.pluginSettings?.minimumThreshold || 10)
                        repeat: true
                        onTriggered: bigCatItem.idleFrameIndex = (bigCatItem.idleFrameIndex + 1) % bigCatItem.idleIcons.length
                    }

                    Image {
                        id: bigCatImage
                        anchors.fill: parent
                        
                        source: (bigCatItem.isRunning && SystemStatService.cpuUsage >= (root.pluginApi?.pluginSettings?.minimumThreshold || 10)) 
                                ? Qt.resolvedUrl(bigCatItem.icons[bigCatItem.frameIndex]) 
                                : Qt.resolvedUrl(bigCatItem.idleIcons[bigCatItem.idleFrameIndex])
                        
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                        mipmap: true

                        // This handles the programmatic coloring
                        layer.enabled: true
                        layer.effect: MultiEffect {
                            colorization: 1.0
                            colorizationColor: Settings.data.colorSchemes.darkMode ? "white" : "black"
                        }
                    }
                }

                // CPU Stats
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: (pluginApi?.tr("panel.cpuLabel") || "CPU: {usage}%").replace("{usage}", Math.round(SystemStatService.cpuUsage))
                    font.pointSize: Style.fontSizeXL
                    font.weight: Font.Bold
                    color: Settings.data.colorSchemes.darkMode ? "white" : "black"
                }
            }
        }
    }
}