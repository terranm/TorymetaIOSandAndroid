//
//  MyWritedViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/28.
//

import Foundation
import RxSwift
import RxCocoa

final class MyCommentViewModel: RefactoringBaseViewModel {
    var items: Driver<[MyCommentListResultDto.Item]>?

    override init() {
        super.init()

        repository.getMyCommentList()
            .bind(to: repository.myCommentList)
            .disposed(by: disposeBag)

        items = repository.myCommentList
            .asDriver(onErrorDriveWith: .empty())
    }
}
