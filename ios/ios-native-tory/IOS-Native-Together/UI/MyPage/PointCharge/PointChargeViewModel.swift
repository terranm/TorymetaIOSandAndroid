//
//  UserToryPointChargeViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import Foundation
import RxSwift
import RxCocoa
import StoreKit

final class PointChargeViewModel: RefactoringBaseViewModel {
    let userToryPointItems = BehaviorRelay<[SKProduct]>(value: [])
    var presentUserToryPointItems: Driver<[SKProduct]>! = nil

    let charging = PublishRelay<(quantity: Int, receipt: String)>()

    override init() {
        super.init()
        presentUserToryPointItems = userToryPointItems
            .map {
                $0.sorted { old, new in
                    let old = Int(old.localizedTitle.replacingOccurrences(of: localizable.tory(), with: "")
                        .replacingOccurrences(of: ",", with: "")) ?? 0
                    let new = Int(new.localizedTitle.replacingOccurrences(of: localizable.tory(), with: "")
                        .replacingOccurrences(of: ",", with: "")) ?? 0
                    return old < new
                }
            }
            .asDriver(onErrorDriveWith: .empty())

        charging
            .flatMap { [self] in
                self.repository.reqPointCharging(receipt: $0.receipt)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}
