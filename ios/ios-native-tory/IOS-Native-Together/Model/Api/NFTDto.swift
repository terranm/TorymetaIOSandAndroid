//
//  NFTDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/29.
//
import Foundation

/*
 Nft 리스트 아이템 결과
 */
struct OwnerNftResultDto: Codable {
    let nftIdx: String
    let ownerId: String
    let creatorId: String
    let imageURL: String
    private let status: String
    var nftState: NFTState {
        switch status {
        case "normal": return NFTState.NONE
        case "sale": return NFTState.SALE
        case "auction": return NFTState.AUCTION
            /*
             검열 중 인 상태도 있음..
             sale_wait
             action_wait
             */
        default: return NFTState.NONE
        }
    }

    enum NFTState: String {
        case NONE
        case SALE
        case AUCTION
    }

    init() {
        self.nftIdx = ""
        self.ownerId = ""
        self.creatorId = ""
        self.imageURL = ""
        self.status = ""
    }

    init(nftIdx: String,
         ownerId: String,
         creatorId: String,
         imageURL: String,
         status: String) {
        self.nftIdx = nftIdx
        self.ownerId = ownerId
        self.creatorId = creatorId
        self.imageURL = imageURL
        self.status = status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nftIdx = try container.decodeIfPresent(String.self, forKey: .nftIdx) ?? ""
        self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId) ?? ""
        self.creatorId = try container.decodeIfPresent(String.self, forKey: .creatorId) ?? ""
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
    }
}
