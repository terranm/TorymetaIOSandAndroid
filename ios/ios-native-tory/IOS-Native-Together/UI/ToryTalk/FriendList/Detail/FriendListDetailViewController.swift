//
//  FriendDetailListViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/02.
//

import UIKit
import RxSwift
import RxCocoa

final class FriendListDetailViewController: RefactoringBaseViewController<FriendListDetailViewModel> {

    override var navigationTitle: String { FriendContext.getTypeName(type: viewModel.friendType) }

    private let searchNavigationButton = UIImageView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let emptyLabel = UILabel()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.commonFriendViewModel.isPageDidAppear.accept(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.commonFriendViewModel.isPageDidAppear.accept(false)
    }

    override func attribute() {
        super.attribute()
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        tableView.rx.setDataSource(self)
            .disposed(by: disposeBag)

        searchNavigationButton.image = R.image.tory_search2()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchNavigationButton)

        tableView.backgroundColor = .togetherWhite
        tableView.separatorStyle = .none
        tableView.register(FriendSectionHeaderView.self,
                    forHeaderFooterViewReuseIdentifier: String(describing: FriendSectionHeaderView.self))
        tableView.register(FriendInfoTableViewCell.self,
                    forCellReuseIdentifier: String(describing: FriendInfoTableViewCell.self))

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.textColor = UIColor("#D9D9D9")
    }
    override func layout() {
        super.layout()
        searchNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        view.addSubviews(tableView, emptyLabel)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints {
            $0.center.equalTo(tableView)
        }
    }

    override func bind(_ viewModel: FriendListDetailViewModel) {
        super.bind(viewModel)
        searchNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.showFriendSearch()
            }
            .disposed(by: disposeBag)
        /*
         1. Trigger
         */
        if let presentInteractionAction = viewModel.commonFriendViewModel.presentInteractionAction {
            presentInteractionAction.emit().disposed(by: disposeBag)
        }

        /*
         2. 화면 상태 업데이트
         */
        repository.friendListReload
            .flatMap {
                viewModel.commonFriendViewModel.stateChangeResult(friendListDetailViewModel: viewModel, interaction: $0)
            }
            .bind {
                guard !$0.isEmpty else { return }
                CommonToast.Builder().setMessage($0).build().show()
            }
            .disposed(by: disposeBag)

        viewModel.getBlockList(type: viewModel.friendType)
            .bind(to: viewModel.blockList)
            .disposed(by: disposeBag)

        viewModel.pageData
            .skip(1)
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)

        viewModel.blockList
            .skip(1)
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)

        viewModel.pageData
            .bind { [weak self] in
                self?.showEmptyLabel(pageData: $0, blockList: nil)
            }
            .disposed(by: disposeBag)

        viewModel.blockList
            .skip(1)
            .bind { [weak self] in
                self?.showEmptyLabel(pageData: nil, blockList: $0)
            }
            .disposed(by: disposeBag)

        viewModel.commonFriendViewModel.friendButtonTap
            .bind { [weak self] rangeFriendInfo in
                self?.showFriendStateModal(rangeFriendInfo)
            }
            .disposed(by: disposeBag)

        viewModel.commonFriendViewModel.isShowGoToSettingModal()
            .bind { [weak self] _ in
                self?.showGoToSettingModal()
            }
            .disposed(by: disposeBag)
    }

    private func showFriendSearch() {
        let friendSearchViewModel = FriendSearchViewModel()
        let friendSearchViewController = FriendSearchViewController(viewModel: friendSearchViewModel)
        pushViewController(viewController: friendSearchViewController)
    }

    private func showFriendStateModal(_ rangeFriendInfo: RangeFriendInfo) {
        let friendStateModalViewModel = FriendStateViewModel(rangeFriendInfo: rangeFriendInfo)
        let friendStateModal = FriendStateViewController(viewModel: friendStateModalViewModel)
        presentPanmodal(panModel: friendStateModal, backgroundColor: .clear)
    }

    private func showGoToSettingModal() {
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

    private func showEmptyLabel(pageData: FriendInfoList?, blockList: [BlockFriendInfo]?) {
        self.emptyLabel.text = FriendContext.getEmptyText(type: viewModel.friendType)
        if viewModel.friendType == .block {
            guard let blockList = blockList else { return }
            self.emptyLabel.isHidden = !blockList.isEmpty
            return
        }

        guard let pageData = pageData else { return }
        switch viewModel.friendType {
        case .new:
            self.emptyLabel.isHidden = !pageData.newFriendList.filter { $0.isToryUser }.isEmpty
        case .reqeust:
            self.emptyLabel.isHidden = !pageData.acceptWaitFriendList.isEmpty
        case .rangeIn:
            self.emptyLabel.isHidden = !pageData.friendListInRange.isEmpty
        case .rangeOut:
            self.emptyLabel.isHidden = !pageData.friendListOutRange.isEmpty
//        case .marketing:
//            self.emptyLabel.isHidden = !pageData.newFriendList.filter { !$0.isToryUser }.isEmpty
        default: return
        }
    }
}

