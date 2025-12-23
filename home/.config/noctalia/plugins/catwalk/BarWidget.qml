import QtQuick
import QtQuick.Effects
import Quickshell
import qs.Commons
import qs.Modules.Bar.Extras
import qs.Services.UI
import qs.Widgets
import qs.Services.System

Rectangle {
    id: root

    property real baseSize: Style.capsuleHeight
    property bool applyUiScale: false

    property url currentIconSource

    property string tooltipText
    property string tooltipDirection: BarService.getTooltipDirection()
    property string density: Settings.data.bar.density
    property bool enabled: true
    property bool allowClickWhenDisabled: false
    property bool hovering: false

    property color colorBg: Color.mSurfaceVariant
    property color colorFg: Color.mPrimary
    property color colorBgHover: Color.mHover
    property color colorFgHover: Color.mOnHover
    property color colorBorder: Color.mOutline
    property color colorBorderHover: Color.mOutline
    property real customRadius: Style.radiusL

    signal entered
    signal exited
    signal clicked
    signal rightClicked
    signal middleClicked
    signal wheel(int angleDelta)

    implicitWidth: applyUiScale ? Math.round(baseSize * Style.uiScaleRatio) : Math.round(baseSize)
    implicitHeight: applyUiScale ? Math.round(baseSize * Style.uiScaleRatio) : Math.round(baseSize)

    opacity: root.enabled ? Style.opacityFull : Style.opacityMedium
    color: "transparent"
    radius: Math.min((customRadius >= 0 ? customRadius : Style.iRadiusL), width / 2)
    border.color: "transparent"
    border.width: 0

    Behavior on color {
        ColorAnimation {
            duration: Style.animationNormal
            easing.type: Easing.InOutQuad
        }
    }

    // --- Catwalk Specific Logic ---
    property var pluginApi: null
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""

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

    property real cpuUsage: SystemStatService.cpuUsage

    Timer {
        interval: Math.max(30, 200 - root.cpuUsage * 1.7)
        running: root.isRunning && root.cpuUsage >= (pluginApi?.pluginSettings?.minimumThreshold || 10)
        repeat: true
        onTriggered: {
            root.frameIndex = (root.frameIndex + 1) % root.icons.length
        }
    }
    
    Timer {
        interval: 400
        running: root.isRunning && root.cpuUsage < (pluginApi?.pluginSettings?.minimumThreshold || 10)
        repeat: true
        onTriggered: {
            root.idleFrameIndex = (root.idleFrameIndex + 1) % root.idleIcons.length
        }
    }

    currentIconSource: (root.isRunning && root.cpuUsage >= (pluginApi?.pluginSettings?.minimumThreshold || 10)) 
                       ? Qt.resolvedUrl(root.icons[root.frameIndex]) 
                       : Qt.resolvedUrl(root.idleIcons[root.idleFrameIndex])

    tooltipText: {
        if (!pluginApi) return "No API";
        var threshold = pluginApi?.pluginSettings?.minimumThreshold || 10;
        var actuallyRunning = root.isRunning && root.cpuUsage >= threshold;
        return actuallyRunning ? (pluginApi.tr("tooltip.running") || "Running") : (pluginApi.tr("tooltip.sleeping") || "Sleeping");
    }
    
    Image {
        id: iconImage
        source: root.currentIconSource
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -3
        anchors.verticalCenterOffset: -1
        
        width: {
            switch (root.density) {
            case "compact":
                return Math.max(1, root.width * 0.85);
            default:
                return Math.max(1, root.width * 0.85);
            }
        }
        height: width
        
        // Ensures the SVG renders sharply at any size
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true 

        // This enables the "mask" behavior to recolor the icon
        layer.enabled: true
        layer.effect: MultiEffect {
            colorization: 1.0
            colorizationColor: Settings.data.colorSchemes.darkMode ? "white" : "black"
        }
    }
    

    MouseArea {
        enabled: true
        anchors.fill: parent
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        hoverEnabled: true
        onEntered: {
            root.hovering = root.enabled ? true : false;
            if (root.tooltipText) {
                TooltipService.show(parent, root.tooltipText, root.tooltipDirection);
            }
            root.entered();
        }
        onExited: {
            root.hovering = false;
            if (root.tooltipText) {
                TooltipService.hide();
            }
            root.exited();
        }
        onClicked: function (mouse) {
            if (root.tooltipText) {
                TooltipService.hide();
            }
            
            Logger.i("Catwalk", "Clicked! API:", !!pluginApi, "Screen:", root.screen ? root.screen.name : "null");

            // Open Panel on click
            if (pluginApi) {
                var result = pluginApi.openPanel(root.screen);
                Logger.i("Catwalk", "OpenPanel result:", result);
            } else {
                Logger.e("Catwalk", "PluginAPI is null");
            }
            
            if (!root.enabled && !root.allowClickWhenDisabled) {
                return;
            }
            if (mouse.button === Qt.LeftButton) {
                root.clicked();
            } else if (mouse.button === Qt.RightButton) {
                root.rightClicked();
            } else if (mouse.button === Qt.MiddleButton) {
                root.middleClicked();
            }
        }
        onWheel: wheel => root.wheel(wheel.angleDelta.y)
    }
}
