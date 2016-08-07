import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root

    width: Theme.fontSizeHuge * 1.3
    height: Theme.fontSizeHuge * 2

    property int value: numerator.model[numerator.currentIndex]

    PathView {
        id: numerator

        x: (-width / 2)
        y: 0
        width: Screen.width - Theme.paddingLarge
        height: Theme.fontSizeHuge

        pathItemCount: 5
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange

        model: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,1]

        delegate: Loader {
            id: loader

            sourceComponent: meterText
            property int _halignment: Text.AlignRight
            property double _opacity: PathView.isCurrentItem ? 1 : 0
            property string _text: modelData

            states: [
                State {
                    name: "interactive"
                    when: loader.PathView.view.moving
                    PropertyChanges {
                        target: loader
                        _opacity: loader.PathView.textOpacity
                    }
                }
            ]

            transitions: [
                Transition {
                    from: ""
                    to: "interactive"
                    reversible: true
                    PropertyAnimation {
                        target: loader
                        property: "_opacity"
                        duration: 200
                    }
                }
            ]
        }

        path: Path {
            startX: 0
            startY: numerator.height / 2
            PathAttribute { name: "textOpacity"; value: 0 }

            PathLine { x: (numerator.width / 3) + 10; y: numerator.height / 2 }
            PathAttribute { name: "textOpacity"; value: 1 }
            PathPercent { value: 0.4}

            PathLine { x: ((numerator.width / 3) * 2) - 10; y: numerator.height / 2 }
            PathAttribute { name: "textOpacity"; value: 1 }
            PathPercent { value: 0.6}

            PathLine { x: numerator.width; y: numerator.height / 2 }
            PathAttribute { name: "textOpacity"; value: 0 }
            PathPercent { value: 1}
        }
    }

    Rectangle {
        id: slash
        rotation: - 50
        anchors.centerIn: parent
        transformOrigin: Item.Center
        width: root.width
        height: 3
        color: Theme.secondaryColor
    }

    PathView {
        id: denumerator

        x: (root.width) - (width / 2)
        y: root.height - Theme.fontSizeHuge
        width: Screen.width - Theme.paddingLarge
        height: Theme.fontSizeHuge

        pathItemCount: 5
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        model: [4,8,16,32,1,2]
        delegate: Loader {
            id: loader2
            sourceComponent: meterText
            property int _halignment: Text.AlignLeft
            property double _opacity: PathView.isCurrentItem ? 1 : 0
            property string _text: modelData

            states: [
                State {
                    name: "interactive"
                    when: loader2.PathView.view.moving
                    PropertyChanges {
                        target: loader2
                        _opacity: loader2.PathView.textOpacity
                    }
                }
            ]

            transitions: [
                Transition {
                    from: ""
                    to: "interactive"
                    reversible: true
                    PropertyAnimation {
                        target: loader2
                        property: "_opacity"
                        duration: 200
                    }
                }
            ]
        }

        path: Path {
            startX: 0
            startY: denumerator.height / 2
            PathAttribute { name: "textOpacity"; value: 0 }

            PathLine { x: (denumerator.width / 3) + 10; y: denumerator.height / 2 }
            PathAttribute { name: "textOpacity"; value: 1 }
            PathPercent { value: 0.4}

            PathLine { x: ((denumerator.width / 3) * 2) - 10; y: denumerator.height / 2 }
            PathAttribute { name: "textOpacity"; value: 1 }
            PathPercent { value: 0.6}

            PathLine { x: denumerator.width; y: denumerator.height / 2 }
            PathAttribute { name: "textOpacity"; value: 0 }
            PathPercent { value: 1}
        }
    }

    Component {
        id: meterText
        Text {
            width: Theme.fontSizeHuge * 1.5
            height: width * 1.5
            font.pixelSize: Theme.fontSizeHuge
            text: _text
            color: Theme.primaryColor
            horizontalAlignment: _halignment
            verticalAlignment: Text.AlignVCenter
            opacity: _opacity
        }
    }
}

