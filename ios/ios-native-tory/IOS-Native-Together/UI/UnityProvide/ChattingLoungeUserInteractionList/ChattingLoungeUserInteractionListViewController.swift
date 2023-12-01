//
//  ChattingLoungeUserInteractionListViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import Foundation

final class ChattingLoungeUserInteractionListViewController:
    RefactoringBaseViewController<ChattingLoungeUserInteractionListViewModel> {
    private let backgroundView = UIView()
    private let tableView = UITableView()

    override func bind(_ viewModel: ChattingLoungeUserInteractionListViewModel) {
        super.bind(viewModel)

        backgroundView.rx.baseTapGesture()
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.getList()
            .drive(tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ChattingLoungeUserInteractionItemTableViewCell.self),
                    for: indexPath) as? ChattingLoungeUserInteractionItemTableViewCell else {
                    return UITableViewCell()
                }
                cell.setUI(data: data, isLast: row == (viewModel.getListCount() - 1))
                cell.bind(data, viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.interactionButtonTapWithEnterUnity()
            .emit(onNext: { [weak self] data in
                if data == .requestFriend {
                    CommonModal.Builder()
                        .setMessage(localizable.chattingLoungeUserInteractionListRequestFriendModalMessage())
                        .setNagativeButton(
                            localizable.chattingLoungeUserInteractionRequestFriendCancleModalButtonText()) {
                                $0.dismiss(animated: true)
                            }
                            .setPositiveButton(localizable
                                .chattingLoungeUserInteractionRequestFriendOkModalButtonText()) {
                                    $0.dismiss(animated: true) {
                                        viewModel.requestFriendButtonTap.accept(viewModel.memberId ?? 0)
                                    }
                                }
                                .build()
                                .show()
                    return
                }
                if data == .report {
                    let reportViewModel = ChattingLoungeReportViewModel(
                        reportState: .reportUser(viewModel.memberId ?? 0),
                        isBackgrounClorClear: false)
                    let reportViewController
                    = ChattingLoungeReportViewController(viewModel: reportViewModel)
                    self?.presentViewController(viewController: reportViewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                    return
                }

                self?.dismiss(animated: true) {
                    switch data {
                    case .dropOut:
                        self?.unity.callToUnityFunction(.dropOut)
                    case .delegateHost:
                        self?.unity.callToUnityFunction(.delegateHost)
                    case .silent:
                        self?.unity.callToUnityFunction(.silent)
                    case .warn:
                        self?.unity.callToUnityFunction(.warn)
                    default: break
                    }
                }
            })
            .disposed(by: disposeBag)

        viewModel.getList()
            .map { $0.count }
            .drive(onNext: { [weak self] in
                let height = 32 * $0
                self?.tableView.snp.makeConstraints {
                    $0.width.equalTo(110)
                    $0.height.equalTo(height)
                    $0.center.equalToSuperview()
                }
            })
            .disposed(by: disposeBag)

        viewModel.inviteFriendButtonTapWithRequestFriend()
            .emit(onNext: {
                var message = ""
                if $0 {
                    message = localizable.chattingLoungeUserInteractionRequestFriendOkMessage()
                } else {
                    message = localizable.chattingLoungeUserInteractionRequestFriendFailMessage()
                }
                CommonToast.Builder()
                    .setMessage(message)
                    .setMessageFont(.bold14)
                    .setMessageColor(.togetherWhite)
                    .setBackgroundImage(R.image.chatting_lounge_common_toast_background())
                    .build()
                    .showToastWithCenterAndCustomWidth(width: 342)
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        backgroundView.backgroundColor = .black.withAlphaComponent(0.7)

        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        tableView.backgroundColor = .white
        tableView.rowHeight = 32
        tableView.isScrollEnabled = false
        tableView.register(ChattingLoungeUserInteractionItemTableViewCell.self,
                           forCellReuseIdentifier: String(describing:
                                                            ChattingLoungeUserInteractionItemTableViewCell.self))
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView, tableView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
