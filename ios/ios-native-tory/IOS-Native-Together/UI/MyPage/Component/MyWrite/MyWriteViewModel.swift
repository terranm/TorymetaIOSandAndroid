//
//  NFTCertificationViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/28.
//

import Foundation
import RxSwift
import RxCocoa

final class MyWriteViewModel: RefactoringBaseViewModel {
    var items: Driver<[MyWriteListResultDto.Item]>?
    let buttonTap = PublishRelay<Void>()

    override init() {
        super.init()
        repository.getMyWriteList()
            .bind(to: repository.myWriteList)
            .disposed(by: disposeBag)

        items = repository.myWriteList
            .asDriver(onErrorDriveWith: .empty())
    }
}
