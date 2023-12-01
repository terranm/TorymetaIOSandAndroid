//
//  MemberCertificationAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

extension CertificationAPIProtocol {
    func toryInit() -> Observable<InitResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/init",
                                                   params: ["appVersion": AppConfigure.currentAppVersion,
                                                            "deviceName": AppConfigure.deviceName,
                                                            "osVersion": AppConfigure.osVersion,
                                                            "bannerType": AppConfigure.bannerType],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .translateLogin)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<InitResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in Observable<InitResultDto>.empty() }
    }

    func appVersionCheck() -> Observable<AppVersionCheckResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/deauth/v1/version/check",
                                                   params: ["o": AppConfigure.osName,
                                                            "v": AppConfigure.currentAppVersion],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showRestart)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<AppVersionCheckResultDto>>(requestContext: requestContext)
            .getMapping()
            .catch { _ in Observable<AppVersionCheckResultDto>.empty() }
    }

    /*
     upload pushToken
     */
    func uploadPushToken() -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/push-token",
                                                   params: ["pushToken": Messaging.messaging().fcmToken ?? ""],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .translateLogin)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in Observable<ReqResultDto>.empty() }
    }
}
