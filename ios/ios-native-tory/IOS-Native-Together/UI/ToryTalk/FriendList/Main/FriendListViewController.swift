//
//  FirstVC.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/28.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

final class FriendListViewController: RefactoringBaseViewController<FriendListViewModel> {

    override var navigationTitle: String { localizable.campusToryTalk() }
    override var analyticsId: String { AnalyticsManager.toryTalk }
    private let exitNavigationButton = UIImageView()
    private let settingNavigationButton = UIImageView()
    let tableViewHeader = FriendSearchView()
    let tableView = UITableView(frame: .zero, style: .grouped)

    let refreshControl = UIRefreshControl()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.commonFriendViewModel.isPageDidAppear.accept(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.commonFriendViewModel.isPageDidAppear.accept(true)
    }

    override func attribute() {
        super.attribute()
        exitNavigationButton.image = R.image.default_banner_exit()
        settingNavigationButton.image = R.image.common_setting()

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: exitNavigationButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingNavigationButton)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        tableView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        tableViewHeader.parentViewModel = viewModel
        tableView.tableHeaderView = tableViewHeader
        tableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 1, height: 130))
        tableView.backgroundColor = .togetherWhite
        tableView.separatorStyle = .none
        tableView.register(FriendSectionHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: FriendSectionHeaderView.self))
        tableView.register(FriendEmptyInfoTableViewCell.self,
                           forCellReuseIdentifier: String(describing: FriendEmptyInfoTableViewCell.self))
        tableView.register(FriendInfoTableViewCell.self,
                           forCellReuseIdentifier: String(describing: FriendInfoTableViewCell.self))
    }
    override func layout() {
        super.layout()
        exitNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        settingNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: FriendListViewModel) {
        super.bind(viewModel)

        exitNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        settingNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.showBlockFriendsList()
            }
            .disposed(by: disposeBag)
        /*
         1. Trigger
         */
        if let presentInteractionAction = viewModel.commonFriendViewModel.presentInteractionAction {
            presentInteractionAction
                .emit()
                .disposed(by: disposeBag)
        }

        /*
         2. 화면 상태 업데이트
         */
        repository.friendListReload
            .flatMap {
                viewModel.commonFriendViewModel.stateChangeResult(friendListViewModel: viewModel, interaction: $0)
            }
            .bind {
                guard !$0.isEmpty else { return }
                CommonToast.Builder().setMessage($0).build().show()
            }
            .disposed(by: disposeBag)

        repository.getFriendInfoList()
            .bind(to: viewModel.pageData)
            .disposed(by: disposeBag)

        viewModel.pageData
            .skip(1)
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)

        viewModel.searchButtonTap
            .bind { [weak self] in
                self?.showFriendSearch()
            }
            .disposed(by: disposeBag)

        viewModel.sectionHeaderButtonTap
            .bind { [weak self] friendType in
                self?.showFriendListDetail(friendType)
            }
            .disposed(by: disposeBag)

        viewModel.commonFriendViewModel.friendButtonTap
            .bind { [weak self] rangeFriendInfo in
                self?.showFriendStatus(rangeFriendInfo)
            }
            .disposed(by: disposeBag)

        viewModel.commonFriendViewModel.isShowGoToSettingModal()
            .bind { [weak self] _ in
                self?.showSettingModal()
            }
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .flatMap { viewModel.repository.getFriendInfoList() }
            .bind { [weak self] in
                viewModel.pageData.accept($0)
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }

    private func showBlockFriendsList() {
        let goToBlockListPage = CommonBottomModalAction(title: "친구 차단 리스트", titleColor: UIColor("#FF0000")) { _ in
            let friendListDetailViewModel = FriendListDetailViewModel(friendType: .block, parentPageDataValue: nil)
            let friendListDetailViewController = FriendListDetailViewController(viewModel: friendListDetailViewModel)
            self.pushViewController(viewController: friendListDetailViewController)
        }
        CommonBottomModal.Builder().setActions([goToBlockListPage]).build().show()
    }

    private func showFriendSearch() {
        let friendSearchViewModel = FriendSearchViewModel()
        pushViewController(viewController: FriendSearchViewController(viewModel: friendSearchViewModel))
    }

    private func showFriendListDetail(_ friendType: FriendType?) {
        let pageData = viewModel.pageData.value
        let friendListDetailViewModel = FriendListDetailViewModel(friendType: friendType, parentPageDataValue: pageData)
        let friendListDetailViewController = FriendListDetailViewController(viewModel: friendListDetailViewModel)
        self.pushViewController(viewController: friendListDetailViewController)
    }

    private func showFriendStatus(_ rangeFriendInfo: RangeFriendInfo) {
        let friendStateModalViewModel = FriendStateViewModel(rangeFriendInfo: rangeFriendInfo)
        let friendStateModal = FriendStateViewController(viewModel: friendStateModalViewModel)
        presentPanmodal(panModel: friendStateModal, backgroundColor: .clear)
    }

    private func showSettingModal() {
        CommonModal.Builder()
            .setTitle(localizable.permissionTitle())
            .setMessage(localizable.permissionContractInfo())
            .setNagativeButton(localizable.permissionOkButtonText()) {
                $0.dismiss(animated: true)
            }
            .setPositiveButton(localizable.permissionSettingButtonText()) { [weak self] in
                $0.dismiss(animated: true)
                self?.showIOSSetting()
            }
            .build()
            .show()
    }
}

