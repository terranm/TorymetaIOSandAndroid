//
//  ChattingLoungeChattingEntranceViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/22.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeChattingEntranceViewModel: RefactoringBaseViewModel {
    enum ConformStatus {
        case passwordInCorrect
        case success
    }
    let title = BehaviorRelay<String>(value: "")
    let isSecret = BehaviorRelay<Bool>(value: false)
    let secretPassword = BehaviorRelay<String>(value: "")
    let secretConformPassword = BehaviorRelay<String>(value: "")

    let confirmButtonTap = PublishRelay<Void>()

    func confirmActive() -> Observable<Bool> {
        Observable.combineLatest(title,
                                 isSecret,
                                 secretPassword,
                                 secretConformPassword) {
            let isPasswordOk = !$2.isEmpty && $2.count <= 6
            let isPasswordConfirmOk = !$3.isEmpty && $3.count <= 6
            if !$1 && $0 != "" {
                return true
            }
            if $1 && $0 != "" && isPasswordOk && isPasswordConfirmOk {
                return true
            }
            return false
        }
    }

    func confirmButtonTapWithUnityBridge() -> Signal<ConformStatus> {
        confirmButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<ConformStatus>.empty() }
                let title = title.value
                let isSecret = isSecret.value
                let secretPassword = secretPassword.value
                let secretConformPassword = secretConformPassword.value

                let isPasswordOk = !secretPassword.isEmpty && secretPassword.count <= 6
                let isPasswordConfirmOk = !secretConformPassword.isEmpty
                && secretConformPassword.count <= 6

                if !isSecret && title != "" {
                    return Observable.just(ConformStatus.success)
                }
                if isSecret
                    && title != ""
                    && isPasswordOk
                    && isPasswordConfirmOk
                    && secretPassword == secretConformPassword {
                    return Observable.just(ConformStatus.success)
                }
                if isSecret
                    && isPasswordOk
                    && isPasswordConfirmOk
                    && secretPassword != secretConformPassword {
                    return Observable.just(ConformStatus.passwordInCorrect)
                }
                return Observable<ConformStatus>.empty()

            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
