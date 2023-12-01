//
//  SplashViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/07.
//

import Foundation
import RxSwift
import RxCocoa

final class SplashViewModel: RefactoringBaseViewModel {
    var isAutoLogin: Driver<Bool>! = nil

    var appversionCheck: Driver<AppVersionCheckResultDto.Update>! = nil
    let processState = PublishRelay<Int>()

    var isUniversityConfirm: Driver<Bool>! = nil
//    var universityCode: Driver<String>! = nil

    override init() {
        super.init()

        appversionCheck = repository.appVersionCheck()
            .asDriver(onErrorDriveWith: .empty())

        let timer = Observable<Int>
            .timer(.seconds(1), scheduler: MainScheduler.instance)

        /*
         AppversionCheck and AutoLogin Check
         */
        isAutoLogin = Observable
            .combineLatest(
                Observable.just(userDefaultManager.isAutoLogin),
                processState.asObservable(),
                timer
            ) { isAuto, appversion, _ in
                (isAuto, appversion)
            }
            .filter {
                switch $0.1 {
                case 0:
                    return true // 진행
                case 1:
                    return false // 진행 안함
                default:
                    return false
                }
            }
            .map {
                $0.0
            }
            .asDriver(onErrorDriveWith: .empty())
        /*
         AppversionCheck와 Auto Login Check가 완료되면 Init
         */

        isAutoLogin
            .asObservable()
            .observe(on: MainScheduler.instance)
            .filter {
                $0
            }
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable<InitResultDto>.empty() }
                return self.repository.toryInit()
            }
            .bind(to: repository.initData)
            .disposed(by: disposeBag)

        /*
         Init 진행이 완료 되면 universityCode를 통해서 화면전환 로직 수행
         */
        isUniversityConfirm = repository.member
            .filter {
                $0.memberId != 0
            }
            .map {
                $0.isUniversityConfirm
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
