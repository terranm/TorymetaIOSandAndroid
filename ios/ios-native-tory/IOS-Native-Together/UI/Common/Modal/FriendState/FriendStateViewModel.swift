//
//  FriendStateViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/04.
//

import Foundation
import RxSwift
import RxCocoa

final class FriendStateViewModel: RefactoringBaseViewModel {
    private var memberId: Int?
    private var rangeFriendInfo: RangeFriendInfo?

    let pageData = BehaviorRelay<FriendMarkerDetailDto>(value: FriendMarkerDetailDto())
    let nftItemButtonTap = PublishRelay<OwnerNftResultDto?>()
    let locationButtonTap = PublishRelay<Void>() // isLocationBlock
    let callButtonTap = PublishRelay<Void>() // phoneNumber
    let chatButtonTap = PublishRelay<Void>() // memberId

    init(memberId: Int) {
        self.memberId = memberId
        super.init()
    }

    init(rangeFriendInfo: RangeFriendInfo) {
        self.rangeFriendInfo = rangeFriendInfo
        super.init()
    }

    func setPageData() -> Observable<FriendMarkerDetailDto> {
        if let memberId = memberId {
            return repository.getFriendMarkerDetail(memberId: memberId)
        }
        if let rangeFriendInfo = rangeFriendInfo {
            return repository.getFriendMarkerDetail(memberId: rangeFriendInfo.memberId)
        }
        return Observable<FriendMarkerDetailDto>.empty()
    }

    func safePageData() -> Observable<FriendMarkerDetailDto> {
        pageData
            .filter { $0.memberId != 0 }
    }

    func nftList() -> Driver<[OwnerNftResultDto]> {
        safePageData()
            .map { $0.nftList }
            .asDriver(onErrorDriveWith: .empty())
    }

    func profileImage() -> Driver<URL?> {
        safePageData()
            .map { URL(string: $0.imgUrl) }
            .asDriver(onErrorDriveWith: .empty())
    }

    func profileName() -> Driver<String?> {
        safePageData()
            .map { $0.profileName }
            .asDriver(onErrorDriveWith: .empty())
    }

    func universityName() -> Driver<String> {
        safePageData()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<UniversityListResultDto.Item>.empty() }
                return self.repository.getMyCampus($0.universityCode)
            }
            .map { $0.universityName }
            .asDriver(onErrorDriveWith: .empty())
    }

    func locationImage() -> Driver<String> {
        safePageData()
            .map { $0.isLocationBlock ? R.image.campus_location_off.name : R.image.campus_location_on.name }
            .asDriver(onErrorDriveWith: .empty())
    }

    func locationButtonTapWithToast() -> Signal<String> {
        if memberId != nil {
            return locationButtonTap
                .flatMap { [weak self] in
                    guard let self = self else { return Observable<Bool>.empty() }
                    return Observable.just(self.pageData.value.isLocationBlock)
                }
                .flatMap { [weak self] in
                    guard let self = self else { return Observable<FriendMarkerDetailDto>.empty() }
                    return $0
                    ? self.repository.updateLocationUnblock(reloadData: self.pageData)
                    : self.repository.updateLocationBlock(reloadData: self.pageData)
                }
                .map {
                    $0.isLocationBlock
                    ? localizable.friendStateLocationSecretMessage()
                    : localizable.friendStateLocationOpenMessage()
                }
                .asSignal(onErrorSignalWith: .empty())
        }

        if let rangeFriendInfo = rangeFriendInfo {
            return locationButtonTap
                .flatMap { [weak self] in
                    guard let self = self else { return Observable<FriendMarkerDetailDto>.empty() }
                    return self.repository.updateLocation(reloadData: self.pageData, rangeFriendInfo: rangeFriendInfo)
                }
                .map {
                    $0.isLocationBlock
                    ? localizable.friendStateLocationSecretMessage()
                    : localizable.friendStateLocationOpenMessage()
                }
                .asSignal(onErrorSignalWith: .empty())
        }
        return Signal<String>.empty()
    }

    func hiddenCallButton() -> Driver<Bool> {
        safePageData()
            .map { $0.phoneNumber.isEmpty }
            .asDriver(onErrorDriveWith: .empty())
    }

    func callButtonTapWithSwitchCallModal() -> Signal<URL?> {
        callButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<String>.empty() }
                return Observable.just(self.pageData.value.phoneNumber)
            }
            .map { URL(string: "tel://\($0)") }
            .asSignal(onErrorSignalWith: .empty())
    }

    func hiddenNftEmptyLabel() -> Driver<Bool> {
        safePageData()
            .map { $0.nftList }
            .map { !$0.isEmpty }
            .asDriver(onErrorDriveWith: .empty())
    }
}
