//
//  CertificationRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import RxSwift
import RxCocoa

extension CertificationRepositoryProtocol {
    /*
     토리메타 init Api 함수
     */
    func toryInit() -> Observable<InitResultDto> {
        memberAPI.toryInit()
    }
    /*
     앱 버전 체크
     */
    func appVersionCheck() -> Observable<AppVersionCheckResultDto.Update> {
        memberAPI.appVersionCheck().map {
            $0.updateType
        }
    }

    /*
     pushToken update
     */
    func updatePushToken() -> Observable<Bool> {
        memberAPI.uploadPushToken().map {
            $0.isSuccess
        }
    }
}
