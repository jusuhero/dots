import QtQuick
import QtQuick.Layouts
import qs.Widgets
import qs.Commons

ColumnLayout {
    id: root

    // Plugin API (injected by the settings dialog system)
    property var pluginApi: null

    // Local state - track changes before saving
    property real valueMinimumThreshold: pluginApi?.pluginSettings?.minimumThreshold || pluginApi?.manifest?.metadata?.defaultSettings?.minimumThreshold || 10

    spacing: Style.marginM

    Component.onCompleted: {
        Logger.i("Catwalk", "Settings UI loaded");
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS

        NLabel {
            label: pluginApi?.tr("settings.minimumThreshold.label") || "Minimum CPU Threshold"
            description: pluginApi?.tr("settings.minimumThreshold.description") || "CPU usage must be above this percentage for the cat to start running"
        }

        NSlider {
            id: thresholdSlider
            from: 5
            to: 25
            value: root.valueMinimumThreshold
            stepSize: 1
            onValueChanged: {
                root.valueMinimumThreshold = value
            }
        }

        Text {
            text: (pluginApi?.tr("settings.currentThreshold") || "Current threshold: {value}%").replace("{value}", thresholdSlider.value)
            color: Color.mOnSurfaceVariant
            font.pointSize: Style.fontSizeS
        }
    }

    // This function is called by the dialog to save settings
    function saveSettings() {
        if (!pluginApi) {
            Logger.e("Catwalk", "Cannot save settings: pluginApi is null");
            return;
        }

        // Update the plugin settings object
        pluginApi.pluginSettings.minimumThreshold = root.valueMinimumThreshold;

        // Save to disk
        pluginApi.saveSettings();

        Logger.i("Catwalk", "Settings saved successfully");
    }
}