extension FriendListViewController: UITableViewDataSource, UITableViewDelegate {
    private func countCheck<T>(list: [T]) -> Int {
        list.isEmpty ? 1 : list.count
    }

    private func getInfoCell(indexPath: IndexPath) -> FriendInfoTableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: FriendInfoTableViewCell.self),
                                 for: indexPath) as? FriendInfoTableViewCell else {
            return FriendInfoTableViewCell()
        }
        cell.friendInteractionModel = viewModel.commonFriendViewModel
        return cell
    }
    private func getEmptyCell(indexPath: IndexPath) -> FriendEmptyInfoTableViewCell {
        guard let emptyCell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: FriendEmptyInfoTableViewCell.self),
                                 for: indexPath) as? FriendEmptyInfoTableViewCell else {
            return FriendEmptyInfoTableViewCell()
        }
        emptyCell.infoText = FriendContext.getEmptyText(section: indexPath.section)
        return emptyCell
    }

    func numberOfSections(in tableView: UITableView) -> Int { 4 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pageData = viewModel.pageData.value
        let newFriendList = pageData.newFriendList.filter { $0.isToryUser }
//        let marketingFriendList = pageData.newFriendList.filter { !$0.isToryUser }
        let type = FriendContext.getType(section: section)
        switch type {
        case .new:
            return countCheck(list: newFriendList)
        case .reqeust:
            return countCheck(list: pageData.acceptWaitFriendList)
        case .rangeIn:
            return countCheck(list: pageData.friendListInRange)
        case .rangeOut:
            return countCheck(list: pageData.friendListOutRange)
//        case .marketing:
//            return countCheck(list: marketingFriendList)
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pageData = viewModel.pageData.value
        let newFriendList = pageData.newFriendList.filter { $0.isToryUser }
        let requestFriendList = pageData.acceptWaitFriendList
        let rangeInFriendList = pageData.friendListInRange
        let rangeOutFriendList = pageData.friendListOutRange
//        let marketingFriendList = pageData.newFriendList.filter { !$0.isToryUser }

        let type = FriendContext.getType(section: indexPath.section)
        switch type {
        case .new:
            if !newFriendList.isEmpty {
                let cell = getInfoCell(indexPath: indexPath)
                let isLast = indexPath.row != (newFriendList.count - 1)
                cell.uiState = .new(newFriendList[indexPath.row], isLast)
                return cell
            } else {
                return getEmptyCell(indexPath: indexPath)
            }
        case .reqeust:
            if !requestFriendList.isEmpty {
                let cell = getInfoCell(indexPath: indexPath)
                let isLast = indexPath.row != (requestFriendList.count - 1)
                cell.uiState = .request(requestFriendList[indexPath.row], isLast)
                return cell
            } else {
                return getEmptyCell(indexPath: indexPath)
            }
        case .rangeIn:
            if !rangeInFriendList.isEmpty {
                let cell = getInfoCell(indexPath: indexPath)
                let isLast = indexPath.row != (rangeInFriendList.count - 1)
                cell.uiState = .range(rangeInFriendList[indexPath.row], isLast)
                return cell
            } else {
                return getEmptyCell(indexPath: indexPath)
            }
        case .rangeOut:
            if !rangeOutFriendList.isEmpty {
                let cell = getInfoCell(indexPath: indexPath)
//                let isLast = indexPath.row != (rangeOutFriendList.count - 1)
                cell.uiState = .range(rangeOutFriendList[indexPath.row])
                return cell
            } else {
                return getEmptyCell(indexPath: indexPath)
            }
//        case .marketing:
//            if !marketingFriendList.isEmpty {
//                let cell = getInfoCell(indexPath: indexPath)
//                cell.uiState = .marketing(marketingFriendList[indexPath.row])
//                return cell
//            } else {
//                return getEmptyCell(indexPath: indexPath)
//            }
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: FriendSectionHeaderView.self)) as? FriendSectionHeaderView else {
            return UITableViewHeaderFooterView()
        }
        let type = FriendContext.getType(section: section)
        header.injectData = FriendSectionHeaderView.InjectData(type: type, viewwModel: viewModel)
        return header
    }

    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendInfoTableViewCell else { return nil }
        let pageData = viewModel.pageData.value
        let type = FriendContext.getType(section: indexPath.section)
        if type == .rangeIn {
            let item = pageData.friendListInRange[indexPath.row]
            return cell.setLocationBlockSwipe(data: item)
        }
        if type == .rangeOut {
            let item = pageData.friendListOutRange[indexPath.row]
            return cell.setLocationBlockSwipe(data: item)
        }
        return nil
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendInfoTableViewCell else { return nil }
        let pageData = viewModel.pageData.value
        let type = FriendContext.getType(section: indexPath.section)
        if type == .rangeIn {
            let item = pageData.friendListInRange[indexPath.row]
            return cell.setBlockDeleteSwipe(data: item)
        }
        if type == .rangeOut {
            let item = pageData.friendListOutRange[indexPath.row]
            return cell.setBlockDeleteSwipe(data: item)
        }
        return nil
    }
}
