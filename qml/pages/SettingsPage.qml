import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: root

    SilicaFlickable {
        anchors.fill: parent

        PageHeader {
            id: header
            title: qsTr("Settings")
        }

        Column {
            width: parent.width - (Theme.paddingLarge * 2)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: header.bottom
            spacing: Theme.paddingMedium

            // Tempo
            Label {
                height: font.pixelSize + Theme.paddingLarge
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.secondaryHighlightColor
                text: qsTr("Tempo")
            }

            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                TextField {
                    id: tempoFrom
                    placeholderText: qsTr("From")
                    label: placeholderText
                    inputMethodHints: Qt.ImhDigitsOnly
                    width: (parent.width / 2) - Theme.paddingSmall
                    text: storage.getValue("tempo/from") == null ? "" : storage.getValue("tempo/from")
                    onTextChanged: storage.setValue("tempo/from", text)
                }

                TextField {
                    placeholderText: qsTr("To")
                    label: placeholderText
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator { bottom: tempoFrom.text != "" ? tempoFrom.text : 0 }
                    width: (parent.width / 2) - Theme.paddingSmall
                    text: storage.getValue("tempo/to") == null ? "" : storage.getValue("tempo/to")
                    onTextChanged: storage.setValue("tempo/to", text)
                }
            }

            Slider {
                width: parent.width
                minimumValue: 1
                maximumValue: 50
                stepSize: 1
                valueText: qsTr("Step size: %1").arg(value)
                value: storage.getValue("tempo/step") == null ? 10 : storage.getValue("tempo/step")
                onValueChanged: storage.setValue("tempo/step", value)
            }
        }
    }
}
