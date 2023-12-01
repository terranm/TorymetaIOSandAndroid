//
//  UnityFunctionName.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/04.
//

import Foundation

enum UnityCallFunctionName: String {
    case switchChattingLounge
    case switchSeminar, switchLobby, switchUniversity, switchFestival
    case switchDeco, switchAvatar

    case initAvatarItems
    case createChattingRoomInfo
    case entranceSecretChattingRoomPassword

    case modalButtonTap
    case selectAvatarItem
    case rotateAvatar
    case zoomInAvatar
    case zoomOutAvatar
    case cameraUpAvatar
    case cameraDownAvatar

    case forcedExitFromChattingRoom
    case delegateHostFromChattingRoom
    case silenceFromChattingRoom
    case warnFromChattingRoom

    case dropOut
    case delegateHost
    case silent
    case warn

    case chattingLoungeInviteListInviteFriend
    case chattingLoungePasswordEntrance
    case chattingListEntrance
    case participantsInviteButtnTap

    case loungeVideoUrl

    case joinByPush
    case disconnectServer

    /*
     case send to unity data
     */
    case passMember

    var key: String {
        switch self {
        case .switchChattingLounge: return "SwitchScene"
        case .switchSeminar, .switchLobby, .switchUniversity, .switchFestival: return "SwitchScene"
        case .switchDeco, .switchAvatar: return "SwitchSceneSimple"

        case .initAvatarItems: return "AvatarInfo"
        case .createChattingRoomInfo: return "ChatCreate"
        case .entranceSecretChattingRoomPassword: return "ChatJoin"

        case .modalButtonTap: return "DoAction"
        case .selectAvatarItem: return "CharacterSet"
        case .rotateAvatar: return "AvatarRotate"
        case .zoomInAvatar: return "ZoomIn"
        case .zoomOutAvatar: return "ZoomOut"
        case .cameraUpAvatar: return "CamUp"
        case .cameraDownAvatar: return "CamDown"

        case .forcedExitFromChattingRoom: return "Kick"
        case .delegateHostFromChattingRoom: return "Mandate"
        case .silenceFromChattingRoom: return "Silence"
        case .warnFromChattingRoom: return "Warning"
        case .dropOut: return "Kick"
        case .delegateHost: return "Mandate"
        case .silent: return "Silence"
        case .warn: return "Warning"
        case .chattingLoungeInviteListInviteFriend: return "ChatInvite"
        case .chattingLoungePasswordEntrance: return "ChatJoin"
        case .chattingListEntrance: return "JoinChat"
        case .participantsInviteButtnTap: return "RequestInvitable"

        case .loungeVideoUrl: return "LoungeVideoUrl"
        case .passMember: return "PassMember"
        case .joinByPush: return "JoinByPush"
        case .disconnectServer: return "DisconnectServer"
        }
    }
}
