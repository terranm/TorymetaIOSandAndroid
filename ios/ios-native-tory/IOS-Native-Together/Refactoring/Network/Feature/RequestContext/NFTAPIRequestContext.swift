//
//  NFTAPIRequestContext.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/10.
//

import Foundation
import Alamofire

struct NFTAPIRequestContext: APIRequestContextProtocol {
    static var baseURL: String {
        AppConfigure.isProductRelease ? "https://nft-api.bevarrico.com" : "https://test-nft-api.bevarrico.com"
    }

    var serverName: String { "NFT Server" }

    var resultCode: String? { "2001" }

    var requestURL: String

    var params: [String: Any] = [:]

    var multipartFormDatas: [MultiPartForm] = []

    var requestUIMode: APIRequestUIMode

    var resultUIMode: APIResultUIMode

    var headers: HTTPHeaders

    init(path: String,
         params: [String: Any],
         requestUIMode: APIRequestUIMode,
         resultUIMode: APIResultUIMode,
         headers: HTTPHeaders = ["Content-Type": "application/json",
                                 "Authorization": "\(WDUserDefaultManager.shared.token ?? "")"]) {
        self.requestURL = "\(NFTAPIRequestContext.baseURL)/v1/db/MATIC\(path)"
        self.params = params
        self.requestUIMode = requestUIMode
        self.resultUIMode = resultUIMode
        self.headers = headers
    }

    init(path: String,
         multipartFormDatas: [MultiPartForm],
         requestUIMode: APIRequestUIMode,
         resultUIMode: APIResultUIMode,
         headers: HTTPHeaders = ["Content-Type": "multipart/form-data",
                                 "Authorization": "Bearer \(WDUserDefaultManager.shared.token ?? "")"]) {
        self.requestURL = "\(NFTAPIRequestContext.baseURL)/v1/db/MATIC\(path)"
        self.multipartFormDatas = multipartFormDatas
        self.requestUIMode = requestUIMode
        self.resultUIMode = resultUIMode
        self.headers = headers
    }
}
