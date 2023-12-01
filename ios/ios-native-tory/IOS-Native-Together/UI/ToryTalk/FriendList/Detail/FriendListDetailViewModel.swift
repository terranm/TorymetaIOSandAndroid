//
//  FriendListDetailViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/02.
//

import Foundation
import RxSwift
import RxCocoa

final class FriendListDetailViewModel: RefactoringBaseViewModel {
    let friendType: FriendType?
    var pageData = BehaviorRelay<FriendInfoList>(value: FriendInfoList())
    let blockList = BehaviorRelay<[BlockFriendInfo]>(value: [])

    let commonFriendViewModel = FriendCommonViewModel()

    init(friendType: FriendType?, parentPageDataValue: FriendInfoList?) {
        self.friendType = friendType
        super.init()
        if let parentPageDataValue = parentPageDataValue {
            self.pageData = BehaviorRelay<FriendInfoList>(value: parentPageDataValue)
        }
    }

    func getBlockList(type: FriendType?) -> Observable<[BlockFriendInfo]> {
        if type == .block {
            return repository.getBlockFriendList()
        }
        return Observable<[BlockFriendInfo]>.empty()
    }
}
