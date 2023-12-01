//
//  FromUnity.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/04.
//

import Foundation

struct FromUnityShowModal: Codable {
    let title: String
    let description: String
    let buttons: [Item]

    init() {
        self.title = ""
        self.description = ""
        self.buttons = []
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.buttons = try container.decode([FromUnityShowModal.Item].self, forKey: .buttons)
    }

    struct Item: Codable {
        let title: String
        let color: String
        let actionId: String

        init() {
            self.title = ""
            self.color = ""
            self.actionId = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<FromUnityShowModal.Item.CodingKeys>
            = try decoder.container(keyedBy: FromUnityShowModal.Item.CodingKeys.self)
            self.title = try container.decodeIfPresent(String.self,
                                                       forKey: FromUnityShowModal.Item.CodingKeys.title) ?? ""
            self.color = try container.decodeIfPresent(String.self,
                                                       forKey: FromUnityShowModal.Item.CodingKeys.color) ?? ""
            self.actionId = try container.decodeIfPresent(String.self,
                                                          forKey:
                                                            FromUnityShowModal.Item.CodingKeys.actionId) ?? ""
        }
    }
}

struct FromUnityFormCall<T: Codable>: Codable {
    typealias FunctionName = String
    typealias JsonObject = T
    let form: FunctionName?
    let option: JsonObject
}

struct FromUnityChattingList: Codable {

}

struct FromUnityChattingLoungePassword: Codable {
    let password: String?
}
struct FromUnityParticipantsInformation: Codable {
    let roomId: String?
    let tableId: String?
    let maxClient: Int?
    let chatRoomId: Int?
    let list: [Item]

    struct Item: Codable {
        let memberId: Int
        var status: ChattingLoungeParticipantsItemStatus {
            memberId != 0 ? .exist : .request
        }
        let profileName: String
        let phoneNum: String
        let imgUrl: String
        let roomMaker: Bool
        var isOwner: Bool {
            roomMaker
        }

        init() {
            self.memberId = 0
            self.profileName = ""
            self.phoneNum = ""
            self.imgUrl = ""
            self.roomMaker = false
        }

        init(
            memberId: Int,
            profileName: String,
            phoneNum: String,
            imgUrl: String,
            roomMaker: Bool
        ) {
            self.memberId = memberId
            self.profileName = profileName
            self.phoneNum = phoneNum
            self.imgUrl = imgUrl
            self.roomMaker = roomMaker
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<FromUnityParticipantsInformation.Item.CodingKeys>
            = try decoder.container(keyedBy: FromUnityParticipantsInformation.Item.CodingKeys.self)
            self.memberId
            = try container.decodeIfPresent(Int.self,
                                            forKey: FromUnityParticipantsInformation.Item.CodingKeys.memberId) ?? 0
            self.profileName
            = try container.decodeIfPresent(String.self,
                                            forKey: FromUnityParticipantsInformation.Item.CodingKeys.profileName) ?? ""
            self.phoneNum
            = try container.decodeIfPresent(String.self,
                                            forKey: FromUnityParticipantsInformation.Item.CodingKeys.phoneNum) ?? ""
            self.imgUrl
            = try container.decodeIfPresent(String.self,
                                            forKey: FromUnityParticipantsInformation.Item.CodingKeys.imgUrl) ?? ""
            self.roomMaker
            = try container.decodeIfPresent(Bool.self,
                                            forKey: FromUnityParticipantsInformation.Item.CodingKeys.roomMaker) ?? false
        }
    }
}

struct FromUnityInviteList: Codable {
    let list: [Item]

    struct Item: Codable {
        let memberId: Int
        let profileName: String
        private let phoneNum: String
        let imgUrl: String
        private let roomMaker: Bool
        init(memberId: Int, profileName: String, phoneNum: String, imgUrl: String, roomMaker: Bool) {
            self.memberId = memberId
            self.profileName = profileName
            self.phoneNum = phoneNum
            self.imgUrl = imgUrl
            self.roomMaker = roomMaker
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<FromUnityInviteList.Item.CodingKeys>
            = try decoder.container(keyedBy: FromUnityInviteList.Item.CodingKeys.self)
            self.memberId
            = try container.decodeIfPresent(Int.self,
                                            forKey: FromUnityInviteList.Item.CodingKeys.memberId) ?? 0
            self.profileName
            = try container.decodeIfPresent(String.self,
                                            forKey: FromUnityInviteList.Item.CodingKeys.profileName) ?? ""
            self.phoneNum
            = try container.decodeIfPresent(String.self,
                                            forKey: FromUnityInviteList.Item.CodingKeys.phoneNum) ?? ""
            self.imgUrl
            = try container.decodeIfPresent(String.self,
                                            forKey: FromUnityInviteList.Item.CodingKeys.imgUrl) ?? ""
            self.roomMaker
            = try container.decodeIfPresent(Bool.self,
                                            forKey: FromUnityInviteList.Item.CodingKeys.roomMaker) ?? false
        }
    }
}

struct FromUnityUserInteractionInformation: Codable {
    let isOwner: Bool?
    let memberId: String?
    var memberIdInt: Int {
        Int(memberId ?? "0") ?? 0
    }

    enum CodingKeys: String, CodingKey {
        case isOwner = "roomMaker"
        case memberId = "memberId"
    }
}
