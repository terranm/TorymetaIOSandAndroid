//
//  MainChangeNameViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/08.
//

import Foundation
import RxSwift
import RxCocoa

final class MainChangeNameViewModel: RefactoringBaseViewModel {

    let confirmButtonTap = PublishRelay<String?>()
    private(set) var presentConfirmButtonTap: Signal<Bool>?

    override init() {
        super.init()
        presentConfirmButtonTap = confirmButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                return self.repository.reqChangeNickName(nickName: $0 ?? "")
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
