import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.4
import "../../Base"

HGlassRectangle {
    id: banner
    Layout.fillWidth: true
    Layout.preferredHeight: 32

    property alias avatarName: bannerAvatar.name
    property alias avatarSource: bannerAvatar.imageSource
    property alias labelText: bannerLabel.text
    property alias buttonModel: bannerRepeater.model
    property var buttonCallbacks: []

    HRowLayout {
        id: bannerRow
        anchors.fill: parent

        HAvatar {
            id: bannerAvatar
            dimension: banner.Layout.preferredHeight
        }

        HLabel {
            id: bannerLabel
            textFormat: Text.StyledText
            maximumLineCount: 1
            elide: Text.ElideRight

            visible:
                bannerRow.width - bannerAvatar.width - bannerButtons.width > 30

            Layout.maximumWidth:
                bannerRow.width -
                bannerAvatar.width - bannerButtons.width -
                Layout.leftMargin - Layout.rightMargin

            Layout.leftMargin: 10
            Layout.rightMargin: Layout.leftMargin
        }

        HSpacer {}

        HRowLayout {
            id: bannerButtons

            function getButtonsWidth() {
                var total = 0

                for (var i = 0; i < bannerRepeater.count; i++) {
                    total += bannerRepeater.itemAt(i).implicitWidth
                }

                return total
            }

            property bool compact:
                bannerRow.width <
                bannerAvatar.width +
                bannerLabel.implicitWidth +
                bannerLabel.Layout.leftMargin +
                bannerLabel.Layout.rightMargin +
                getButtonsWidth()

            Repeater {
                id: bannerRepeater
                model: []

                HButton {
                    id: button
                    text: modelData.text
                    iconName: modelData.iconName
                    onClicked: buttonCallbacks[modelData.name](button)

                    Layout.maximumWidth: bannerButtons.compact ? height : -1
                    Layout.fillHeight: true
                }
            }
        }
    }
}