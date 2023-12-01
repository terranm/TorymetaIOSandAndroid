//
//  CommonWebViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CommonWebViewModel: RefactoringBaseViewModel {
    let memberUpdate = PublishRelay<Void>()
    let poinitUpdate = PublishRelay<Void>()

    let myWriteUpdate = PublishRelay<Void>()
    let myCommentUpdate = PublishRelay<Void>()

    let loginSuccess = PublishRelay<String>() // UniversityCode
    var translatePage: Signal<Bool>! = nil

    private(set) var festivalRelay = PublishRelay<Void>()

    override init() {
        super.init()

//        loginSuccess
//            .flatMap { [self] _ in
//                self.repository.toryInit()
//            }
//            .filter {
//                $0.memberVO.memberId != 0
//            }
//            .bind(to: repository.initData)
//            .disposed(by: disposeBag)

        translatePage = Observable.combineLatest(
            repository.initData.asObservable(),
            loginSuccess.asObservable()
        ) {
            ($0, $1)
        }
        .filter {
            $0.0.memberVO.memberId != 0
        }
        .map {
            $0.0.memberVO.isUniversityConfirm
        }
        .asSignal(onErrorSignalWith: .empty())

//        memberUpdate
//            .flatMap { [self] _ in
//                self.repository.updateMember()
//            }
//            .subscribe()
//            .disposed(by: disposeBag)
//
//        poinitUpdate
//            .flatMap { [self] _ in
//                self.repository.updatePoint()
//            }
//            .subscribe()
//            .disposed(by: disposeBag)
//
//        myWriteUpdate
//            .flatMap { [self] _ in
//                self.repository.updateMyWriteList()
//            }
//            .subscribe()
//            .disposed(by: disposeBag)
//
//        myCommentUpdate
//            .flatMap { [self] _ in
//                self.repository.updateMyComment()
//            }
//            .subscribe()
//            .disposed(by: disposeBag)

    }
}