extension FriendListDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pageData = viewModel.pageData.value
        let newFriendList = pageData.newFriendList.filter { $0.isToryUser }
//        let marketingFriendList = pageData.newFriendList.filter { !$0.isToryUser }
        let blockList = viewModel.blockList.value
        switch viewModel.friendType {
        case .new:
            return newFriendList.count
        case .reqeust:
            return pageData.acceptWaitFriendList.count
        case .rangeIn:
            return pageData.friendListInRange.count
        case .rangeOut:
            return pageData.friendListOutRange.count
//        case .marketing:
//            return marketingFriendList.count
        case .block:
            return blockList.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        String(describing: FriendInfoTableViewCell.self),
                                                       for: indexPath) as? FriendInfoTableViewCell else {
            return UITableViewCell()
        }
        let pageData = viewModel.pageData.value
        let newFriendList = pageData.newFriendList.filter { $0.isToryUser }
        let requestFriendList = pageData.acceptWaitFriendList
        let rangeInFriendList = pageData.friendListInRange
        let rangeOutFriendList = pageData.friendListOutRange
        let blockList = viewModel.blockList.value
//        let marketingFriendList = pageData.newFriendList.filter { !$0.isToryUser }
        switch viewModel.friendType {
        case .new:
            cell.uiState = .new(newFriendList[indexPath.row])
        case .reqeust:
            cell.uiState = .request(requestFriendList[indexPath.row])
        case .rangeIn:
            cell.uiState = .range(rangeInFriendList[indexPath.row])
        case .rangeOut:
            cell.uiState = .range(rangeOutFriendList[indexPath.row])
//        case .marketing:
//            cell.uiState = .marketing(marketingFriendList[indexPath.row])
        case .block:
            cell.uiState = .block(blockList[indexPath.row])
        default: break
        }
        cell.friendInteractionModel = viewModel.commonFriendViewModel
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: String(describing: FriendSectionHeaderView.self))
                as? FriendSectionHeaderView else { return UITableViewHeaderFooterView() }
        header.injectData = FriendSectionHeaderView.InjectData(type: viewModel.friendType, viewwModel: nil)
        return header
    }

    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendInfoTableViewCell else { return nil }
        let pageData = viewModel.pageData.value
        var resultData: RangeFriendInfo
        switch viewModel.friendType {
        case .rangeIn:
            resultData = pageData.friendListInRange[indexPath.row]
        case .rangeOut:
            resultData = pageData.friendListOutRange[indexPath.row]
        default: return nil
        }
        return cell.setLocationBlockSwipe(data: resultData)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendInfoTableViewCell else { return nil }
        let pageData = viewModel.pageData.value
        var resultData: RangeFriendInfo
        switch viewModel.friendType {
        case .rangeIn:
            resultData = pageData.friendListInRange[indexPath.row]
        case .rangeOut:
            resultData = pageData.friendListOutRange[indexPath.row]
        default: return nil
        }
        return cell.setBlockDeleteSwipe(data: resultData)
    }
}
