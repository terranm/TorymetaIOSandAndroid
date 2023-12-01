//
//  FriendSearchViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/10.
//

import UIKit
import RxSwift
import SnapKit

final class FriendSearchViewController: RefactoringBaseViewController<FriendSearchViewModel> {

    override var navigationTitle: String { localizable.friendSearchTitle() }
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let emptyLabel = UILabel()
    private lazy var friendInfoInputView = FriendInfoInputView(parentViewModel: viewModel)

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
        tableView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        tableView.backgroundColor = .togetherWhite
        tableView.separatorStyle = .none
        tableView.register(FriendInfoTableViewCell.self,
                    forCellReuseIdentifier: String(describing: FriendInfoTableViewCell.self))

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.text = localizable.friendSearchDesc()
        emptyLabel.textColor = UIColor("#D9D9D9")
    }

    override func layout() {
        super.layout()
        view.addSubviews(tableView, emptyLabel, friendInfoInputView)

        friendInfoInputView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.leading.trailing.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(friendInfoInputView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override func bind(_ viewModel: FriendSearchViewModel) {
        super.bind(viewModel)
        view.rx.baseTapGesture()
            .bind { [weak self] in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)

        if let presentInteractionAction = viewModel.commonFriendViewModel.presentInteractionAction {
            presentInteractionAction
                .emit()
                .disposed(by: disposeBag)
        }

        repository.friendSearchReload
            .flatMap {
                viewModel.commonFriendViewModel.stateChangeResult(friendSearchViewModel: viewModel, interaction: $0)
            }
            .bind {
                if !$0.isEmpty {
                    CommonToast.Builder()
                        .setMessage($0)
                        .build()
                        .show()
                }
            }
            .disposed(by: disposeBag)

        viewModel.getFriendSearchList()
            .map {
                print("🍎 SearchList: \($0)")
                return $0
            }
            .bind(to: viewModel.pageData)
            .disposed(by: disposeBag)

        viewModel.pageData
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)

        viewModel.pageData
            .skip(1)
            .bind { [weak self] in
                self?.showEmptyLabel(pageData: $0)
            }
            .disposed(by: disposeBag)

        viewModel.commonFriendViewModel.friendButtonTap
            .bind { [weak self] in
                let friendStateModalViewModel = FriendStateViewModel(rangeFriendInfo: $0)
                let friendStateModal = FriendStateViewController(viewModel: friendStateModalViewModel)
                self?.presentPanmodal(panModel: friendStateModal, backgroundColor: .clear)
            }
            .disposed(by: disposeBag)

        viewModel.commonFriendViewModel.isShowGoToSettingModal()
            .bind { [weak self] _ in
                self?.showGoToSettingModal()
            }
            .disposed(by: disposeBag)
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

    private func showEmptyLabel(pageData: SearchFriendList) {
        let type = viewModel.type.value
        let query = viewModel.query.value ?? ""
        if !query.isEmpty {
            emptyLabel.text = localizable.friendSearchNoResult()
            switch type {
            case .new:
                emptyLabel.isHidden = !pageData.newFriendList.isEmpty
            case .reqeust:
                emptyLabel.isHidden = !pageData.waitFriendList.isEmpty
            case .rangeIn:
                emptyLabel.isHidden = !pageData.friendListInRange.isEmpty
            case .rangeOut:
                emptyLabel.isHidden = !pageData.friendListOutRange.isEmpty
            case .block:
                emptyLabel.isHidden = !pageData.blockFriendList.isEmpty
            }
        }
    }
}

extension FriendSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pageData = viewModel.pageData.value
        let type = viewModel.type.value
        switch type {
        case .new:
            return pageData.newFriendList.count
        case .reqeust:
            return pageData.waitFriendList.count
        case .rangeIn:
            return pageData.friendListInRange.count
        case .rangeOut:
            return pageData.friendListOutRange.count
        case .block:
            return pageData.blockFriendList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        String(describing: FriendInfoTableViewCell.self),
                                                       for: indexPath) as? FriendInfoTableViewCell else {
            return UITableViewCell()
        }
        let pageData = viewModel.pageData.value
        let newFriendList = pageData.newFriendList
        let requestFriendList = pageData.waitFriendList
        let rangeInFriendList = pageData.friendListInRange
        let rangeOutFriendList = pageData.friendListOutRange
        let blockList = pageData.blockFriendList

        let type = viewModel.type.value
        switch type {
        case .new:
            cell.uiState = .new(newFriendList[indexPath.row])
        case .reqeust:
            cell.uiState = .request(requestFriendList[indexPath.row])
        case .rangeIn:
            cell.uiState = .range(rangeInFriendList[indexPath.row])
        case .rangeOut:
            cell.uiState = .range(rangeOutFriendList[indexPath.row])
        case .block:
            cell.uiState = .block(blockList[indexPath.row])
        }
        cell.friendInteractionModel = viewModel.commonFriendViewModel
        return cell
    }

    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendInfoTableViewCell else { return nil }
        let pageData = viewModel.pageData.value
        var resultData: RangeFriendInfo
        let type = viewModel.type.value
        switch type {
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
        let type = viewModel.type.value
        switch type {
        case .rangeIn:
            resultData = pageData.friendListInRange[indexPath.row]
        case .rangeOut:
            resultData = pageData.friendListOutRange[indexPath.row]
        default: return nil
        }
        return cell.setBlockDeleteSwipe(data: resultData)
    }
}
