//
//  FriendListViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/31.
//

import Foundation
import RxSwift
import RxCocoa

final class FriendListViewModel: RefactoringBaseViewModel {
    let pageData = BehaviorRelay<FriendInfoList>(value: .init())

    let searchButtonTap = PublishRelay<Void>()
    /*
     type
     */
    let sectionHeaderButtonTap = PublishRelay<FriendType?>()

    let commonFriendViewModel = FriendCommonViewModel()
}
