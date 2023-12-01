//
//  SeminarPwModalViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import Foundation
import RxSwift
import RxCocoa

final class SeminarPwModalViewModel: RefactoringBaseViewModel {
    let hidePasswordConfirm: Bool
    let completeButtonTap = PublishRelay<Void>()
    var presentCompleteButton: Signal<Void>! = nil

    init(hidePasswordConfirm: Bool = true) {
        self.hidePasswordConfirm = hidePasswordConfirm
        super.init()
        presentCompleteButton = completeButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }
}
