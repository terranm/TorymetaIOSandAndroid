//
//  SendToUnity.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/04.
//

import Foundation

struct UnityMessage {
    let gameObjectName: String
    let functionName: String
    let message: String
}

struct UnityEmptyObject: Codable {}

struct SwitchSceneInfo: Codable {
    private static let seminar = "seminar"
    private static let chattingLounge = "lobby"
    private static let lobby = "lobby"
    private static let deco = "SelectView"
    private static let avatarView = "AvatarView"

    private let url: String
    private let roomType: String
    private let roomId: String
    private let roomTitle: String
    private let videoStartTime: String
    private let isAppRelease: Bool
    private let scene: String
    private let tableId: String

    init() {
        self.url = ""
        self.roomType = ""
        self.roomId = ""
        self.roomTitle = ""
        self.videoStartTime = ""
        self.isAppRelease = AppConfigure.isProductRelease
        self.scene = ""
        self.tableId = ""
    }

    private init(url: String,
                 roomType: String,
                 roomId: String,
                 roomTitle: String,
                 videoStartTime: String,
                 isAppRelease: Bool,
                 scene: String,
                 tableId: String) {
        self.url = url
        self.roomType = roomType
        self.roomId = roomId
        self.roomTitle = roomTitle
        self.videoStartTime = videoStartTime
        self.isAppRelease = isAppRelease
        self.scene = scene
        self.tableId = tableId
    }

    func getSeminarData(url: String,
                        roomType: String,
                        roomId: String,
                        roomTitle: String,
                        videoStartTime: String) -> Self {
        SwitchSceneInfo(url: url,
                        roomType: roomType,
                        roomId: roomId,
                        roomTitle: roomTitle,
                        videoStartTime: videoStartTime,
                        isAppRelease: AppConfigure.isProductRelease,
                        scene: SwitchSceneInfo.seminar,
                        tableId: "")
    }

    func getChattingLoungeData(url: String, tableId: String) -> Self {
        SwitchSceneInfo(url: url,
                        roomType: "",
                        roomId: "",
                        roomTitle: "",
                        videoStartTime: "",
                        isAppRelease: AppConfigure.isProductRelease,
                        scene: SwitchSceneInfo.chattingLounge,
                        tableId: tableId)
    }

    func getLobbyData(url: String) -> Self {
        SwitchSceneInfo(url: url,
                        roomType: "",
                        roomId: "",
                        roomTitle: "",
                        videoStartTime: "",
                        isAppRelease: AppConfigure.isProductRelease,
                        scene: SwitchSceneInfo.lobby,
                        tableId: "")
    }

    func getDecoData() -> Self {
        SwitchSceneInfo(url: "",
                        roomType: "",
                        roomId: "",
                        roomTitle: "",
                        videoStartTime: "",
                        isAppRelease: AppConfigure.isProductRelease,
                        scene: SwitchSceneInfo.deco,
                        tableId: "")
    }

    func getAvatarViewData() -> Self {
        SwitchSceneInfo(url: "",
                        roomType: "",
                        roomId: "",
                        roomTitle: "",
                        videoStartTime: "",
                        isAppRelease: AppConfigure.isProductRelease,
                        scene: SwitchSceneInfo.avatarView,
                        tableId: "")
    }

    func getUniversityData(universityCode: String) -> Self {
        SwitchSceneInfo(url: "",
                        roomType: "",
                        roomId: "",
                        roomTitle: "",
                        videoStartTime: "",
                        isAppRelease: AppConfigure.isProductRelease,
                        scene: universityCode,
                        tableId: "")
    }

    func getFestivalData(url: String) -> Self {
        SwitchSceneInfo(url: url,
                        roomType: "festival",
                        roomId: "",
                        roomTitle: "",
                        videoStartTime: "",
                        isAppRelease: AppConfigure.isProductRelease,
                        scene: SwitchSceneInfo.lobby,
                        tableId: "")
    }
}

struct SelectAvatarAttribue: Codable {
    let characterId: String
    let parts: String
    let color: String
}

struct InitAvatarAttribute: Codable {
    let userName: String
    let memberId: Int
    let avatarState: AvatarAttribute
}

struct ChattingRoomOpenInfo: Codable {
    let roomName: String?
    let password: String?
    let isPrivate: Bool
}

struct EntranceSecretChattingRoomPassword: Codable {
    let password: String
}

struct ModalButtonTapActionAttribute: Codable {
    let actionId: String
}

struct ChattingLoungeChattingListEntranceRequest: Codable {
    let tableId: String
}

struct ChattingLoungeInviteListInviteFriendRequest: Codable {
    let memberId: Int
}

struct LoungeVideoUrlInfo: Codable {
    let url: String
}

struct JoinByPush: Codable {
    let tableId: String
}
