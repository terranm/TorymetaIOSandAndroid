//
//  APIWrapperProtocol.swift
//  nextStep
//
//  Created by 도학태 on 2023/09/09.
//

import Foundation

protocol APIWrapperProtocol: Codable {
    associatedtype Data
    var resultCode: String? {get set}
    var resultMessage: String? {get set}
    var result: Data? {get set}
}
