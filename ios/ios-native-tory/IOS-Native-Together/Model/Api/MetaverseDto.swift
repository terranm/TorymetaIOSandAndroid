//
//  MetaverseDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/21.
//

import Foundation

struct ChattingLoungeChattingRoomList: Codable {
    let rooms: [Item]

    struct Item: Codable {
        let clients: Int
        let isRoomLock: Bool
        let isSecret: Bool
        let maxClients: Int
        let creatorName: String
        let roomId: String
        let password: String
        let title: String
        let description: String
        let imageURL: String
        let tableId: String

        init(
            clients: Int,
            isRoomLock: Bool,
            isSecret: Bool,
            maxClients: Int,
            creatorName: String,
            roomId: String,
            password: String,
            title: String,
            description: String,
            imageURL: String,
            tableId: String
        ) {
            self.clients = clients
            self.isRoomLock = isRoomLock
            self.isSecret = isSecret
            self.maxClients = maxClients
            self.creatorName = creatorName
            self.roomId = roomId
            self.password = password
            self.title = title
            self.description = description
            self.imageURL = imageURL
            self.tableId = tableId
        }

        enum CodingKeys: String, CodingKey {
            case clients = "clients"
            case isRoomLock = "locked"
            case isSecret = "privateRoom"
            case maxClients = "maxClients"
            case creatorName = "creatorName"
            case roomId = "roomId"
            case password = "password"
            case title = "title"
            case description = "description"
            case imageURL = "image"
            case tableId = "tableId"
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ChattingLoungeChattingRoomList.Item.CodingKeys>
            = try decoder.container(keyedBy: ChattingLoungeChattingRoomList.Item.CodingKeys.self)
            self.clients
            = try container.decodeIfPresent(Int.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.clients) ?? 0
            self.isRoomLock
            = try container.decodeIfPresent(Bool.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.isRoomLock) ?? false
            self.isSecret
            = try container.decodeIfPresent(Bool.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.isSecret) ?? false
            self.maxClients
            = try container.decodeIfPresent(Int.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.maxClients) ?? 0
            self.creatorName
            = try container.decodeIfPresent(String.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.creatorName) ?? ""
            self.roomId
            = try container.decodeIfPresent(String.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.roomId) ?? ""
            self.password
            = try container.decodeIfPresent(String.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.password) ?? ""
            self.title
            = try container.decodeIfPresent(String.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.title) ?? ""
            self.description
            = try container.decodeIfPresent(String.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.description) ?? ""
            self.imageURL
            = try container.decodeIfPresent(String.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.imageURL) ?? ""
            self.tableId
            = try container.decodeIfPresent(String.self,
                                            forKey: ChattingLoungeChattingRoomList.Item.CodingKeys.tableId) ?? ""
        }
    }
}
