//
//  BridgeResultDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/03/16.
//

import Foundation

struct NavigationBarControlBridgeResultDto: Codable {
    let isHide: Bool

    init() {
        self.isHide = false
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isHide = try container.decodeIfPresent(Bool.self, forKey: .isHide) ?? false
    }
}

struct ShowBottomModalBridgeResultDto: Codable {
    let actions: [Item]

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
            let container: KeyedDecodingContainer<ShowBottomModalBridgeResultDto.Item.CodingKeys>
                = try decoder.container(keyedBy: ShowBottomModalBridgeResultDto.Item.CodingKeys.self)
            self.title = try container
                .decodeIfPresent(String.self, forKey: ShowBottomModalBridgeResultDto.Item.CodingKeys.title) ?? ""
            self.color = try container
                .decodeIfPresent(String.self, forKey: ShowBottomModalBridgeResultDto.Item.CodingKeys.color) ?? ""
            self.actionId = try container
                .decodeIfPresent(String.self, forKey: ShowBottomModalBridgeResultDto.Item.CodingKeys.actionId) ?? ""
        }
    }
}

struct ShowModalBridgeResultDto: Codable {
    let title: String
    let description: String
    let actions: [Item]

    init() {
        self.title = ""
        self.description = ""
        self.actions = []
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.actions = try container.decode([ShowModalBridgeResultDto.Item].self, forKey: .actions)
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
            let container: KeyedDecodingContainer<ShowModalBridgeResultDto.Item.CodingKeys>
                = try decoder.container(keyedBy: ShowModalBridgeResultDto.Item.CodingKeys.self)
            self.title = try container
                .decodeIfPresent(String.self, forKey: ShowModalBridgeResultDto.Item.CodingKeys.title) ?? ""
            self.color = try container
                .decodeIfPresent(String.self, forKey: ShowModalBridgeResultDto.Item.CodingKeys.color) ?? ""
            self.actionId = try container
                .decodeIfPresent(String.self, forKey: ShowModalBridgeResultDto.Item.CodingKeys.actionId) ?? ""
        }
    }
}

struct ShowToastBridgeResultDto: Codable {
    let message: String
    let fontColor: String
    let backgroundColor: String

    init() {
        self.message = ""
        self.fontColor = ""
        self.backgroundColor = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        self.fontColor = try container.decodeIfPresent(String.self, forKey: .fontColor) ?? ""
        self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor) ?? ""
    }

}

struct LoginBridgeResultDto: Codable {
    let token: String
    let isAutoLogin: Bool
    let universityCode: String

    init() {
        self.token = ""
        self.isAutoLogin = false
        self.universityCode = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
        self.isAutoLogin = try container.decodeIfPresent(Bool.self, forKey: .isAutoLogin) ?? false
        self.universityCode = try container.decodeIfPresent(String.self, forKey: .universityCode) ?? ""
    }
}

struct CanChattingBridgeResultDto: Codable {
    let chid: Int
    let memberId: Int
    let nickName: String
    let profile: String

    init() {
        self.chid = 0
        self.memberId = 0
        self.nickName = ""
        self.profile = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.chid = try container.decodeIfPresent(Int.self, forKey: .chid) ?? 0
        self.memberId = try container.decodeIfPresent(Int.self, forKey: .memberId) ?? 0
        self.nickName = try container.decodeIfPresent(String.self, forKey: .nickName) ?? ""
        self.profile = try container.decodeIfPresent(String.self, forKey: .profile) ?? ""
    }
}

/*
 comfire_certUniYn
 */
struct SelectUniversityBridgeResultDto: Codable {

    let isModify: String

    init() {
        self.isModify = "false"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isModify = try container.decodeIfPresent(String.self, forKey: .isModify) ?? "false"
    }
}

/*
 NFT : save BC_TOKEN
 */
struct SaveBcTokenBridgeResultDto: Codable {
    let key: String
    let data: Value

    init() {
        self.key = ""
        self.data = Value()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
        self.data = try container.decodeIfPresent(SaveBcTokenBridgeResultDto.Value.self, forKey: .data) ?? Value()
    }

    struct Value: Codable {
        let bcToken: String

        init() {
            self.bcToken = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<SaveBcTokenBridgeResultDto.Value.CodingKeys>
                = try decoder.container(keyedBy: SaveBcTokenBridgeResultDto.Value.CodingKeys.self)
            self.bcToken = try container
                .decodeIfPresent(String.self, forKey: SaveBcTokenBridgeResultDto.Value.CodingKeys.bcToken) ?? ""
        }
    }
}

/*
 NFT : save IntroPageId
 */
struct VisibleSetGuidePageBridgeResultDto: Codable {
    let key: String
    let data: Value

    init() {
        self.key = ""
        self.data = Value()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
        self.data = try container
            .decodeIfPresent(VisibleSetGuidePageBridgeResultDto.Value.self, forKey: .data) ?? Value()
    }

    struct Value: Codable {
        let pageId: String

        init() {
            self.pageId = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<VisibleSetGuidePageBridgeResultDto.Value.CodingKeys>
                = try decoder.container(keyedBy: VisibleSetGuidePageBridgeResultDto.Value.CodingKeys.self)
            self.pageId = try container
                .decodeIfPresent(String.self, forKey: VisibleSetGuidePageBridgeResultDto.Value.CodingKeys.pageId) ?? ""
        }
    }
}
