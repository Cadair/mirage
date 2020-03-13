// SPDX-License-Identifier: LGPL-3.0-or-later

import QtQuick 2.12

HAvatar {
    name: displayName || userId.substring(1)  // no leading @
    title: "user_" + userId + ".avatar"


    property string userId
    property string displayName
    property int powerLevel: 0
    property bool shiftMembershipIconPosition: true
    property bool invited: false

    readonly property bool admin: powerLevel >= 100
    readonly property bool moderator: powerLevel >= 50 && ! admin


    HLoader {
        active: admin || moderator || invited
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: shiftMembershipIconPosition ? -16 / 2 : 0
        anchors.leftMargin: anchors.topMargin
        z: 100

        Behavior on anchors.topMargin { HNumberAnimation {} }

        sourceComponent: HIcon {
            small: true
            svgName:
                invited ? "user-invited" :
                admin ? "user-power-100" :
                "user-power-50"

            colorize:
                invited ? theme.chat.roomPane.listView.member.invitedIcon :
                admin ? theme.chat.roomPane.listView.member.adminIcon :
                theme.chat.roomPane.listView.member.moderatorIcon

            HoverHandler { id: membershipIcon }

            HToolTip {
                visible: membershipIcon.hovered
                text:
                    invited ? qsTr("Invited") :
                    admin ? qsTr("Admin (%1 power)").arg(powerLevel) :
                    qsTr("Moderator (%1 power)").arg(powerLevel)
            }
        }
    }

}
