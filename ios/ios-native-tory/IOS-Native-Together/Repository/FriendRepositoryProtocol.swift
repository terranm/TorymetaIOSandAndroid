//
//  FriendRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/23.
//

import Foundation
import RxSwift
import RxCocoa
import ContactsUI

extension FriendRepositoryProtocol {

    // 토리톡 친구리스트 전체
    func getFriendInfoList() -> Observable<FriendInfoList> {
        let permissionManager = WDPermissionManager.shared
        return permissionManager.checkAddressPermission()
            .filter { $0 == .granted }
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable<[ContractInfo]>.empty() }
                return self.getContractList()
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<FriendInfoList>.empty() }
                return memberAPI.getFriendInfoList(contractList: $0)
            }
    }

    // 토리톡 상태변경
    func updateUserState(interaction: UpdateFriendStateInteractionCase?) ->
        Observable<UpdateFriendStateInteractionCase?> {
        memberAPI.updateUserState(interaction: interaction)
            .flatMap { [weak self] in
                guard let self = self else { return Observable<UpdateFriendStateInteractionCase?>.empty() }
                if $0.isSuccess {
                    self.repositoryModel.friendListReload.accept(interaction)
                    self.repositoryModel.friendDetailReload.accept(interaction)
                    self.repositoryModel.friendSearchReload.accept(interaction)
                    return Observable.just(interaction)
                }
                return Observable<UpdateFriendStateInteractionCase?>.empty()
            }
    }

    func requestFriend(memberId: Int, target: String = "F", status: String = "R") -> Observable<Bool> {
        memberAPI.updateUserState(memberId: memberId, target: target, status: status).map { $0.isSuccess }
    }

    func updateLocation(reloadData: BehaviorRelay<FriendMarkerDetailDto>, 
                        rangeFriendInfo: RangeFriendInfo) -> Observable<FriendMarkerDetailDto> {
        let interaction = rangeFriendInfo.isLocationBlock
        ? UpdateFriendStateInteractionCase.locationUnBlock(rangeFriendInfo)
        : UpdateFriendStateInteractionCase.locationBlock(rangeFriendInfo)

        return memberAPI.updateUserState(interaction: interaction)
            .flatMap { [weak self] in
                guard let self = self else { return Observable<FriendMarkerDetailDto>.empty() }
                if $0.isSuccess {
                    var newData = reloadData.value
                    newData.isLocationBlock = !newData.isLocationBlock
                    reloadData.accept(newData)

                    self.repositoryModel.friendListReload.accept(interaction)
                    self.repositoryModel.friendDetailReload.accept(interaction)
                    self.repositoryModel.friendSearchReload.accept(interaction)
                    return Observable.just(newData)
                }
                return Observable<FriendMarkerDetailDto>.empty()
            }
    }

    func updateLocationBlock(reloadData: BehaviorRelay<FriendMarkerDetailDto>,
                             target: String = "L",
                             status: String = "B") -> Observable<FriendMarkerDetailDto> {
        var newData = reloadData.value
        return memberAPI.updateUserState(memberId: newData.memberId, target: target, status: status)
            .flatMap {
                if $0.isSuccess {
                    newData.isLocationBlock = true
                    reloadData.accept(newData)
                    return Observable.just(newData)
                }
                return Observable<FriendMarkerDetailDto>.empty()
            }
    }

    func updateLocationUnblock(reloadData: BehaviorRelay<FriendMarkerDetailDto>,
                               target: String = "L",
                               status: String = "U") -> Observable<FriendMarkerDetailDto> {
        var newData = reloadData.value
        return memberAPI.updateUserState(memberId: newData.memberId, target: target, status: status)
            .flatMap {
                if $0.isSuccess {
                    newData.isLocationBlock = false
                    reloadData.accept(newData)
                    return Observable.just(newData)
                }
                return Observable<FriendMarkerDetailDto>.empty()
            }
    }
    /*
     친구 차단 리스트
     */
    func getBlockFriendList() -> Observable<[BlockFriendInfo]> {
        memberAPI.getBlocFriendList()
            .map { $0.blockFriendList }
    }

    /*
     토리톡 검색 결과
     */
    func getSearchFriendList(query: String?,
                             type: FriendType) -> Observable<SearchFriendList> {
        let permissionManager = WDPermissionManager.shared
        return permissionManager.checkAddressPermission()
            .filter {
                $0 == .granted
            }
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable<[String]>.empty() }
                return self.getContractList()
                    .map {
                        $0.map {
                            $0.phoneNum
                        }
                    }
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<SearchFriendList>.empty() }
                return self.memberAPI.getSearchFriendList(phoneList: $0, query: query, type: type)
            }
    }

    /*
     주소록 리스트 데이터
     */
    func getContractList() -> Observable<[ContractInfo]> {
        return Observable.create { observer -> Disposable in
            let contactStore = CNContactStore()
            contactStore.requestAccess(for: .contacts) { granted, _ in
                if granted {
                    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                    let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
                    do {
                        var contractInfo: [ContractInfo] = []
                        try contactStore.enumerateContacts(with: request) { contact, _ in
                            let firstName = contact.givenName
                            let lastName = contact.familyName
                            let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
                            let replactPhoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
                            let contractInfoItem = ContractInfo(profileName: "\(lastName)\(firstName)",
                                                                phoneNum: replactPhoneNumber)
                            contractInfo.append(contractInfoItem)
                        }
                        observer.onNext(contractInfo)
                    } catch {
                        observer.onError(error)
                    }
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    /*
     채팅라운지 친구 초대
     */
    func reqChattingLoungeInvite(memberId: Int, tableId: String) -> Observable<Bool> {
        return memberAPI.reqChattingLoungeInvite(memberId: memberId, tableId: tableId)
            .map { $0.isInvite }
    }
}

/*
 friendUpdate Business Logic
 */
extension FriendRepositoryProtocol {

    func updateLocationBlock(reloadData: BehaviorRelay<SearchFriendList>,
                             data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        let result = locationStateChangeLogic(rangeIn: pageData.friendListInRange,
                                              rangeOut: pageData.friendListOutRange,
                                              data: data,
                                              stateYn: "Y")
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateLocationBlock(reloadData: BehaviorRelay<FriendInfoList>,
                             data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        let result = locationStateChangeLogic(rangeIn: pageData.friendListInRange,
                                              rangeOut: pageData.friendListOutRange,
                                              data: data,
                                              stateYn: "Y")
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateLocationUnblock(reloadData: BehaviorRelay<SearchFriendList>,
                               data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        // 안과 밖의 친구는 동시에 두명이 공존 할 수 없다.
        let result = locationStateChangeLogic(rangeIn: pageData.friendListInRange,
                                              rangeOut: pageData.friendListOutRange,
                                              data: data,
                                              stateYn: "N")
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateLocationUnblock(reloadData: BehaviorRelay<FriendInfoList>,
                               data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        // 안과 밖의 친구는 동시에 두명이 공존 할 수 없다.
        let result = locationStateChangeLogic(rangeIn: pageData.friendListInRange,
                                              rangeOut: pageData.friendListOutRange,
                                              data: data,
                                              stateYn: "N")
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateBlock(reloadData: BehaviorRelay<SearchFriendList>,
                     data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        // 안과 밖의 친구는 동시에 두명이 공존 할 수 없다.
        let result = blockAndDeleteLogic(rangeIn: pageData.friendListInRange,
                                         rangeOut: pageData.friendListOutRange,
                                         data: data)
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateBlock(reloadData: BehaviorRelay<FriendInfoList>,
                     data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        // 안과 밖의 친구는 동시에 두명이 공존 할 수 없다.
        let result = blockAndDeleteLogic(rangeIn: pageData.friendListInRange,
                                         rangeOut: pageData.friendListOutRange,
                                         data: data)
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateUnBlock(reloadData: BehaviorRelay<SearchFriendList>,
                       data: BlockFriendInfo)
    -> Observable<BlockFriendInfo> {
        var pageData = reloadData.value
        let result = unblockFriend(list: pageData.blockFriendList, data: data)
        pageData.blockFriendList = result
        reloadData.accept(pageData)
        return Observable.just(data)
    }

    func updateUnBlock(reloadData: BehaviorRelay<[BlockFriendInfo]>,
                       data: BlockFriendInfo)
    -> Observable<BlockFriendInfo> {
        let result = unblockFriend(list: reloadData.value, data: data)
        reloadData.accept(result)
        return Observable.just(data)
    }

    func updateDelete(reloadData: BehaviorRelay<SearchFriendList>,
                      data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        // 안과 밖의 친구는 동시에 두명이 공존 할 수 없다.
        let result = blockAndDeleteLogic(rangeIn: pageData.friendListInRange,
                                         rangeOut: pageData.friendListOutRange,
                                         data: data)
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateDelete(reloadData: BehaviorRelay<FriendInfoList>,
                      data: RangeFriendInfo)
    -> Observable<RangeFriendInfo> {
        var pageData = reloadData.value
        // 안과 밖의 친구는 동시에 두명이 공존 할 수 없다.
        let result = blockAndDeleteLogic(rangeIn: pageData.friendListInRange,
                                         rangeOut: pageData.friendListOutRange,
                                         data: data)
        pageData.friendListInRange = result.rangeInList
        pageData.friendListOutRange = result.rangeOutList
        /*
         업데이트
         */
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateAccept(reloadData: BehaviorRelay<SearchFriendList>,
                      data: FriendInfo)
    -> Observable<FriendInfo> {
        var pageData = reloadData.value
        let result = acceptStateChange(list: pageData.newFriendList, data: data, stateYn: "Y")
        pageData.newFriendList = result
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateAccept(reloadData: BehaviorRelay<FriendInfoList>,
                      data: FriendInfo)
    -> Observable<FriendInfo> {
        var pageData = reloadData.value
        let result = acceptStateChange(list: pageData.newFriendList, data: data, stateYn: "Y")
        pageData.newFriendList = result
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateUnAccept(reloadData: BehaviorRelay<SearchFriendList>,
                        data: FriendInfo)
    -> Observable<FriendInfo> {
        var pageData = reloadData.value
        let result = acceptStateChange(list: pageData.newFriendList, data: data, stateYn: "N")
        pageData.newFriendList = result
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateUnAccept(reloadData: BehaviorRelay<FriendInfoList>,
                        data: FriendInfo)
    -> Observable<FriendInfo> {
        var pageData = reloadData.value
        let result = acceptStateChange(list: pageData.newFriendList, data: data, stateYn: "N")
        pageData.newFriendList = result
        reloadData.accept(pageData)

        return Observable.just(data)
    }

    func updateReqeuest(reloadData: BehaviorRelay<SearchFriendList>,
                        qeury: String,
                        type: FriendType,
                        data: FriendInfo) -> Observable<FriendInfo> {
        _ = getSearchFriendList(query: qeury, type: type)
            .take(1)
            .bind(to: reloadData)

        return Observable.just(data)
    }

    func updateReqeuest(reloadData: BehaviorRelay<FriendInfoList>,
                        data: FriendInfo) -> Observable<FriendInfo> {
        _ = getFriendInfoList()
            .take(1)
            .bind(to: reloadData)

        return Observable.just(data)
    }

    private func locationStateChangeLogic(rangeIn: [RangeFriendInfo],
                                          rangeOut: [RangeFriendInfo],
                                          data: RangeFriendInfo,
                                          stateYn: String) -> (rangeInList: [RangeFriendInfo],
                                                               rangeOutList: [RangeFriendInfo]) {
        var rangeInList = rangeIn
        var rangeOutList = rangeOut
//        for index in 0..<rangeInList.count {
//            if data.memberId == rangeInList[index].memberId {
//                rangeInList[index].locationBlockYn = stateYn
//                return (rangeInList, rangeOutList)
//            }
//        }
        for index in 0..<rangeInList.count where data.memberId == rangeInList[index].memberId {
            rangeInList[index].locationBlockYn = stateYn
            return (rangeInList, rangeOutList)
        }
//        for index in 0..<rangeOutList.count {
//            if data.memberId == rangeOutList[index].memberId {
//                rangeOutList[index].locationBlockYn = stateYn
//                return (rangeInList, rangeOutList)
//            }
//        }
        for index in 0..<rangeOutList.count where data.memberId == rangeOutList[index].memberId {
            rangeOutList[index].locationBlockYn = stateYn
            return (rangeInList, rangeOutList)
        }

        return (rangeInList, rangeOutList)
    }

    private func blockAndDeleteLogic(rangeIn: [RangeFriendInfo],
                                     rangeOut: [RangeFriendInfo],
                                     data: RangeFriendInfo) -> (rangeInList: [RangeFriendInfo],
                                                                rangeOutList: [RangeFriendInfo]) {
        var rangeInList = rangeIn
        var rangeOutList = rangeOut
//        for index in 0..<rangeInList.count {
//            if data.memberId == rangeInList[index].memberId {
//                rangeInList.remove(at: index)
//                return (rangeInList, rangeOutList)
//            }
//        }
        for index in 0..<rangeInList.count where data.memberId == rangeInList[index].memberId {
            rangeInList.remove(at: index)
            return (rangeInList, rangeOutList)
        }

//        for index in 0..<rangeOutList.count {
//            if data.memberId == rangeOutList[index].memberId {
//                rangeOutList.remove(at: index)
//                return (rangeInList, rangeOutList)
//            }
//        }
        for index in 0..<rangeOutList.count where data.memberId == rangeOutList[index].memberId {
            rangeOutList.remove(at: index)
            return (rangeInList, rangeOutList)
        }
        return (rangeInList, rangeOutList)
    }

    private func unblockFriend(list: [BlockFriendInfo], data: BlockFriendInfo) -> [BlockFriendInfo] {
        var newList = list
//        for index in 0..<newList.count {
//            if data.memberId == newList[index].memberId {
//                newList.remove(at: index)
//                return newList
//            }
//        }
        for index in 0..<newList.count where data.memberId == newList[index].memberId {
            newList.remove(at: index)
            return newList
        }
        return newList
    }

    private func acceptStateChange(list: [FriendInfo], data: FriendInfo, stateYn: String) -> [FriendInfo] {
        var newList = list
//        for index in 0..<newList.count {
//            if data.memberId == newList[index].memberId {
//                newList[index].isInvitedYn = stateYn
//                return newList
//            }
//        }
        for index in 0..<newList.count where data.memberId == newList[index].memberId {
            newList[index].isInvitedYn = stateYn
            return newList
        }
        return newList
    }
}
