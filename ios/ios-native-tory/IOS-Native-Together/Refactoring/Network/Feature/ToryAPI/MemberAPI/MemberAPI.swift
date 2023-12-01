//
//  TorymemberAPIService.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/08.
//

import Foundation
import Alamofire
import RxSwift
import Firebase
import FirebaseMessaging
/*
 https://web.torymeta.com/member/v1 관련 API
 */
protocol CertificationAPIProtocol {}
protocol UserAPIProtocol {}
protocol FriendAPIProtocol {}
protocol PointAPIProtocol {}
protocol EventAPIProtocol {}
protocol SeminarAPIProtocol {}
protocol AvatarAPIProtocol {}
protocol TTCAPIProtocol {}

struct MemberAPI: CertificationAPIProtocol,
                  UserAPIProtocol,
                  FriendAPIProtocol,
                  PointAPIProtocol,
                  EventAPIProtocol,
                  AvatarAPIProtocol,
                  SeminarAPIProtocol,
                  TTCAPIProtocol {
    static let shared = MemberAPI()
    private init() {}
}
