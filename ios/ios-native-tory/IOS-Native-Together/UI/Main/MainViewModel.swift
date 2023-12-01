//
//  MainViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/08.
//

import Foundation
import NMapsMap
import RxSwift
import RxCocoa

struct LatLngUpdateAttribute {
    let lat: Double
    let lng: Double
    let isLocationExpose: Bool
}

struct ToDDto {
    let imgName: String

    let title: String
    let titleColor: String

    let btnColor: String
    let btnTextColor: String
    let btnStr: String
}

final class MainViewModel: RefactoringBaseViewModel {

    enum MainSectionType: CaseIterable {
        case chattingLounge
        case liveSeminar, createSeminarBanner, recommendMeta, ttcLecture, event, twoDNFT
    }

    let chattingLoungeList = BehaviorRelay<[ChattingLoungeChattingRoomList.Item]>(value: [])
    let entranceButtonTap = PublishRelay<ChattingLoungeChattingRoomList.Item>()
    let liveSeminarList = BehaviorRelay<[LiveSeminarListResultDto.Item]>(value: [])
    let recommendList = BehaviorRelay<[SeminarRoomTypeListResultDto.Item]>(value: [])
    let eventList = BehaviorRelay<[EventBannerListResultDto.Item]>(value: [])
    let toDList = BehaviorRelay<[ToDDto]>(value: [
        .init(imgName: "NewMain_campus_back",
              title: localizable.locateGrantDesc(),
              titleColor: "#000000",
              btnColor: "#37424D",
              btnTextColor: "#FFFFFF",
              btnStr: localizable.visit()),
        .init(imgName: "NewMain_nft_back",
              title: localizable.visitDesc(),
              titleColor: "#FFFFFF",
              btnColor: "#FFFFFF",
              btnTextColor: "#37424D",
              btnStr: localizable.entrance())
    ])

    var showEventBanner = PublishRelay<Void>()

    let isCheckIn = BehaviorRelay<Bool>(value: false)
    let myCurrentPosition = BehaviorRelay<NMGLatLng>(value: NMGLatLng())
    let updateLatLng = PublishRelay<LatLngUpdateAttribute>()

    // MARK: - AvatarPreview
    private(set) var avatarPreviewViewModel: AvatarPreviewViewModel

    enum AvatarPreviewEventType {
        case avatarDeco
        case changeName
    }
    private(set) var avatarPreviewEventRelay = PublishRelay<AvatarPreviewEventType>()

    init(_ avatarPreviewViewModel: AvatarPreviewViewModel) {
        self.avatarPreviewViewModel = avatarPreviewViewModel
    }

    let showLocationPermissionRelay = PublishRelay<Void>()
    func checkLocationPermission() {
        WDPermissionManager.shared.checkLocationPermission { [weak self] permissionState in
            guard let self = self else { return }
            switch permissionState {
            case .granted:
                break
            case .notGranted:
                self.showLocationPermissionRelay.accept(())
            case .notDetermined:
                WDPermissionManager.shared.reqMotionPermission { _ in
                    print("StepUp page에서 권한 요청")
                }
            }
        }
    }

    // MARK: For Collection View
    var numberOfSections: Int {
        MainSectionType.allCases.count
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        switch MainSectionType.allCases[section] {
        case .chattingLounge:
            let list = chattingLoungeList.value
            let reseultCnt = list.count > 6 ? 6 : list.count
            return !list.isEmpty ? reseultCnt : 1
        case .liveSeminar:
            let list = liveSeminarList.value
            return !list.isEmpty ? list.count : 1
        case .ttcLecture:
            return 1
        case .createSeminarBanner:
            return 1
        case .recommendMeta:
            return recommendList.value.count
        case .event:
            return eventList.value.count
        case .twoDNFT:
            return 2
        }
    }

    var isUniversityConfirmed: Bool {
        repository.member.value.isUniversityConfirm
    }

    func entranceButtonTapWithUnitySwitchScene() -> Signal<(videoUrl: String,
                                                            item: ChattingLoungeChattingRoomList.Item)> {
        entranceButtonTap
            .flatMap { [weak self] data in
                guard let self = self else {
                    return Observable<(videoUrl: String, item: ChattingLoungeChattingRoomList.Item)>.empty()
                }
                return self.repository.getNewSeminarLoungeVideoURL().map {
                    ($0, data)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    // MARK: For Recomend Meta Cells
    enum RecommendMetaType {
        case available(universityCode: String)
        case needUniversityconfirm
        case avatarNotExist
    }
    func getRecommendMetaInfo(_ index: Int) -> RecommendMetaType? {
        if isUniversityConfirmed == false {
            return .needUniversityconfirm
        } else if !repository.hasAvaterAttr.value {
            return .avatarNotExist
        } else if repository.hasAvaterAttr.value {
            let universityCode = recommendList.value[index].uniCode
            return .available(universityCode: universityCode)
        } else {
            return nil
        }
    }

    // MARK: For Event Cells
    enum MainEventType {
        case web(path: String)
        case universityConfirmed(path: String)
        case universityNotConfirmed(path: String)
    }
    func getMainEventInfo(_ index: Int) -> MainEventType? {
        let splits = eventList.value[index].detailPath.split(separator: ":")
        guard let scheme = splits.first else {
            return nil
        }
        let path = String(splits.last ?? "")

        if scheme == "W" {
            return .web(path: path)
        } else if scheme == "N" && path == "stu" && isUniversityConfirmed == true {
            return .universityConfirmed(path: path)
        } else if scheme == "N" && path == "stu" && isUniversityConfirmed == false {
            return .universityNotConfirmed(path: path)
        } else {
            return nil
        }
    }

    // MARK: For 2D 캠퍼스 & NFT Cells
    enum TwoDNFTType {
        case goTwoDCampus
        case goRegisterUniversity
        case goNFTWebView
        case goToSetting
    }
    func getMainTwoDNFTInfo(_ index: Int) -> TwoDNFTType? {
        if index == 1 {
            return .goNFTWebView
        } else if index == 0 && isUniversityConfirmed == true {
            return .goTwoDCampus
        } else if index == 0 && isUniversityConfirmed == false {
            return .goRegisterUniversity
        } else {
            return nil
        }
    }

    func presentUpdateLocation() -> Observable<UpdateMyLatLngResultDto> {
        updateLatLng
            .flatMap { [weak self] in
                guard let self = self else { return Observable<UpdateMyLatLngResultDto>.empty() }
                return self.repository.uploadLocation(lat: $0.lat, lng: $0.lng, isLocationExpose: $0.isLocationExpose)
            }
    }
}
