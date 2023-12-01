//
//  ChatingListViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/16.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeChattingListViewController: RefactoringBaseViewController<ChattingLoungeChattingListViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIImageView()
    private lazy var chattingLoungeSelectOptionView = ChattingLoungeSelectOptionView(parentViewModel: viewModel)
    private let tableview = UITableView()
    private let emptyLabel = UILabel()

    override func bind(_ viewModel: ChattingLoungeChattingListViewModel) {
        super.bind(viewModel)

        Observable.merge(backgroundView.rx.baseTapGesture(), closeButton.rx.baseTapGesture())
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.chattingList()
            .bind(to: viewModel.list)
            .disposed(by: disposeBag)

        viewModel.list
            .skip(1)
            .bind(to: tableview.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ChattingLoungeChattingListItemTableViewCell.self),
                    for: indexPath) as? ChattingLoungeChattingListItemTableViewCell else {
                    return UITableViewCell()
                }
                cell.setUI(data, isLast: row == (viewModel.getListConunt() - 1))
                cell.bind(data: data, viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.entranceButtonTapWithUnityBridge()
            .emit(onNext: { [weak self] entrance in
                if entrance.isSecret {
                    let chattingLoungePasswordViewModel
                    = ChattingLoungePasswordViewModel(password: entrance.password, isBackgroundClear: true)
                    let chattingLoungePasswordViewController
                    = ChattingLoungePasswordViewController(viewModel: chattingLoungePasswordViewModel)
                    chattingLoungePasswordViewController.setEntranceAbleDelegate {
                        chattingLoungePasswordViewController.dismiss(animated: true) {
                            self?.dismiss(animated: true) {
                                let value = ChattingLoungeChattingListEntranceRequest(tableId: entrance.tableId)
                                self?.unity.callToUnityFunction(.chattingListEntrance, value)
                            }
                        }
                    }
                    self?.presentViewController(viewController: chattingLoungePasswordViewController,
                                                modalTransitionStyle: .crossDissolve,
                                                modalPresentationStyle: .overFullScreen,
                                                backgroundColor: .clear)
                } else {
                    self?.dismiss(animated: true) {
                        let value = ChattingLoungeChattingListEntranceRequest(tableId: entrance.tableId)
                        self?.unity.callToUnityFunction(.chattingListEntrance, value)
                    }
                }
            })
            .disposed(by: disposeBag)

        viewModel.list
            .map { !$0.isEmpty }
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        backgroundView.backgroundColor = .togetherBlack.withAlphaComponent(0.7)

        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .white

        titleLabel.text = localizable.chattingLoungeChattingListTitle()
        titleLabel.configureFont(.bold16)

        closeButton.image = R.image.chatting_lounge_common_exit()

        tableview.separatorStyle = .none
        tableview.layer.cornerRadius = 16
        tableview.backgroundColor = .white
        tableview.register(ChattingLoungeChattingListItemTableViewCell.self,
                           forCellReuseIdentifier:
                            String(describing: ChattingLoungeChattingListItemTableViewCell.self))

        emptyLabel.text = localizable.chattingLoungeChattingListEmptyMessage()
        emptyLabel.configureFont(.regular16)
        emptyLabel.textColor = UIColor("#D9D9D9")
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView, containerView, titleLabel, closeButton, chattingLoungeSelectOptionView,
                         tableview, emptyLabel)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalTo(380)
            $0.height.equalTo(260)
            $0.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(16)
            $0.centerX.equalTo(containerView)
        }
        closeButton.snp.makeConstraints {
            $0.trailing.equalTo(containerView).inset(16)
            $0.centerY.equalTo(titleLabel)
        }
        chattingLoungeSelectOptionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(containerView).inset(20)
        }
        tableview.snp.makeConstraints {
            $0.top.equalTo(chattingLoungeSelectOptionView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(containerView)
            $0.bottom.equalTo(containerView)
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(chattingLoungeSelectOptionView.snp.bottom).offset(42)
            $0.centerX.equalTo(containerView)
        }
    }
}
