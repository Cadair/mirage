import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.4
import "../Base"
import "Banners"
import "RoomEventList"

HColumnLayout {
    property string userId: ""
    property string roomId: ""

    readonly property var roomInfo:
        Backend.models.rooms.get(userId).getWhere("roomId", roomId)

    property bool canLoadPastEvents: true

    Component.onCompleted: console.log("replaced")

    id: chatPage
    onFocusChanged: sendBox.setFocus()

    RoomHeader {
        displayName: roomInfo.displayName
        topic: roomInfo.topic
    }

    RoomEventList {}

    TypingUsersBar {}

    InviteBanner {
        visible: roomInfo.category === "Invites"
        inviter: roomInfo.inviter
    }

    SendBox {
        id: sendBox
        visible: roomInfo.category === "Rooms"
    }

    LeftBanner {
        visible: roomInfo.category === "Left"
        leftEvent: roomInfo.leftEvent
    }
}