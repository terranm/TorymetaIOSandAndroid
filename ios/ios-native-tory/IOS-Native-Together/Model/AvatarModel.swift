//
//  AvatarModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/26.
//

import Foundation

// MARK: - Avatar Attribute
struct AvatarAttribute: Codable {
    var skinCode: String
    var skinColorCode: String
    var hairCode: String
    var hairColorCode: String
    var faceCode: String
    var faceColorCode: String
    var topCode: String
    var topColorCode: String
    var bottomCode: String
    var bottomColorCode: String
    var shoesCode: String
    var shoesColorCode: String
    var bodyCode: String

    init() {
        skinCode = ""
        skinColorCode = ""
        hairCode = ""
        hairColorCode = ""
        faceCode = ""
        faceColorCode = ""
        topCode = ""
        topColorCode = ""
        bottomCode = ""
        bottomColorCode = ""
        shoesCode = ""
        shoesColorCode = ""
        bodyCode = ""
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<AvatarAttribute.CodingKeys> = try decoder
            .container(keyedBy: AvatarAttribute.CodingKeys.self)
        skinCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.skinCode) ?? ""
        skinColorCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.skinColorCode) ?? ""
        hairCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.hairCode) ?? ""
        hairColorCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.hairColorCode) ?? ""
        faceCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.faceCode) ?? ""
        faceColorCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.faceColorCode) ?? ""
        topCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.topCode) ?? ""
        topColorCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.topColorCode) ?? ""
        bottomCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.bottomCode) ?? ""
        bottomColorCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.bottomColorCode) ?? ""
        shoesCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.shoesCode) ?? ""
        shoesColorCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.shoesColorCode) ?? ""
        bodyCode = try container
            .decodeIfPresent(String.self, forKey: AvatarAttribute.CodingKeys.skinColorCode) ?? ""
    }
}

// MARK: - Avatar Category List
struct AvatarCategoryList: Codable {
    let avatarCategoryList: [String]
}

// MARK: - Avatar Item List
struct AvatarModelingList: Codable {
    let avatarModelingList: [AvatarModeling]
}

struct AvatarModeling: Codable {
    let id: Int
    let modelingCode: String
    let imgURL: String
    let group: String
    var basicItem: Bool
    let pointCD, price: Int
    let isOwned: Bool
    let payCount: Int
    enum CodingKeys: String, CodingKey {
        case id
        case modelingCode
        case imgURL = "imgUrl"
        case group
        case basicItem
        case pointCD = "pointCd"
        case price
        case isOwned
        case payCount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.modelingCode = try container.decode(String.self, forKey: .modelingCode)
        self.imgURL = try container.decode(String.self, forKey: .imgURL)
        self.group = try container.decode(String.self, forKey: .group)
        self.basicItem = try Bool(truncating: container.decode(Int.self, forKey: .basicItem) as NSNumber)
        self.pointCD = try container.decode(Int.self, forKey: .pointCD)
        self.price = try container.decode(Int.self, forKey: .price)
        self.isOwned = try Bool(truncating: container.decode(Int.self, forKey: .isOwned) as NSNumber)
        self.payCount = try container.decode(Int.self, forKey: .payCount)
    }
}

// MARK: - Avatar Color List
struct AvatarColorList: Codable {
    let avatarColorList: [AvatarColor]
}

// MARK: - Avatar Color List
struct AvatarColor: Codable {
    let id: Int
    let colorCode, group: String
}
