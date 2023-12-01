//
//  ToryPointTransactionHistoryViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/07.
//

import Foundation
import RxSwift
import RxCocoa

final class ToryPointPagerViewModel: RefactoringBaseViewModel {
    var toryPoint: Driver<String>?

    override init() {
        super.init()

        toryPoint = repository.point
            .map { "\(WDHelper.numberToNumberSeparator($0.point)) 토리" }
            .asDriver(onErrorDriveWith: .empty())
    }
}
