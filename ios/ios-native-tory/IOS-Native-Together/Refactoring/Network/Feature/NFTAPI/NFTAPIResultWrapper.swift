//
//  NFTAPIResultWrapper.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/10.
//

import Foundation

struct NFTAPIResultWrapper<Data: Codable>: APIWrapperProtocol {
    typealias Data = Data
    var resultCode: String?
    var resultMessage: String?
    var result: Data?

    enum CodingKeys: String, CodingKey {
        case resultCode = "code"
        case resultMessage = "message"
        case result = "data"
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<NFTAPIResultWrapper<Data>.CodingKeys>
        = try decoder.container(keyedBy: NFTAPIResultWrapper<Data>.CodingKeys.self)
        if let intCode = try? container.decodeIfPresent(Int.self, forKey: .resultCode) {
            resultCode = String(intCode)
        } else {
            resultCode = try container.decodeIfPresent(String.self, forKey: .resultCode)
        }
        self.resultMessage = try container.decodeIfPresent(String.self,
                                                           forKey: NFTAPIResultWrapper<Data>.CodingKeys.resultMessage)
        self.result = try container.decodeIfPresent(Data.self, forKey: NFTAPIResultWrapper<Data>.CodingKeys.result)
    }
}
