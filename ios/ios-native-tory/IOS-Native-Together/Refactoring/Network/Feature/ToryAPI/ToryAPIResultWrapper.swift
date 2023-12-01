//
//  RiotWrapper.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

struct ToryAPIResultWrapper<Data: Codable>: APIWrapperProtocol {
    typealias Data = Data
    var resultCode: String?
    var resultMessage: String?
    var result: Data?
}
