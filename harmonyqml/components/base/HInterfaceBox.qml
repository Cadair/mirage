import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.4

HScalingBox {
    id: interfaceBox

    property alias title: interfaceTitle.text
    property alias buttonModel: interfaceButtonsRepeater.model
    property var buttonCallbacks: []
    property string enterButtonTarget: ""

    default property alias body: interfaceBody.children

    function clickEnterButtonTarget() {
        for (var i = 0; i < buttonModel.length; i++) {
            var btn = interfaceButtonsRepeater.itemAt(i)
            if (btn.name === enterButtonTarget) { btn.clicked() }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        id: mainColumn

        HRowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: interfaceBox.margins

            HLabel {
                id: interfaceTitle
                font.pixelSize: HStyle.fontSize.big
            }
        }

        Item { Layout.fillHeight: true }

        ColumnLayout { id: interfaceBody }

        Item { Layout.fillHeight: true }

        HRowLayout {
            Repeater {
                id: interfaceButtonsRepeater
                model: []

                HButton {
                    property string name: modelData.name

                    id: button
                    text: modelData.text
                    iconName: modelData.iconName || ""
                    onClicked: buttonCallbacks[modelData.name](button)

                    Layout.fillWidth: true
                    Layout.preferredHeight: 32
                }
            }
        }
    }
}