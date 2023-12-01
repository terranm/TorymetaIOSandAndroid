//
//  ChampusViewModel.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture
import NMapsMap

final class CampusViewModel: RefactoringBaseViewModel {

    let campusFriendUploadRetry = PublishRelay<Void>()

    // campusPosition...
    var campusPosition: Driver<NMGLatLng>?

    // currentPosition
    let currentPosition: BehaviorRelay<NMGLatLng>

    // friendList Marker...
    let friendMarkerLngLngList = BehaviorRelay<[FriendMarkerListResultDto.Marker]>(value: [])
    var presedentFriendMarkers: Driver<[FriendMarkerListResultDto.Marker]>?
    var friendUpdate: Observable<[FriendMarkerListResultDto.Marker]>?

    // move to Camera...
    let moveToCampusPositionTap = PublishRelay<UITapGestureRecognizer>()
    let moveToCurrentPositionTap = PublishRelay<Void>()

    var presentMoveToCampusCamera: Signal<NMGLatLng>?
    var presentMoveToCurrentCamera: Signal<NMGLatLng>?

    // business hide show..
    var presentBuildingMakrers: Driver<[BuildingMarkerListResultDto.Marker]>?
    let businessHideButtonTap = BehaviorRelay<UITapGestureRecognizer>(value: .init())
    var presentBusinessMarkerHide: Driver<Bool>?
    /*
     위치 권한 허용
     */
    var locaitonAgreeButtonTap = PublishRelay<UITapGestureRecognizer>()
    var presentLocationAgreeUI: Signal<Bool>?

    var isBannerShow: Driver<Bool>?
    var isOnAirShow = BehaviorRelay<Bool>(value: false)

    let campusPlayItemButtonTap = BehaviorRelay<UniversityListResultDto.Item>(value: .init())
    var presentPlayMarker: Driver<UniversityListResultDto.Item>?

    let isCheckIn: BehaviorRelay<Bool>

    init(isCheckIn: BehaviorRelay<Bool>, myCurrentPosition: BehaviorRelay<NMGLatLng>) {
        self.isCheckIn = isCheckIn
        self.currentPosition = myCurrentPosition
        super.init()

        campusPosition = repository.getMyCampus()
            .map {
                NMGLatLng(lat: $0.lat, lng: $0.lng)
            }
            .asDriver(onErrorDriveWith: .empty())

        let friendMakerUpdateTimeInteval = Observable<Int>
            .interval(.seconds(15), scheduler: MainScheduler.instance)
            .startWith(0)

        friendUpdate = friendMakerUpdateTimeInteval
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable<[FriendMarkerListResultDto.Marker]>.empty() }
                return self.repository.getFriendMarkerList()
            }

        isBannerShow = repository.isSeminarBannerShow
            .asDriver(onErrorDriveWith: .empty())

        presedentFriendMarkers = friendMarkerLngLngList
            .asDriver(onErrorDriveWith: .empty())

        presentBuildingMakrers = repository.member
            .distinctUntilChanged {
                /*
                 같으면 리턴해라.....
                 */
                $0.universityCode == $1.universityCode
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[BuildingMarkerListResultDto.Marker]>.empty() }
                return self.repository.getUniversityBuildingMarkerList(universityCode: $0.universityCode)
            }
            .asDriver(onErrorDriveWith: .empty())

        // currentPosition Move
        presentMoveToCurrentCamera = moveToCurrentPositionTap
            .map { [weak self] _ in
                guard let self = self else { return NMGLatLng() }
                return self.currentPosition.value
            }
            .asSignal(onErrorSignalWith: .empty())

        // campus Move
        presentMoveToCampusCamera =  Observable
            .combineLatest(
                moveToCampusPositionTap.asObservable(),
                campusPosition?.asObservable() ?? Observable.just(NMGLatLng())
            ) { _, position in
                return position
            }
            .asSignal(onErrorSignalWith: .empty())

//        business hide show....
        presentBusinessMarkerHide = businessHideButtonTap
            .scan(true) { lastState, _ in !lastState}
            .asDriver(onErrorDriveWith: .empty())

        presentPlayMarker = campusPlayItemButtonTap
            .asDriver(onErrorDriveWith: .empty())

        presentLocationAgreeUI = locaitonAgreeButtonTap
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable<MyMemberResultDto>.empty() }
                return self.repository.updateMyLocationInformation()
            }
            .map { $0.isLocationExpose }
            .asSignal(onErrorSignalWith: .empty())
    }
}
