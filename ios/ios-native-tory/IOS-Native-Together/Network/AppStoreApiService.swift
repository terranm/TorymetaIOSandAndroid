//
//  AppStoreApiService.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/05.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

struct AppStoreApiService {
    static let shared = AppStoreApiService()
    private init() {}

    private static let scheme = "https://"
    private static let host = "itunes.apple.com"
    private static let path = "/lookup"

//    func updateAvailable() {
//        Observable<String>.just(
//            AppStoreApiService.scheme
//            + AppStoreApiService.host
//            + AppStoreApiService.path
//        )
//        .map {
//            let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
//            return "\($0)/bundleId=\(bundleId)"
//        }
//        .flatMap {
//            AF.request(
//                $0,
//                method: .get,
//                parameters: nil,
//                encoding: JSONEncoding.default,
//                headers: ["Content-Type" : "application/json"]
//            ).rx.data()
//        }
//        .map {
//            // json data parsing....
//        }
//        
//    }
}
