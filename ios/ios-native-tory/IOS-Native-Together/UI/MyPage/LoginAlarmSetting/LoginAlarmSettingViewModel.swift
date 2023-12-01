//
//  LoginAlarmSettingViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginAlarmSettingViewModel: RefactoringBaseViewModel {
    var initAutoLogin: Driver<Bool>! = nil
    let isAutoLogin = PublishRelay<Bool>()
    var presentAutoLogin: Driver<Bool>! = nil

    var initAppPush: Driver<Bool>! = nil
    let isAppPush = PublishRelay<Bool>()
    var presentAppPush: Driver<Bool>! = nil

    var initEmail: Driver<Bool>! = nil
    let isEmail = PublishRelay<Bool>()
    var presentMail: Driver<Bool>! = nil

    init(repository: WDRepository = WDRepository.shared,
         userDefaultManager: WDUserDefaultManager = WDUserDefaultManager.shared) {
        initAutoLogin = Driver<Bool>.just(userDefaultManager.isAutoLogin)
            .asDriver(onErrorDriveWith: .empty())

        let list = repository.getPushAgreementList()

        initAppPush = list
            .map {
                $0.filter {
                    $0.pushCategory == PushAgreementCategory.push
                }
            }
            .filter { !$0.isEmpty }
            .map { $0[0] }
            .map { $0.isAgree }
            .asDriver(onErrorDriveWith: .empty())

        initEmail = list
            .map {
                $0.filter {
                    $0.pushCategory == PushAgreementCategory.mailSMS
                }
            }
            .filter { !$0.isEmpty }
            .map { $0[0] }
            .map { $0.isAgree }
            .asDriver(onErrorDriveWith: .empty())

        /*
         AUTO_LOGIN
         */
        presentAutoLogin = isAutoLogin
            .asDriver(onErrorDriveWith: .empty())

        /*
         PUSH 요청
         */

        presentAppPush = isAppPush
            .flatMap {
                repository.reqPushAgreement(pushCategory: .push, isAgree: $0)
            }
            .asDriver(onErrorDriveWith: .empty())

        /*
         EMAIL 요청
         */
        presentMail = isEmail
            .flatMap {
                repository.reqPushAgreement(pushCategory: .mailSMS, isAgree: $0)
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
