//
//  MetaverseRequestContext.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/10.
//

import Foundation
import Alamofire

struct MetaverseRequestContext: APIRequestContextProtocol {
    static var baseURL: String {
        AppConfigure.isProductRelease ? "https://metaverse.torymeta.com" : "https://test-metaverse.torymeta.com"
    }
    private var serverVersion = "metabus-v4"

    var serverName: String { "Metaverse Server" }

    var resultCode: String? { "0000" }

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
        self.requestURL = "\(MetaverseRequestContext.baseURL)/\(serverVersion)\(path)"
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
        self.requestURL = "\(MetaverseRequestContext.baseURL)/\(serverVersion)\(path)"
        self.multipartFormDatas = multipartFormDatas
        self.requestUIMode = requestUIMode
        self.resultUIMode = resultUIMode
        self.headers = headers
    }

}
