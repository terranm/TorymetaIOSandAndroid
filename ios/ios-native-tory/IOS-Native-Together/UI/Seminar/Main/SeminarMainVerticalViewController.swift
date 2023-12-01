//
//  SeminarMainVerticalViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa

final class SeminarMainVerticalViewController: RefactoringBaseViewController<SeminarMainViewModel> {

    override var analyticsId: String { AnalyticsManager.seminarCenter }
    override var navigationTitle: String { localizable.seminarMainTitle() }

    private let listUpdate = PublishRelay<Void>()
    private let mySeminarNavigationButton = UIImageView()
    private let seminarCalenderNavigationButton = UIImageView()
    private let seminarSearchView = SeminarSearchView()
    private let seminarFilterView = SeminarMainFilterView()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let createButton = UIImageView()
    private let upButton = UIImageView()
    private let loungeButtonView = ToryLoungeButtonView()
    private let emptyLabel = UILabel()
    private let refreshControl = UIRefreshControl()

    private let seminarManager = SeminarManager()
    private let loungeManager = LoungeManager()
    /*
     상단으로 옮기는가에 대한 변수
     */
    private var isListTopScroll = false

    override func attribute() {
        super.attribute()
        collectionView.dataSource = self
        collectionView.delegate = self

        mySeminarNavigationButton.image = R.image.seminar_My()
        seminarCalenderNavigationButton.image = R.image.seminar_Calendar()

        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mySeminarNavigationButton),
                                              UIBarButtonItem(customView: seminarCalenderNavigationButton)]

        flowLayout.minimumLineSpacing = 30
        flowLayout.minimumInteritemSpacing = 8
        let width: CGFloat = (view.frame.width - 32) / 2
        let height = SeminarMainSeminarItemCollectionViewCell().intrinsicContentSize.height
        flowLayout.itemSize = .init(width: width - 8, height: height)

        collectionView.contentInset = .init(top: 0, left: 0, bottom: 88, right: 0)
        collectionView.register(SeminarMainSeminarItemCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: SeminarMainSeminarItemCollectionViewCell.self))

        createButton.image = R.image.seminar_create()
        upButton.image = R.image.seminar_up()

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.text = localizable.seminarMainNoPlanToday()
        emptyLabel.textColor = .togetherGray2

    }

    override func layout() {
        super.layout()
        mySeminarNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        seminarCalenderNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        view.addSubviews(seminarSearchView, seminarFilterView, collectionView, createButton, upButton,
                         loungeButtonView, emptyLabel)
        collectionView.addSubview(refreshControl)
        seminarSearchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        seminarFilterView.snp.makeConstraints {
            $0.top.equalTo(seminarSearchView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(seminarFilterView.snp.bottom).offset(33)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        loungeButtonView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }

        createButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.equalTo(loungeButtonView).inset(16)
            $0.bottom.equalTo(loungeButtonView.snp.top).offset(-14)
        }

        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.equalTo(createButton)
            $0.bottom.equalTo(createButton.snp.top).offset(-16)
        }

        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView).inset(60)
            $0.centerX.equalToSuperview()
        }
    }

    // swiftlint:disable function_body_length
    override func bind(_ viewModel: SeminarMainViewModel) {
        super.bind(viewModel)

        mySeminarNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let seminarPagerViewModel = SeminarPagerViewModel()
                let seminarPagerViewController = SeminarPagerViewController(viewModel: seminarPagerViewModel)

                self?.pushViewController(viewController: seminarPagerViewController, title: "")
            })
            .disposed(by: disposeBag)

        seminarCalenderNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let singleCalendarViewModel = SingleCalendarViewModel()
                let sigleCalendarViewController = SigleCalendarViewController(viewModel: singleCalendarViewModel)

                self?.pushViewController(viewController: sigleCalendarViewController, title: "")
            })
            .disposed(by: disposeBag)

        seminarSearchView.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let seminarSearchViewModel = SeminarSearchViewModel()
                let seminarSearchViewController = SeminarSearchViewController(viewModel: seminarSearchViewModel)

                self.presentNavigationViewController(viewController: seminarSearchViewController, title: "")
            })
            .disposed(by: disposeBag)

        viewModel.filter
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.seminarFilterView.presentButtonTap(filter: $0)
            })
            .disposed(by: disposeBag)

        seminarFilterView.setButtonTapDelegate {
            viewModel.filter.accept($0)
        }

        repository.seminarMainReload
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[LiveSeminarListResultDto.Item]>.empty() }
                return self.filterUseCase(isListTopScroll: false, type: viewModel.filter.value)
            }
            .bind(to: viewModel.seminarList)
            .disposed(by: disposeBag)

        viewModel.filter
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[LiveSeminarListResultDto.Item]>.empty() }
                return self.filterUseCase(isListTopScroll: true, type: $0)
            }
            .bind(to: viewModel.seminarList)
            .disposed(by: disposeBag)

        viewModel.seminarList
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.collectionView.reloadData()
                if self.isListTopScroll {
                    if !$0.isEmpty {
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
                    }
                }
            })
            .disposed(by: disposeBag)

        createButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let createSeminarRoomViewModel = CreateSeminarRoomViewModel(id: CreateSeminarRoomViewModel.NEW)
                let createSeminarRoomViewController =
                    CreateSeminarRoomViewController(viewModel: createSeminarRoomViewModel)

                self.presentNavigationViewController(viewController: createSeminarRoomViewController, title: "")
            })
            .disposed(by: disposeBag)

        upButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let indexPath = IndexPath(row: 0, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            })
            .disposed(by: disposeBag)

        collectionView.rx.contentOffset
            .map { !($0.y > 0) }
            .bind(to: upButton.rx.isHidden)
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

        viewModel.seminarList
            .map {
                $0.isEmpty
            }
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.emptyLabel.isHidden = !$0
//                self.collectionView.isScrollEnabled = !$0
            })
            .disposed(by: disposeBag)

        /*
         리프레쉬
         */
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(onNext: { [weak self] in
                viewModel.repository.seminarMainReload.accept(())
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }

    private func filterUseCase(isListTopScroll: Bool, type: Int) -> Observable<[LiveSeminarListResultDto.Item]> {
        self.isListTopScroll = isListTopScroll
        let params = Date().dateToString(format: "yyyyMMdd")
        let list = viewModel.repository.getSingleScheduleList(date: params)
        switch type {
        case 0:
            return list
        case 1:
            return list.map {
                $0.filter {
                    $0.tagState == SeminarTagState.start
                }
            }
        case 2:
            return list.map {
                $0.filter {
                    $0.tagState == SeminarTagState.standBy
                }
            }
        case 3:
            return list.map {
                $0.filter {
                    $0.tagState == SeminarTagState.closed
                }
            }
        default:
            return list
        }
    }
}

extension SeminarMainVerticalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.seminarList.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: SeminarMainSeminarItemCollectionViewCell.self),
                                 for: indexPath) as? SeminarMainSeminarItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = viewModel.seminarList.value[indexPath.row]
        cell.configure(item, seminarManager)
        cell.thumbnailImgView.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let seminarScheduleDetailViewModel = SeminarScheduleDetailViewModel(id: item.id)
                let seminarScheduleDetailViewController
                = SeminarScheduleDetailViewController(viewModel: seminarScheduleDetailViewModel)

                self.presentNavigationViewController(viewController: seminarScheduleDetailViewController, title: "")
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
    }
}
