//
//  FriendCommonViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/08.
//

import Foundation
import RxSwift
import RxCocoa

class FriendCommonViewModel: RefactoringBaseViewModel {

    let friendInteractionButtonTap = PublishRelay<UpdateFriendStateInteractionCase?>()
    var presentInteractionAction: Signal<UpdateFriendStateInteractionCase?>?

    let isPageDidAppear = PublishRelay<Bool>()
    let friendButtonTap = PublishRelay<RangeFriendInfo>()

    override init() {
        super.init()
        presentInteractionAction = friendInteractionButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<UpdateFriendStateInteractionCase?>.empty() }
                return self.repository.updateUserState(interaction: $0)
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    func stateChangeResult(friendSearchViewModel: FriendSearchViewModel,
                           interaction: UpdateFriendStateInteractionCase?) -> Observable<String> {
        let pageData = friendSearchViewModel.pageData
        let query = friendSearchViewModel.query.value ?? ""
        let type = friendSearchViewModel.type.value
        switch interaction {
        case .friendAccept(let data):
            return repository.updateAccept(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 친구 요청을 보냈습니다."
            }
        case .friendUnAccept(let data):
            return repository.updateUnAccept(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 친구 요청을 취소하였습니다."
            }
        case .friendRequest(let data):
            return repository.updateReqeuest(reloadData: pageData, qeury: query, type: type, data: data).map {
                "\($0.profileName)님이 친구로 등록되었습니다."
            }
        case .friendDelete(let data):
            return repository.updateDelete(reloadData: pageData, data: data).map { _ in "" }
        case .friendBlock(let data):
            return repository.updateBlock(reloadData: pageData, data: data).map { _ in "" }
        case .friendUnBlock(let data):
            return repository.updateUnBlock(reloadData: pageData, data: data).map { _ in "" }
        case .locationBlock(let data):
            return repository.updateLocationBlock(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 내 위치를 보이지 않습니다."
            }
        case .locationUnBlock(let data):
            return repository.updateLocationUnblock(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 내 위치를 공유합니다."
            }
        default:
            return Observable<String>.empty()
        }
    }

    func stateChangeResult(friendListDetailViewModel: FriendListDetailViewModel,
                           interaction: UpdateFriendStateInteractionCase?) -> Observable<String> {
        let pageData = friendListDetailViewModel.pageData
        let blockList = friendListDetailViewModel.blockList
        switch interaction {
        case .friendAccept(let data):
            return repository.updateAccept(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 친구 요청을 보냈습니다."
            }
        case .friendUnAccept(let data):
            return repository.updateUnAccept(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 친구 요청을 취소하였습니다."
            }
        case .friendRequest(let data):
            return repository.updateReqeuest(reloadData: pageData, data: data).map {
                "\($0.profileName)님이 친구로 등록되었습니다."
            }
        case .friendDelete(let data):
            return repository.updateDelete(reloadData: pageData, data: data).map { _ in "" }
        case .friendBlock(let data):
            return repository.updateBlock(reloadData: pageData, data: data).map { _ in "" }
        case .friendUnBlock(let data):
            return repository.updateUnBlock(reloadData: blockList, data: data).map { _ in "" }
        case .locationBlock(let data):
            return repository.updateLocationBlock(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 내 위치를 보이지 않습니다."
            }
        case .locationUnBlock(let data):
            return repository.updateLocationUnblock(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 내 위치를 공유합니다."
            }
        default:
            return Observable<String>.empty()
        }
    }

    func stateChangeResult(friendListViewModel: FriendListViewModel,
                           interaction: UpdateFriendStateInteractionCase?) -> Observable<String> {
        let pageData = friendListViewModel.pageData
        switch interaction {
        case .friendAccept(let data):
            return repository.updateAccept(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 친구 요청을 보냈습니다."
            }
        case .friendUnAccept(let data):
            return repository.updateUnAccept(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 친구 요청을 취소하였습니다."
            }
        case .friendRequest(let data):
            return repository.updateReqeuest(reloadData: pageData, data: data).map {
                "\($0.profileName)님이 친구로 등록되었습니다."
            }
        case .friendDelete(let data):
            return repository.updateDelete(reloadData: pageData, data: data).map { _ in "" }
        case .friendBlock(let data):
            return repository.updateBlock(reloadData: pageData, data: data).map { _ in "" }
        case .friendUnBlock:
            _ = repository.getFriendInfoList()
                .take(1)
                .bind(to: friendListViewModel.pageData)
            return Observable<String>.empty()
        case .locationBlock(let data):
            return repository.updateLocationBlock(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 내 위치를 보이지 않습니다."
            }
        case .locationUnBlock(let data):
            return repository.updateLocationUnblock(reloadData: pageData, data: data).map {
                "\($0.profileName)님에게 내 위치를 공유합니다."
            }
        default:
            return Observable<String>.empty()
        }
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

    private func getToastResource(interaction: UpdateFriendStateInteractionCase?) -> String {
        switch interaction {
        case .locationBlock(let data):
            return "\(data.profileName)님에게 내 위치를 보이지 않습니다."
        case .locationUnBlock(let data):
            return "\(data.profileName)님에게 내 위치를 공유합니다."
        case .friendAccept(let data):
            return "\(data.profileName)님에게 친구 요청을 보냈습니다."
        case .friendUnAccept(let data):
            return "\(data.profileName)님에게 친구 요청을 취소하였습니다."
        case .friendRequest(let data):
            return "\(data.profileName)님이 친구로 등록되었습니다."
        default: return ""
        }
    }
}
