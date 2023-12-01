//
//  ChattingLoungeParticipantsListViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeParticipantsListViewController: RefactoringBaseViewController<ChattingLoungeParticipantsListViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let participateCnt = UILabel()
    private lazy var headerStackView = UIStackView(arrangedSubviews: [titleLabel, participateCnt])
    private let reportButton = UIImageView()
    private let closeButton = UIImageView()
    private let tableView = UITableView()

    override func bind(_ viewModel: ChattingLoungeParticipantsListViewModel) {
        super.bind(viewModel)

        Observable.merge(backgroundView.rx.baseTapGesture(), closeButton.rx.baseTapGesture())
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.header()
            .drive(participateCnt.rx.text)
            .disposed(by: disposeBag)

        viewModel.participantsList()
            .drive(viewModel.pageData)
            .disposed(by: disposeBag)

        viewModel.pageData
            .map { $0.list }
            .filter { !$0.isEmpty }
            .bind(to: tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ChattingLoungeParticipantsItemTableViewCell.self),
                    for: indexPath) as? ChattingLoungeParticipantsItemTableViewCell else {
                    return UITableViewCell()
                }
                cell.setUI(data: data, isLast: row == (viewModel.getParticipantsCount() - 1) )
                cell.bind(data, viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.requestButtonTapWithUnityFunctionCall()
            .emit(onNext: { [weak self] _ in
                let chattingLoungeInviteListViewModel
                = ChattingLoungeInviteListViewModel(tableId: viewModel.pageData.value.tableId ?? "",
                                                    isBackgroundColorClear: true)
                let chattingLoungeInviteListViewController
                = ChattingLoungeInviteListViewController(viewModel: chattingLoungeInviteListViewModel)
                self?.topMostViewController?
                    .presentViewController(viewController: chattingLoungeInviteListViewController,
                                           modalTransitionStyle: .crossDissolve,
                                           modalPresentationStyle: .overFullScreen,
                                           backgroundColor: .clear)
            })
            .disposed(by: disposeBag)

        reportButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                let chatRoomId = viewModel.pageData.value.chatRoomId
                let chattingLoungeReportViewModel = ChattingLoungeReportViewModel(
                    reportState: .reportRoom(chatRoomId ?? 0),
                    isBackgrounClorClear: true)
                let chattingLoungeReportViewController
                = ChattingLoungeReportViewController(viewModel: chattingLoungeReportViewModel)
                self?.presentViewController(viewController: chattingLoungeReportViewController,
                                            modalTransitionStyle: .crossDissolve,
                                            modalPresentationStyle: .overFullScreen,
                                            backgroundColor: .clear)
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        backgroundView.backgroundColor = .togetherBlack.withAlphaComponent(0.7)

        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .togetherWhite

        titleLabel.text = localizable.chattingLoungeParticipantsTitle()
        titleLabel.configureFont(.bold14)

        participateCnt.configureFont(.regular12)

        headerStackView.spacing = 4

        reportButton.image = R.image.chatting_lounge_participants_report()
        closeButton.image = R.image.chatting_lounge_common_exit()

        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 16
        tableView.backgroundColor = .togetherWhite
        tableView.rowHeight = 44
        tableView.register(ChattingLoungeParticipantsItemTableViewCell.self,
                           forCellReuseIdentifier: String(describing:
                                                            ChattingLoungeParticipantsItemTableViewCell.self))
    }
    override func layout() {
        super.layout()

        view.addSubviews(backgroundView, containerView, headerStackView, reportButton, closeButton, tableView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(220)
            $0.center.equalToSuperview()
        }
        headerStackView.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(8)
            $0.centerX.equalTo(containerView)
        }
        reportButton.snp.makeConstraints {
            $0.centerY.equalTo(headerStackView)
            $0.leading.equalTo(containerView)
        }
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(headerStackView)
            $0.trailing.equalTo(containerView)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(containerView).inset(8)
            $0.bottom.equalTo(containerView)
        }
    }
}
