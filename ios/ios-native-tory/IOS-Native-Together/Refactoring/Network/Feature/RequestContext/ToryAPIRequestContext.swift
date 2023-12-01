//
//  ToryAPIRequestContext.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/06.
//

import Foundation
import Alamofire

struct ToryAPIRequestContext: APIRequestContextProtocol {
    enum ToryAPIServerDomain: String {
        case primitive
        case member = "member"
        case map = "map"
        case board = "bbs"
    }
    static var baseURL: String {
        AppConfigure.isProductRelease ? "https://api.torymeta.com" : "https://test-api.torymeta.com"
    }
    var serverName: String { "Tory API Server" }
    var resultCode: String? { "0000" }
    var requestURL: String
    var params: [String: Any] = [:]
    var multipartFormDatas: [MultiPartForm] = []
    var requestUIMode: APIRequestUIMode
    var resultUIMode: APIResultUIMode
    var headers: HTTPHeaders

    init(domain: ToryAPIServerDomain,
         path: String,
         params: [String: Any],
         requestUIMode: APIRequestUIMode,
         resultUIMode: APIResultUIMode,
         headers: HTTPHeaders = ["Content-Type": "application/json",
                                 "Authorization": "\(WDUserDefaultManager.shared.token ?? "")"]) {
        switch domain {
        case .primitive: self.requestURL = "\(ToryAPIRequestContext.baseURL)\(path)"
        default: self.requestURL
            = "\(ToryAPIRequestContext.baseURL)/\(domain.rawValue)/\(AppConfigure.serverVersion)\(path)"
        }
        self.params = params
        self.requestUIMode = requestUIMode
        self.resultUIMode = resultUIMode
        self.headers = headers
    }

    init(domain: ToryAPIServerDomain,
         path: String,
         multipartFormDatas: [MultiPartForm],
         requestUIMode: APIRequestUIMode,
         resultUIMode: APIResultUIMode,
         headers: HTTPHeaders = ["Content-Type": "multipart/form-data",
                                 "Authorization": "Bearer \(WDUserDefaultManager.shared.token ?? "")"]) {
        switch domain {
        case .primitive: self.requestURL = "\(ToryAPIRequestContext.baseURL)\(path)"
        default: self.requestURL
            = "\(ToryAPIRequestContext.baseURL)/\(domain.rawValue)/\(AppConfigure.serverVersion)\(path)"
        }
        self.multipartFormDatas = multipartFormDatas
        self.requestUIMode = requestUIMode
        self.resultUIMode = resultUIMode
        self.headers = headers
    }
}
