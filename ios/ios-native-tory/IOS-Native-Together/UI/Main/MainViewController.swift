//
//  MainViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/08.
//

import UIKit
import RxSwift
import RxCocoa
import NMapsMap
import CoreLocation

final class MainViewController: RefactoringBaseViewController<MainViewModel> {
    static var bannerShowFlag = false
    typealias MainSectionType = MainViewModel.MainSectionType
    private let logoNavigationItem = UIImageView()
    private let mypageNavigationItem = UIImageView()
    private let alarmNavigationItem = UIImageView()
    private let talkNavigationItem = UIImageView()

    private let loungeButtonView = ToryLoungeButtonView()
    private lazy var mainAvatarContainerView = MainAvatarContainerView(viewModel)
    private let chattingLoungeSize = ChattingLoungeCollectionViewCell().intrinsicContentSize
    private let liveSeminarSize = LiveSeminarCollectionViewCell().intrinsicContentSize
    private let recommendSize = RecommendMetaCollectionViewCell().intrinsicContentSize

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.register(EventIndicatorSupplementView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: String(describing: EventIndicatorSupplementView.self))
        $0.register(NewMainCollectionViewSectionHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: String(describing: NewMainCollectionViewSectionHeader.self))
        $0.register(EmptyCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: EmptyCollectionViewCell.self))
        $0.register(ChattingLoungeCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: ChattingLoungeCollectionViewCell.self))
        $0.register(LiveSeminarCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: LiveSeminarCollectionViewCell.self))
        $0.register(EventCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: EventCollectionViewCell.self))
        $0.register(RecommendMetaCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: RecommendMetaCollectionViewCell.self))
        $0.register(TTCLectureCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: TTCLectureCollectionViewCell.self))
        $0.register(ToDCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: ToDCollectionViewCell.self))
    }

    private var subView: EventIndicatorSupplementView?
    /*
     위치 정보
     */
    private let locationManager = WDPermissionManager.shared.locationManager.then {
        $0.distanceFilter = 10
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.requestWhenInUseAuthorization()
        $0.startUpdatingLocation()
    }

    /*
     뚜벅이 걸음수
     */
    private var pedoMeter = WDPermissionManager.shared.pedoMeter
    private let canStep = BehaviorRelay<Void>(value: ())

    /*
     위치 권한 설정 문구
     */
    private var locationAlert: CommonModal?

    /*
     리프레쉬
     */
    private let refreshControl = UIRefreshControl()

    private let seminarManager = SeminarManager()
    private let loungeManager = LoungeManager()

    private let webViewModel = CommonWebViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        startStepUpdate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.avatarPreviewViewModel.avatarRegisterRelay.accept(())
        /*
         LiveSeminarUpdate
         */
        repository.newMainSeminarReload.accept(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        PushNotificationManager.globalNavigationRelay?.accept(navigationController)
        /*
         여기서 시그널 계속 주자!!
         */
        if !MainViewController.isFromFestival {
            showEventBannerModal()
            viewModel.avatarPreviewViewModel.metaExsit.accept(())
        }
    }
    static var isFromFestival = false
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MainViewController.isFromFestival = false
    }

    override func attribute() {
        super.attribute()
        locationManager.delegate = self
        collectionView.collectionViewLayout = self.registerLayout()
        collectionView.delegate = self
        collectionView.dataSource = self

        logoNavigationItem.image = R.image.toryMeta_logo()
        mypageNavigationItem.image = R.image.newMain_mypage()
        alarmNavigationItem.image = R.image.newMain_alarm()
        talkNavigationItem.image = R.image.newMain_talk()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoNavigationItem)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mypageNavigationItem),
                                              UIBarButtonItem(customView: alarmNavigationItem),
                                              UIBarButtonItem(customView: talkNavigationItem)]
    }

    override func layout() {
        super.layout()
        // MARK: Navigation
        [
            mypageNavigationItem,
            alarmNavigationItem,
            talkNavigationItem
        ].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(40)
            }
        }

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.refreshControl.bounds = CGRect(x: self.refreshControl.frame.origin.x,
                                                y: self.mainAvatarContainerView.height,
                                                width: self.refreshControl.bounds.width,
                                                height: self.refreshControl.bounds.height)
        }

        collectionView.contentInset = UIEdgeInsets(top: mainAvatarContainerView.height, left: 0, bottom: 0, right: 0)
        mainAvatarContainerView.frame = CGRect(x: 0, y: -mainAvatarContainerView.height,
                                     width: UIScreen.main.bounds.width, height: mainAvatarContainerView.height)
        view.addSubviews(collectionView, loungeButtonView)
        collectionView.addSubviews(refreshControl, mainAvatarContainerView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        loungeButtonView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    // swiftlint:disable function_body_length
    override func bind(_ viewModel: MainViewModel) {
        super.bind(viewModel)

        mypageNavigationItem.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                let mypageViewModel = MypageViewModel()
                let mypageViewController = MypageViewController(viewModel: mypageViewModel)

                self?.presentNavigationViewController(viewController: mypageViewController, title: "")
            })
            .disposed(by: disposeBag)

        alarmNavigationItem.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                let url = ToryWebViewURL(path: ToryWebViewURLType.notice.path)
                let viewModel = CommonWebViewModel()
                let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewModel)

                self?.presentNavigationViewController(viewController: commonWebViewController, title: "")
            })
            .disposed(by: disposeBag)

        talkNavigationItem.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                let friendListViewModel = FriendListViewModel()
                let friendListViewController = FriendListViewController(viewModel: friendListViewModel)

                self?.presentNavigationViewController(viewController: friendListViewController)
            })
            .disposed(by: disposeBag)

        repository.isForground
            .filter { $0 }
            .flatMap { _ in
                viewModel.repository.getLiveSeminarList()
            }
            .bind(to: viewModel.liveSeminarList)
            .disposed(by: disposeBag)

        repository.isForground
            .filter { $0 }
            .flatMap { _ in
                viewModel.repository.getChattingLoungeChattingRoomList(detailSelectOption: .all)
            }
            .bind(to: viewModel.chattingLoungeList)
            .disposed(by: disposeBag)

        /*
         MainPage Update
         */
        repository.newMainSeminarReload
            .flatMap {
                viewModel.repository.getLiveSeminarList()
            }
            .bind(to: viewModel.liveSeminarList)
            .disposed(by: disposeBag)

        repository.newMainSeminarReload
            .flatMap {
                viewModel.repository.getChattingLoungeChattingRoomList(detailSelectOption: .all)
            }
            .bind(to: viewModel.chattingLoungeList)
            .disposed(by: disposeBag)

        viewModel.chattingLoungeList
            .bind(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel.liveSeminarList
            .bind(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        repository.getRecommendMetaList()
            .bind(to: viewModel.recommendList)
            .disposed(by: disposeBag)

        viewModel.recommendList
            .bind(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        repository.getEventBannerList()
            .bind(to: viewModel.eventList)
            .disposed(by: disposeBag)

        viewModel.eventList
            .bind(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        /*
         Seminar 대응
         */
        seminarManager.presentEnterMetaverse(viewController: self)
            .emit()
            .disposed(by: disposeBag)

        seminarManager.presentMySeminar()
            .emit()
            .disposed(by: disposeBag)

        seminarManager.presentApply()
            .emit()
            .disposed(by: disposeBag)

        /*
         lounge ButtonTap
         */
        loungeButtonView.loungeButton.rx.baseTapGesture()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Void>.empty() }
                return self.loungeManager.presentEntranceLounge(viewController: self)
            }
            .subscribe()
            .disposed(by: disposeBag)

        webViewModel.festivalRelay
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Void>.empty() }
                return self.loungeManager.presentEntranceLounge(viewController: self, isFestival: true)
            }
            .subscribe()
            .disposed(by: disposeBag)

        viewModel.showEventBanner
            .bind(onNext: { [weak self] in
                guard let self = self else { return }

                if !self.userDefaultManager.isEventBannerNotShow {
                    if !self.repository.eventBannerList.value.isEmpty {

                        let bottomSlideBannerViewModel = BottomSlideBannerViewModel()
                        let bottomSlideBannerViewController
                        = BottomSlideBannerViewController(viewModel: bottomSlideBannerViewModel)
                        bottomSlideBannerViewController.setEventButtonTapDelegate { [weak self] in
                            guard let self = self else { return }
                            switch $0 {
                            case .web(let detailPath):
                                let url = ToryWebViewURL(eventBannerDetail: detailPath)
//                                let viewModel = CommonWebViewModel()
                                let commonWebViewController = CommonWebViewController(urlProtocol: url,
                                                                                      viewModel: webViewModel)

                                self.presentViewController(viewController: commonWebViewController,
                                                           modalTransitionStyle: .coverVertical,
                                                           modalPresentationStyle: .fullScreen)
                            case .nativeStepUp:
                                let stepUpViewModel = StepUpViewModel(canStep: self.canStep.asObservable())
                                let stepUpViewController = StepUpViewController(viewModel: stepUpViewModel)

                                self.presentNavigationViewController(viewController: stepUpViewController,
                                                                     title: localizable.stepUpTitle())

                            case .ttcLecture:
                                self.showTTCLecture(fromBanner: true)
                            }
                        }
                        self.presentPanmodal(panModel: bottomSlideBannerViewController, backgroundColor: .clear)
                    }
                }
            })
            .disposed(by: disposeBag)

        /*
         리프레쉬
         */
        refreshControl.rx.controlEvent(.valueChanged)
            .flatMap {
                viewModel.repository.getLiveSeminarList()
            }
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] in
                self?.viewModel.liveSeminarList.accept($0)
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .flatMap {
                viewModel.repository.getChattingLoungeChattingRoomList(selectOption: .all)
            }
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] in
                self?.viewModel.chattingLoungeList.accept($0)
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

        viewModel.entranceButtonTapWithUnitySwitchScene()
            .emit(onNext: { [weak self] data in
                if data.item.isSecret {
                    let chattingLoungePasswordViewModel
                    = ChattingLoungePasswordViewModel(password: data.item.password, isBackgroundClear: false)
                    let chattingLoungePasswordViewController
                    = ChattingLoungePasswordViewController(viewModel: chattingLoungePasswordViewModel)
                    chattingLoungePasswordViewController.setEntranceAbleDelegate { [weak self] in
                        let status = MetaWorldSceneStatus.chattingLounge(tableID: data.item.tableId,
                                                                         loungeVideoURL: data.videoUrl)
                        let metaWorldViewModel = MetaWorldViewModel(metaworldSceneStatus: status)
                        let metaWorldViewController = MetaWorldViewController(viewModel: metaWorldViewModel)

                        self?.presentViewController(viewController: metaWorldViewController,
                                                    modalTransitionStyle: .crossDissolve,
                                                    modalPresentationStyle: .fullScreen)
                    }
                    self?.presentViewController(viewController: chattingLoungePasswordViewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                } else {
                    let status = MetaWorldSceneStatus.chattingLounge(tableID: data.item.tableId,
                                                                     loungeVideoURL: data.videoUrl)
                    let metaWorldViewModel = MetaWorldViewModel(metaworldSceneStatus: status)
                    let metaWorldViewController = MetaWorldViewController(viewModel: metaWorldViewModel)

                    self?.presentViewController(viewController: metaWorldViewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .fullScreen)
                }
            })
            .disposed(by: disposeBag)

        /*
         Update....
         */
        viewModel.presentUpdateLocation()
            .map { $0.isInRange }
            .bind(to: viewModel.isCheckIn)
            .disposed(by: disposeBag)

        // AvatarPreview
        viewModel.avatarPreviewEventRelay
            .bind { [weak self] eventType in
                guard let self else { return }
                switch eventType {
                case .avatarDeco:
                    let viewModel = AvatarDecoViewModel(viewModel.avatarPreviewViewModel)
                    let avatarDecoViewController = AvatarDecoViewController(viewModel: viewModel)
                    self.pushViewController(viewController: avatarDecoViewController)
                case .changeName:
                    let mainNameChangeViewModel = MainChangeNameViewModel()
                    let mainNameChangeViewController = MainNameChangeViewController(viewModel: mainNameChangeViewModel)

                    self.presentViewController(viewController: mainNameChangeViewController,
                                               modalTransitionStyle: .crossDissolve,
                                               modalPresentationStyle: .overFullScreen,
                                               backgroundColor: .clear)
                }
            }
            .disposed(by: disposeBag)
    }

    private func showEventBannerModal() {
        guard !MainViewController.bannerShowFlag else {
            MainViewController.bannerShowFlag = false
            return
        }
        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.viewModel.showEventBanner.accept(())
            self?.view.isUserInteractionEnabled = true
        }
    }

    private func startStepUpdate() {
        let userDefault = WDUserDefaultManager.shared
        userDefault.save(value: 0, key: WDUserDefaultManager.Key.stepUpBeforeData)

        pedoMeter.startUpdates(from: Date()) { [weak self] data, error in
            guard let self = self else { return }
            if self.repository.member.value.isUniversityConfirm
                && self.permissionManager.checkLocationPermission() == .granted {

                guard let data = data, error == nil else { return }

                let beforeData = userDefault.stepUpBeforeData
                let counting = data.numberOfSteps.intValue - beforeData

                guard counting >= 0 else { return }

                if self.viewModel.isCheckIn.value {
                    let checkInCount = userDefault.checkInCount
                    let newCount = checkInCount + counting
                    userDefault.save(value: newCount, key: WDUserDefaultManager.Key.checkInCount)
                } else {
                    let checkOutCount = userDefault.checkOutCount
                    let newCount = checkOutCount + counting
                    userDefault.save(value: newCount, key: WDUserDefaultManager.Key.checkOutCount)
                }
                /*
                 canStep 전달해야 된다.
                 */
                self.canStep.accept(())

                userDefault.save(value: data.numberOfSteps.intValue, key: WDUserDefaultManager.Key.stepUpBeforeData)
            }
        }
    }

    // MARK: - Section Header
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        /*
         sectionheader size
         */
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .absolute(24))

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )

        sectionHeader.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return sectionHeader
    }

    private func createEventIndicatorView() -> NSCollectionLayoutBoundarySupplementaryItem {
        /*
         sectionheader size
         */
        let sectionHeightSize: CGFloat = 100
        let sectionBottomInset: CGFloat = 40
        let subViewHeightSize: CGFloat = 12

        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .absolute(subViewHeightSize))

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            containerAnchor: NSCollectionLayoutAnchor(edges: .leading,
                                                      absoluteOffset: .init(x: 0,
                                                                            y: (sectionHeightSize / 2)
                                                                            - (sectionBottomInset / 2)
                                                                            - (subViewHeightSize / 2) - 4))
        )

        sectionHeader.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return sectionHeader
    }
}

