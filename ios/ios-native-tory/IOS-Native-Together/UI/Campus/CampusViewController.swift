//  ChampusViewController.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/26.

import UIKit
import RxSwift
import RxCocoa
import NMapsMap
import CoreLocation
import RxGesture
import Kingfisher
import PanModal
import CoreMotion

// swiftlint:disable type_body_length
final class CampusViewController: RefactoringBaseViewController<CampusViewModel> {

    override var analyticsId: String { AnalyticsManager.campus }

    private var isViewWillAppearFirst = true
    private var isBannerFirst = true

    private let goToSeminaButton = WilldUIImageView().then {
        $0.image = R.image.semina_goTo()
    }

    private lazy var myMarker = map.mapView.locationOverlay.then {
        $0.hidden = false
        $0.touchHandler = markerTouchHandler
    }
    private var friendMarkers: [NMFMarker] = []
    private var buildingMarkers: [NMFMarker] = []

    private var campusPlayMarker = NMFMarker(position: .init(lat: 0.0, lng: 0.0))

    private let map = NMFNaverMapView()

    lazy var markerTouchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
        guard let self, let campusCode = overlay.userInfo["categoryCode"] as? String else { return true }
        switch campusCode {
        case "FRIEND":
            guard let data = overlay.userInfo["data"] as? FriendMarkerListResultDto.Marker else { return true }
            let friendStateModalViewModel = FriendStateViewModel(memberId: data.memberId)
            let friendStateModal = FriendStateViewController(viewModel: friendStateModalViewModel)
            self.presentPanmodal(panModel: friendStateModal, backgroundColor: .clear)
        case "MY":
            let myStateModalViewModel = MyStateViewModel()
            let myStateModal = MyStateViewController(viewModel: myStateModalViewModel)
            self.presentPanmodal(panModel: myStateModal, backgroundColor: .togetherWhite)
        case "BUILDING":
            guard let data = overlay.userInfo["data"] as? BuildingMarkerListResultDto.Marker else { return true }
            let buildingDetailModalViewModel = BuildingDetailViewModel(markerID: data.markerId)
            let buildingDetailModal = BuildingDetailViewController(viewModel: buildingDetailModalViewModel)
            self.presentPanmodal(panModel: buildingDetailModal, backgroundColor: .togetherWhite)
        default:
            return true
        }
        return true
    }

    private let lock = NSLock()

    private let topIndicatorView = CampusTopIndicatorView()

    private let bottomGuideLine = WilldUIView()

    private let topIndicatorColapseButton = WilldUIImageView()

    private let rightIndicatorView = CampusRightIndicatorView()

    private let rightIndicatorColapseButton = WilldUIImageView.create(size: 44,
                                                              assetsName: R.image.campusInfo_right_bottom_arrow.name,
                                                              type: .plain)

    private var isTopColapse = true
    private var isRightColapse = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        if isViewWillAppearFirst {
            self.isTopColapse = userDefaultManager.isCampusTopColapse
            print("IS_TOP_COLAPSE: \(isTopColapse)")
            self.isRightColapse = userDefaultManager.isCampusRightColapse
            print("IS_RIGHT_COLAPSE: \(isRightColapse)")

            colapasedTop(isTopColapse)

            colapsedRight(isRightColapse)

            isViewWillAppearFirst = false
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    override func bind(_ viewModel: CampusViewModel) {
        super.bind(viewModel)

        Observable.just(permissionManager.locationManager.location?.coordinate)
            .map { NMGLatLng(lat: $0?.latitude ?? 0.0, lng: $0?.longitude ?? 0.0)}
            .bind(onNext: { [weak self] in
                viewModel.currentPosition.accept($0)
                self?.map.mapView.moveCamera(.init(position: .init($0, zoom: 15)))
            })
            .disposed(by: disposeBag)

        // myState.....
        repository.member
            .asDriver(onErrorDriveWith: .empty())
            .map { [weak self] in
                _ = self?.myMarker.then {
                    $0.userInfo = [
                        "categoryCode": "MY",
                        "data": $0
                    ]
                    $0.iconWidth = 44
                    $0.iconHeight = 62
                }
                return $0.imgUrl
            }
            .drive(onNext: { [weak self] urlString in
                guard let self = self else { return }
                let customView = WDCustomMarkerView(frame: .init(x: 0, y: 0, width: 44, height: 62))
                customView.setProfileImageColor(.togetherYellow)
                let url = URL(string: urlString)
                let imgURL = "https://test-torymeta-image.s3.ap-northeast-2.amazonaws.com/"
                    + "basic-profile-image/basic_profile_1.jpg"
                let imgResource = KF.ImageResource(downloadURL: url ?? URL(string: imgURL)!)
                KingfisherManager.shared.retrieveImage(with: imgResource, options: nil, progressBlock: nil) { result in
                    switch result {
                    case.success(let value):
                        customView.profileImgView.image = value.image

                        let customImg = customView.snapshot()
                        let img = NMFOverlayImage(image: customImg!)
                        self.myMarker.icon = img
                    case.failure(let error):
                        print("CustomMarker Error / CustomMarker Type / Code: \(error.localizedDescription)")
                    }
                }
            })
            .disposed(by: disposeBag)

        // current Position.....
        viewModel.currentPosition
            .bind(onNext: { [weak self] in
//                print("잘 찍히는가?")
                self?.myMarker.location = $0
//                self?.myMarker.mapView = self?.map.mapView
            })
            .disposed(by: disposeBag)

        // frien show...

        viewModel.presedentFriendMarkers?
            .map { [weak self] in
                self?.lock.lock()
                defer { self?.lock.unlock() }
                return $0.map { [weak self] friend in
                    NMFMarker(position: .init(lat: friend.latDouble, lng: friend.lngDouble)).then { marker in
                        marker.touchHandler = self?.markerTouchHandler
                        marker.userInfo = [
                            "categoryCode": "FRIEND",
                            "data": friend
                        ]
                        marker.width = 44
                        marker.height = 62

                        let customView = WDCustomMarkerView(frame: .init(x: 0, y: 0, width: 44, height: 62))
                        customView.setProfileImageColor(.togetherPurple)
                        let url = URL(string: friend.imgUrl)
                        let imageURL = "https://test-torymeta-image.s3.ap-northeast-2.amazonaws.com/"
                            + "basic-profile-image/basic_profile_1.jpg"
                        let imgResource = KF.ImageResource(downloadURL: url ?? URL(string: imageURL)!)
                        KingfisherManager.shared.retrieveImage(with: imgResource,
                                                               options: nil,
                                                               progressBlock: nil) { result in
                            switch result {
                            case.success(let value):
                                customView.profileImgView.image = value.image

                                let customImg = customView.snapshot()
                                let image = NMFOverlayImage(image: customImg!)
                                marker.iconImage = image
                            case.failure(let error):
                                print("CustomMarker Error / CustomMarker Type / Code: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                /*
                 먼저 맵에서 삭제
                 */
                self.friendMarkers.forEach {
                    $0.mapView = nil
                }

                /*
                 변경된 값 Update
                 */
                self.friendMarkers.removeAll()
                $0.forEach {
                    self.friendMarkers.append($0)
                }

                /*
                 기존에 있던 marker 초기화
                 */
                self.friendMarkers.forEach {
                    if $0.mapView == nil {
                        $0.mapView = self.map.mapView
                    }
                }
            })
            .disposed(by: disposeBag)

        viewModel.presentMoveToCurrentCamera?
            .emit(onNext: { [weak self] in
                self?.map.mapView.moveCamera(.init(scrollTo: $0, zoomTo: 15))
            })
            .disposed(by: disposeBag)

        viewModel.presentMoveToCampusCamera?
            .emit(onNext: { [weak self] in
                self?.map.mapView.moveCamera(.init(scrollTo: $0, zoomTo: 15))
            })
            .disposed(by: disposeBag)

        // business hide show..
        viewModel.presentBuildingMakrers?
            .map { [weak self] in
                $0.enumerated().map { [weak self] _, building in
                    NMFMarker(position: .init(lat: building.lat, lng: building.lng)).then { marker in
                        marker.touchHandler = self?.markerTouchHandler

                        marker.userInfo = [
                            "categoryCode": "BUILDING",
                            "data": building
                        ]
                        marker.width = 32
                        marker.height = 32
                        let url = URL(string: building.imgUrl)
                        let resource = KF.ImageResource(downloadURL: url!)
                        KingfisherManager.shared.retrieveImage(with: resource,
                                                               options: nil,
                                                               progressBlock: nil) { result in
                            switch result {
                            case .success(let value):
                                let image = NMFOverlayImage(image: value.image)

                                marker.iconImage = image
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    }
                }
            }
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                /*
                 먼저 맵에서 삭제
                 */
                self.buildingMarkers.forEach {
                    $0.mapView = nil
                }

                /*
                 변경된 값 Update
                 */
                self.buildingMarkers.removeAll()
                $0.forEach {
                    self.buildingMarkers.append($0)
                }

                /*
                 기존에 있던 marker 초기화
                 */
                self.buildingMarkers.forEach {
                    if $0.mapView == nil {
                        $0.mapView = self.map.mapView
                    }
                }
            })
            .disposed(by: disposeBag)

        viewModel.presentBusinessMarkerHide?
            .drive(onNext: { [weak self] isHidden in
                guard let self = self else { return }
                self.rightIndicatorView.changeMarker(isMarkerHide: isHidden)

                /*
                 Maker 없애기...
                 */
                self.buildingMarkers.forEach {
                    if isHidden {
                        $0.mapView = nil
                    } else {
                        $0.mapView = self.map.mapView
                    }
                }
            })
            .disposed(by: disposeBag)

        viewModel.presentLocationAgreeUI?
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                self.rightIndicatorView.changeOnOff(isOn: $0)
                /*
                 토스트 메세지 보여주기
                 */
                let message: String = $0 ?
                    localizable.campusEnableShareLocation(): localizable.campusDisableShareLocation()
                CommonToast.Builder()
                    .setMessage(message)
                    .build()
                    .show()
            })
            .disposed(by: disposeBag)

        viewModel.presentPlayMarker?
            .skip(1)
            .drive(onNext: { [weak self] in
                self?.campusPlayMarker.mapView = self?.map.mapView

                self?.campusPlayMarker.width = 44
                self?.campusPlayMarker.height = 44
                self?.campusPlayMarker.position = NMGLatLng(lat: $0.lat, lng: $0.lng)
                self?.map.mapView.moveCamera(.init(position: .init(.init(lat: $0.lat, lng: $0.lng), zoom: 15)))

                let url = URL(string: $0.imgUrl)
                let resource = KF.ImageResource(downloadURL: url!)
                KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                    switch result {
                    case .success(let value):
                        let image = NMFOverlayImage(image: value.image)
                        self?.campusPlayMarker.iconImage = image
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            })
            .disposed(by: disposeBag)

        viewModel.isOnAirShow
            .map { !$0 }
            .bind(to: goToSeminaButton.rx.isHidden)
            .disposed(by: disposeBag)

        topIndicatorColapseButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.colapasedTop()
            })
            .disposed(by: disposeBag)

        rightIndicatorColapseButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.colapsedRight()
            })
            .disposed(by: disposeBag)

        topIndicatorView.setItemSelectedDelegate { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case 0:
                let boardSelectViewModel = BoardSelectViewModel()
                let boardSelectViewControlle = BoardSelectViewController(viewModel: boardSelectViewModel)
                boardSelectViewControlle.setDelegate {
                    let url = ToryWebViewURL(path: $0)
                    let viewmodel = CommonWebViewModel()
                    let viewController = CommonWebViewController(urlProtocol: url, viewModel: viewmodel)

                    self.pushViewController(viewController: viewController, title: "")
                }
                self.presentPanmodal(panModel: boardSelectViewControlle, backgroundColor: .clear)
            case 1:
                let url = ToryWebViewURL(path: ToryWebViewURLType.food.path)
                let viewmodel = CommonWebViewModel()
                let viewController = CommonWebViewController(urlProtocol: url, viewModel: viewmodel)

                self.pushViewController(viewController: viewController, title: "")
            case 2:
                let url = ToryWebViewURL(path: ToryWebViewURLType.event.path)
                let viewmodel = CommonWebViewModel()
                let viewCotroller = CommonWebViewController(urlProtocol: url, viewModel: viewmodel)

                self.pushViewController(viewController: viewCotroller, title: "")
            case 3:
                let campusPlayModalViewModel =
                    CampusPlayViewModel(selectCampus: viewModel.campusPlayItemButtonTap.value)
                let campusPlayModal = CampusPlayViewController(viewModel: campusPlayModalViewModel)
                campusPlayModal.setDelegate {
                    viewModel.campusPlayItemButtonTap.accept($0)
                }
                self.presentPanmodal(panModel: campusPlayModal, backgroundColor: .togetherWhite)
            default:
                break
            }
        }

        rightIndicatorView.setItemSelectedDelegate { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case 0:
                viewModel.moveToCurrentPositionTap.accept(())
            case 1:
                self.map.mapView.moveCamera(.withZoomIn())
            case 2:
                self.map.mapView.moveCamera(.withZoomOut())
            case 3:
                viewModel.locaitonAgreeButtonTap.accept(.init())
            case 4:
                viewModel.businessHideButtonTap.accept(.init())
            case 5:
                viewModel.moveToCampusPositionTap.accept(.init())
            default:
                break
            }
        }

        topIndicatorView.closeButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                CommonModal.Builder()
                    .setMessage(localizable.campusOut())
                    .setPositiveButton(localizable.campusOutYes()) {
                        $0.dismiss(animated: true)
                        self.dismiss(animated: true)
                    }
                    .setPositiveButtonColor(.togetherBlack)
                    .setNagativeButton(localizable.campusOutNo()) {
                        $0.dismiss(animated: true)
                    }
                    .setNagativeButtonColor(.togetherPurple)
                    .build()
                    .show()
            })
            .disposed(by: disposeBag)

        /*
         FriendUpdate...
         */

        viewModel.campusFriendUploadRetry
            .flatMap {
                viewModel.repository.getFriendMarkerList()
            }
            .bind(to: viewModel.friendMarkerLngLngList)
            .disposed(by: disposeBag)

        viewModel.friendUpdate?
            .bind(to: viewModel.friendMarkerLngLngList)
            .disposed(by: disposeBag)

        repository.isSeminarOnAirShow
            .bind(to: viewModel.isOnAirShow)
            .disposed(by: disposeBag)
    }

    override func attribute() {
        map.mapView.touchDelegate = self

        map.showZoomControls = false
    }

    override func layout() {
        view.addSubviews(map, goToSeminaButton,
                         topIndicatorView, bottomGuideLine, topIndicatorColapseButton,
                         rightIndicatorView, rightIndicatorColapseButton)

        map.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        goToSeminaButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        topIndicatorView.snp.updateConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }

        bottomGuideLine.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(topIndicatorView)
        }

        topIndicatorColapseButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(bottomGuideLine)
        }

        rightIndicatorView.snp.updateConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(188)
            $0.width.equalTo(44)
            $0.height.equalTo(92)
        }

        rightIndicatorColapseButton.snp.makeConstraints {
            $0.centerX.equalTo(rightIndicatorView)
            $0.bottom.equalTo(rightIndicatorView).inset(-10)
        }
    }

    func colapasedTop(_ isColapse: Bool) {
        changeTopArrowButton(isColapse)
        let height: CGFloat = isTopColapse ? topIndicatorView.minSize: topIndicatorView.maxSize
        self.topIndicatorView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }

    func colapasedTop() {
        isTopColapse = !isTopColapse
        /*
         저장
         */
        self.userDefaultManager.save(value: self.isTopColapse, key: WDUserDefaultManager.Key.isCampusTopColapse)

        changeTopArrowButton(self.isTopColapse)
        let height: CGFloat = isTopColapse ? topIndicatorView.minSize: topIndicatorView.maxSize
        UIView.animate(withDuration: 0.2) {
            self.topIndicatorView.snp.updateConstraints {
                $0.height.equalTo(height)
            }
            self.view.layoutIfNeeded()
        }
    }

    func colapsedRight(_ isColapse: Bool) {
        changeRightArrowButton(isColapse)
        self.rightIndicatorView.showAndHide(isColapse: isColapse)
        let height: CGFloat = isRightColapse ? 92: 330
        self.rightIndicatorView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }

    func colapsedRight() {
        isRightColapse = !isRightColapse
        /*
         저장
         */
        self.userDefaultManager.save(value: self.isRightColapse, key: WDUserDefaultManager.Key.isCampusRightColapse)
        self.changeRightArrowButton(self.isRightColapse)

        if isRightColapse {
            self.rightIndicatorView.showAndHide(isColapse: self.isRightColapse)
        }

        let height: CGFloat = isRightColapse ? 92: 330
        UIView.animate(withDuration: 0.2) {
            self.rightIndicatorView.snp.updateConstraints {
                $0.height.equalTo(height)
            }
            self.view.layoutIfNeeded()
        } completion: { _ in
            if !self.isRightColapse {
                self.rightIndicatorView.showAndHide(isColapse: self.isRightColapse)
            }
        }
    }

    func changeTopArrowButton(_ isCollapse: Bool) {
        if isCollapse {
            self.topIndicatorColapseButton.image = R.image.campusInfo_arrow_bottom()
        } else {
            self.topIndicatorColapseButton.image = R.image.campusInfo_arrow_top()
        }

    }

    func changeRightArrowButton(_ isCollapse: Bool) {
        if isCollapse {
            self.rightIndicatorColapseButton.image = R.image.campusInfo_right_top_arrow()
        } else {
            self.rightIndicatorColapseButton.image = R.image.campusInfo_right_bottom_arrow()
        }
    }
}
extension CampusViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("\(latlng.lat) :::: \(latlng.lng)")
    }

    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        return true
    }
}
