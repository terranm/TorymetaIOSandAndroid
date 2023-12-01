//
//  ChattingLoungeInviteListViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeInviteListViewController: RefactoringBaseViewController<ChattingLoungeInviteListViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIImageView()
    private let tableView = UITableView()
    private let emptyLabel = UILabel()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.isPageDidAppear.accept(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.isPageDidAppear.accept(false)
    }

    override func bind(_ viewModel: ChattingLoungeInviteListViewModel) {
        super.bind(viewModel)
        Observable.merge(backgroundView.rx.baseTapGesture(), closeButton.rx.baseTapGesture())
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.inviteList()
            .drive(viewModel.list)
            .disposed(by: disposeBag)

        viewModel.list
            .bind(to: tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ChattingLoungeInviteItemTableViewCell.self),
                    for: indexPath) as? ChattingLoungeInviteItemTableViewCell else {
                    return UITableViewCell()
                }
                cell.setUI(data, isLast: row == (viewModel.getListCount() - 1))
                cell.bind(data, viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.inviteButtonTapWithUnityBridgeCall()
            .drive(onNext: { _ in
                CommonToast.Builder()
                    .setMessage(localizable.chattingLoungeInviteListInviteSend())
                    .setMessageFont(.bold14)
                    .setMessageColor(.togetherWhite)
                    .setBackgroundImage(R.image.chatting_lounge_common_toast_background())
                    .build()
                    .showToastWithCenterAndCustomWidth(width: 342)
            })
            .disposed(by: disposeBag)

        viewModel.list
            .map { !$0.isEmpty }
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.isShowGoToSettingModal()
            .bind(onNext: { [weak self] _ in
                CommonModal.Builder()
                    .setTitle(localizable.permissionTitle())
                    .setMessage(localizable.permissionContractInfo())
                    .setNagativeButton(localizable.permissionOkButtonText()) {
                        $0.dismiss(animated: true)
                    }
                    .setPositiveButton(localizable.permissionSettingButtonText()) {
                        $0.dismiss(animated: true)
                        self?.showIOSSetting()
                    }
                    .build()
                    .show()
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        backgroundView.backgroundColor = viewModel.isBackgroundColorClear
        ? .clear
        : .togetherBlack.withAlphaComponent(0.7)

        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .togetherWhite

        titleLabel.text = localizable.chattingLoungeInviteListTitle()
        titleLabel.configureFont(.bold14)

        closeButton.image = R.image.chatting_lounge_common_exit()

        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 16
        tableView.backgroundColor = .togetherWhite
        tableView.rowHeight = 44
        tableView.register(ChattingLoungeInviteItemTableViewCell.self,
                           forCellReuseIdentifier:
                            String(describing: ChattingLoungeInviteItemTableViewCell.self))

        emptyLabel.text = localizable.chattingLoungeInviteListEmptyMessage()
        emptyLabel.configureFont(.regular14)
        emptyLabel.textColor = .togetherGray3
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView, containerView, titleLabel, closeButton, tableView, emptyLabel)

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(220)
            $0.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(8)
            $0.centerX.equalTo(containerView)
        }
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(containerView)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(containerView).inset(8)
            $0.bottom.equalTo(containerView)
        }
        emptyLabel.snp.makeConstraints {
            $0.center.equalTo(tableView)
        }
    }
}