// MARK: - Sections Lyaout
extension MainViewController {

    private func registerLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, _ in
            guard let self = self else { return nil }
            switch MainSectionType.allCases[sectionNumber] {
            case .chattingLounge:
                return !self.viewModel.chattingLoungeList.value.isEmpty
                ? self.createSectionChattingLounge()
                : self.createSectionEmpty()

            case .liveSeminar:
                return !self.viewModel.liveSeminarList.value.isEmpty
                ? self.createSectionLiveSeminar()
                : self.createSectionEmpty()

            case .createSeminarBanner:
                return self.createSectionEvent(sectionType: .createSeminarBanner)

            case .recommendMeta:
                return self.createSectionRecommendMeta()

            case .ttcLecture:
                return self.createTTCLecture()

            case .event:
                return self.createSectionEvent(sectionType: .event)

            case .twoDNFT:
                return self.createSection2D()
            }
        }
    }

    // MARK: 2 createSectionChattingLounge
    private func createSectionChattingLounge() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(50 + 24))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = .init(top: 0, leading: 16, bottom: 24, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(50 + 24))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item, item, item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 12, leading: 0, bottom: 40, trailing: 0)

        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    // MARK: 3_1 createSectionLiveSeminar
    private func createSectionLiveSeminar() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(liveSeminarSize.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.leading = 16

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .absolute(liveSeminarSize.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        section.contentInsets = .init(top: 12, leading: 0, bottom: 20, trailing: 0)

        return section
    }

    // MARK: 3_2 createSectionEmpty
    private func createSectionEmpty() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(134))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(134))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        section.contentInsets = .init(top: 12, leading: 0, bottom: 20, trailing: 0)

        return section
    }

    // MARK: 4, 6 createSectionEvent
    /*
     0 -> 세미나 개설
     1 -> 이벤트
     */
    private func createSectionEvent(sectionType: MainSectionType) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        var topPadding: CGFloat = 0
        if case .event = sectionType {
            section.orthogonalScrollingBehavior = .groupPaging

            let sectionHeader = self.createSectionHeader()
            let indicatorView = self.createEventIndicatorView()

            section.boundarySupplementaryItems = [indicatorView, sectionHeader]
            topPadding = 12
        }

        section.contentInsets = .init(top: topPadding, leading: 0, bottom: 40, trailing: 0)
        return section
    }

    // MARK: 5 createSectionRecommendMeta
    private func createSectionRecommendMeta() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(recommendSize.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.leading = 16

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .absolute(recommendSize.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        section.contentInsets = .init(top: 12, leading: 0, bottom: 40, trailing: 0)
        return section
    }

    private func createTTCLecture() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let topPadding: CGFloat = 0

        section.contentInsets = .init(top: topPadding, leading: 0, bottom: 40, trailing: 0)
        return section
    }

    // MARK: 7 createSection2D
    private func createSection2D() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

        let section = NSCollectionLayoutSection(group: group)
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 12, leading: 8, bottom: 156, trailing: 8)
        return section
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int { viewModel.numberOfSections }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(section)
    }

    // MARK: Cell For Item At
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MainSectionType.allCases[indexPath.section] {
        case .chattingLounge:
            let item = viewModel.chattingLoungeList.value
            if !item.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: ChattingLoungeCollectionViewCell.self),
                    for: indexPath) as? ChattingLoungeCollectionViewCell else { return UICollectionViewCell() }
                cell.setUI(item[indexPath.row], isLast: indexPath.row == (item.count - 1))
                cell.bind(data: item[indexPath.row], viewModel)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: EmptyCollectionViewCell.self),
                    for: indexPath) as? EmptyCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(center: localizable.chattingLoungeEmptyMessage())
                return cell
            }
        case .liveSeminar:
            guard !viewModel.liveSeminarList.value.isEmpty else {
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: String(describing: EmptyCollectionViewCell.self),
                                         for: indexPath) as? EmptyCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(center: localizable.noOpenedSeminar())
                return cell
            }

            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: LiveSeminarCollectionViewCell.self),
                                     for: indexPath) as? LiveSeminarCollectionViewCell else {
                return UICollectionViewCell()
            }
            let item = viewModel.liveSeminarList.value[indexPath.row]

            cell.configure(item, self.seminarManager)

            cell.sumbnailImgView.rx.baseTapGesture()
                .bind(onNext: { [weak self] in
                    self?.showLiveSeminarDetail(item.id)
                })
                .disposed(by: cell.disposeBag)

            cell.participateButton.rx.baseTapGesture()
                .flatMap { [weak self] in
                    guard let self = self else { return Observable<Void>.empty() }
                    return self.seminarManager.seminarButtonTapUseCase(viewController: self, item: item)
                }
                .subscribe()
                .disposed(by: cell.disposeBag)
            return cell

        case .createSeminarBanner:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self),
                                     for: indexPath) as? EventCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(imgName: R.image.newMain_create_seminar_banner.name)

            cell.createButton.rx.baseTapGesture()
                .bind(onNext: { [weak self] in
                    self?.createSeminarDetail()
                })
                .disposed(by: cell.disposeBag)
            return cell

        case .recommendMeta:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: RecommendMetaCollectionViewCell.self),
                                     for: indexPath) as? RecommendMetaCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(viewModel.recommendList.value[indexPath.row])

            cell.entranceButton.rx.baseTapGesture()
                .bind { [weak self] in
                    self?.showRecommendMetaDetail(indexPath.item)
                }
                .disposed(by: cell.disposeBag)
            return cell

        case .ttcLecture:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: TTCLectureCollectionViewCell.self),
                                     for: indexPath) as? TTCLectureCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.enterTTCLectureButton.rx.controlEvent(.touchUpInside)
                .bind { [weak self] in
                    self?.showTTCLecture(fromBanner: false)
                }
                .disposed(by: cell.disposeBag)
            return cell

        case .event:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self),
                                     for: indexPath) as? EventCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(imgUrl: viewModel.eventList.value[indexPath.row].cardImgUrl)

            cell.rx.baseTapGesture()
                .bind { [weak self] in
                    self?.showEventDetail(indexPath.item)
                }
                .disposed(by: cell.disposeBag)
            return cell

        case .twoDNFT:
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: ToDCollectionViewCell.self),
                                     for: indexPath) as? ToDCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(viewModel.toDList.value[indexPath.row])

            cell.rx.baseTapGesture()
                .bind { [weak self] in
                    self?.showMainTwoDNFTDetail(indexPath.item)
                }
                .disposed(by: cell.disposeBag)
            return cell
        }
    }

    private func showLiveSeminarDetail(_ itemID: Int) {
        let seminarScheduleDetailViewModel = SeminarScheduleDetailViewModel(id: itemID)
        let seminarScheduleDetailViewController =
        SeminarScheduleDetailViewController(viewModel: seminarScheduleDetailViewModel)
        self.presentNavigationViewController(viewController: seminarScheduleDetailViewController)
    }

    private func createSeminarDetail() {
        let createSeminarRoomViewModel = CreateSeminarRoomViewModel(id: CreateSeminarRoomViewModel.NEW)
        let createSeminarRoomViewController =
        CreateSeminarRoomViewController(viewModel: createSeminarRoomViewModel)

        presentNavigationViewController(viewController: createSeminarRoomViewController)
    }

    private func showRecommendMetaDetail(_ index: Int) {
        let recommendMetaType = viewModel.getRecommendMetaInfo(index)
        if case let .available(universityCode) = recommendMetaType {
            let status = MetaWorldSceneStatus.university(uniCode: universityCode)
            let metaWorldViewModel = MetaWorldViewModel(metaworldSceneStatus: status)
            let metaWorldViewController = MetaWorldViewController(viewModel: metaWorldViewModel)

            presentViewController(viewController: metaWorldViewController,
                                  modalTransitionStyle: .crossDissolve,
                                  modalPresentationStyle: .fullScreen)

        } else if case .needUniversityconfirm = recommendMetaType {
            let campusSelectViewModel = CampusSelectViewModel(type: .confirm)
            let campusSelectViewController = CampusSelectViewController(viewModel: campusSelectViewModel)
            presentNavigationViewController(viewController: campusSelectViewController)

        } else if case .avatarNotExist = recommendMetaType {
            CommonModal.Builder()
                .setMessage(localizable.selectAvatar())
                .setPositiveButton(localizable.confirm()) {
                    $0.dismiss(animated: true)
                }
                .build()
                .show()
        }
    }

    private func showTTCLecture(fromBanner: Bool) {
        let analyticsID = fromBanner ?
            AnalyticsManager.mobileBottomTTCClassroom : AnalyticsManager.mobileTTCMyClassroom
        AnalyticsManager.setAnalytics(analyticsID, ["type": AnalyticsManager.osName,
                                                    "member_id": repository.member.value.memberId])

//        if viewModel.isUniversityConfirmed {
            let curriculumListViewModel = TTCCurriculumListViewModel()
            let curriculumListViewController = TTCCurriculumListViewController(viewModel: curriculumListViewModel)
            pushViewController(viewController: curriculumListViewController)
//        } else {
//            let campusSelectViewController = CampusSelectViewController()
//            let viewModel = CampusSelectViewModel(type: .confirm)
//            campusSelectViewController.bind(viewModel)
//            presentNavigationViewController(vc: campusSelectViewController)
//        }
    }

    private func showEventDetail(_ index: Int) {
        let mainEventInfo = self.viewModel.getMainEventInfo(index)
        if case let .web(path) = mainEventInfo {
            let url = ToryWebViewURL(eventBannerDetail: String(path))
            let viewModel = CommonWebViewModel()
            let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: webViewModel)

            self.presentViewController(viewController: commonWebViewController,
                                       modalTransitionStyle: .coverVertical,
                                       modalPresentationStyle: .fullScreen)

        } else if case .universityConfirmed = mainEventInfo {
            let stepUpViewModel = StepUpViewModel(canStep: self.canStep.asObservable())
            let stepUpViewController = StepUpViewController(viewModel: stepUpViewModel)

            self.presentNavigationViewController(viewController: stepUpViewController, title: localizable.stepUpTitle())

        } else if case .universityNotConfirmed = mainEventInfo {
            let campusSelectViewModel = CampusSelectViewModel(type: .confirm)
            let campusSelectViewController = CampusSelectViewController(viewModel: campusSelectViewModel)
            self.presentNavigationViewController(viewController: campusSelectViewController)
        }
    }

    private func showMainTwoDNFTDetail(_ index: Int) {
        let twoDNFTType = viewModel.getMainTwoDNFTInfo(index)
        if case .goTwoDCampus = twoDNFTType {
            WDPermissionManager.shared.checkLocationPermission { [weak self] in
                guard let self = self else { return }
                if index == 0 {
                    switch $0 {
                    case .granted:
                        let campusViewModel = CampusViewModel(isCheckIn: self.viewModel.isCheckIn,
                                                              myCurrentPosition: self.viewModel.myCurrentPosition)
                        let campusViewController = CampusViewController(viewModel: campusViewModel)

                        self.presentNavigationViewController(viewController: campusViewController)
                    case .notGranted:
                        CommonModal.Builder()
                            .setTitle(localizable.appSettings())
                            .setMessage(localizable.locationGrant())
                            .setNagativeButton(localizable.appSettingNagativeButtonText()) {
                                $0.dismiss(animated: true)
                            }
                            .setPositiveButton(localizable.openSetting()) {
                                $0.dismiss(animated: true) { [weak self] in
                                    self?.showIOSSetting()
                                }
                            }
                            .build()
                            .show()
                    case .notDetermined:
                        self.permissionManager.reqLocationPermission()
                    }
                }
            }
        } else if case .goRegisterUniversity = twoDNFTType {
            let campusSelectViewModel = CampusSelectViewModel(type: .confirm)
            let campusSelectViewController = CampusSelectViewController(viewModel: campusSelectViewModel)

            self.presentNavigationViewController(viewController: campusSelectViewController)

        } else if case .goNFTWebView = twoDNFTType {
            let url = NFTWebViewURL()
            let viewModel = CommonWebViewModel()
            let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewModel)

            self.presentNavigationViewController(viewController: commonWebViewController)
        }
    }

    private func showSeminarMain() {
        let seminarMainViewModel = SeminarMainViewModel()
        let seminarMainVerticalViewController = SeminarMainVerticalViewController(viewModel: seminarMainViewModel)
        pushViewController(viewController: seminarMainVerticalViewController)
    }

    // MARK: HeaderView 설정
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            subView = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
                                                    String(describing: EventIndicatorSupplementView.self),
                                                  for: indexPath) as? EventIndicatorSupplementView
            subView?.pageControl.numberOfPages = viewModel.eventList.value.count
            return subView!
        } else if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
                                                    String(describing: NewMainCollectionViewSectionHeader.self),
                                                  for: indexPath) as? NewMainCollectionViewSectionHeader else {
                return UICollectionReusableView()
            }
            switch MainSectionType.allCases[indexPath.section] {
            case .chattingLounge:
                headerView.configure(localizable.chattingLoungeSectionHeaderTitle(), isMoreLabelHidden: false)
                headerView.moreLabel.rx.baseTapGesture()
                    .bind(onNext: { [weak self] in
                        let chattingLoungeDetailViewModel = ChattingLoungeDetailViewModel()
                        let chattingLoungeDetailViewController
                        = ChattingLoungeDetailViewController(viewModel: chattingLoungeDetailViewModel)
                        self?.pushViewController(viewController: chattingLoungeDetailViewController)
                    })
                    .disposed(by: headerView.disposeBag)

            case .liveSeminar:
                headerView.configure(localizable.liveSeminar(), isMoreLabelHidden: false)
                headerView.moreLabel.rx.baseTapGesture()
                    .bind(onNext: { [weak self] in
                        self?.showSeminarMain()
                    })
                    .disposed(by: headerView.disposeBag)

            case .recommendMeta:
                headerView.configure(localizable.recommendMeta())
            case .event:
                headerView.configure(localizable.event())
            case .twoDNFT:
                headerView.configure(localizable.twoDimensionCampusNFT())
            default:
                break
            }
            return headerView
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if case .event = MainSectionType.allCases[indexPath.section] {
            subView?.pageControl.currentPage = indexPath.row
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        viewModel.myCurrentPosition
            .accept(NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
        viewModel.updateLatLng.accept(LatLngUpdateAttribute(lat: location.coordinate.latitude,
                                                            lng: location.coordinate.longitude,
                                                            isLocationExpose:
                                                                repository.member.value.isLocationExpose))
//        print("🧊 location \(location.coordinate.latitude) ::: \(location.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("CampusLocation Error: \(error.localizedDescription)")
    }
}
