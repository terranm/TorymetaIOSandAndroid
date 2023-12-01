//
//  ChattingLoungeInviteListViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeInviteListViewModel: RefactoringBaseViewModel {
    let isBackgroundColorClear: Bool
    let list = BehaviorRelay<[FriendInfo]>(value: .init())
    let inviteButtonTap = PublishRelay<FriendInfo>()
    let isPageDidAppear = PublishRelay<Bool>()
    let tableId: String

    init(tableId: String, isBackgroundColorClear: Bool) {
        self.tableId = tableId
        self.isBackgroundColorClear = isBackgroundColorClear
        super.init()
    }

    func inviteList() -> Driver<[FriendInfo]> {
        repository.getFriendInfoList()
            .map { $0.currentFriendList }
            .asDriver(onErrorDriveWith: .empty())
    }

    func inviteButtonTapWithUnityBridgeCall() -> Driver<Bool> {
        inviteButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                print("🧊 \(tableId)")
                return self.repository.reqChattingLoungeInvite(memberId: $0.memberId, tableId: self.tableId)
            }
            .asDriver(onErrorDriveWith: .empty())
    }

    func getListCount() -> Int {
        list.value.count
    }

    func isShowGoToSettingModal() -> Observable<WDPermissionManager.PermissionState> {
        isPageDidAppear
            .filter { $0 }
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable<WDPermissionManager.PermissionState>.empty() }
                return permissionManager.checkAddressPermission()
            }
            .filter { $0 != WDPermissionManager.PermissionState.granted }
            .take(1)
    }
}
