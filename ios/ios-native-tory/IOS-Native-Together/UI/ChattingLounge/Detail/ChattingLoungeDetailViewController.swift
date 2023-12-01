//
//  ChattingLoungeDetailViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeDetailViewController: RefactoringBaseViewController<ChattingLoungeDetailViewModel> {
    override var navigationTitle: String { localizable.chattingLoungeDetailList() }

    private lazy var optionView = ChattingLoungeDetailOptionView(parentViewModel: viewModel)
    private let tableView = UITableView()
    private let loungeButtonView = ToryLoungeButtonView()
    private let loungeManager = LoungeManager()
    private let upButton = UIImageView()
    private let emptyLabel = UILabel()

    override func attribute() {
        super.attribute()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .togetherWhite
        tableView.register(ChattingLoungeDetailTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ChattingLoungeDetailTableViewCell.self))

        upButton.image = R.image.seminar_up()

        emptyLabel.text = localizable.chattingLoungeNoChatRoom()
        emptyLabel.configureFont(.regular16)
        emptyLabel.textColor = .togetherGray3
    }

    override func layout() {
        super.layout()
        view.addSubviews(optionView, tableView, loungeButtonView, upButton, emptyLabel)
        optionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(optionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        loungeButtonView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(loungeButtonView.snp.top).offset(-54)
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(optionView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
    }

    override func bind(_ viewModel: ChattingLoungeDetailViewModel) {
        super.bind(viewModel)

        viewModel.chttingList()
            .bind(to: viewModel.list)
            .disposed(by: disposeBag)

        viewModel.list
            .bind(to: tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ChattingLoungeDetailTableViewCell.self),
                    for: indexPath) as? ChattingLoungeDetailTableViewCell else { return UITableViewCell() }
                cell.setUI(data, isLast: row == (viewModel.getListCount() - 1))
                cell.bind(data: data, viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.entranceButtonTapWithUnitySwitchScene()
            .emit(onNext: { [weak self] data in
                if data.item.isSecret {
                    let chattingLoungePasswordViewModel
                    = ChattingLoungePasswordViewModel(password: data.item.password, isBackgroundClear: false)
                    let chattingLoungePasswordViewController
                    = ChattingLoungePasswordViewController(viewModel: chattingLoungePasswordViewModel)
                    chattingLoungePasswordViewController.setEntranceAbleDelegate {
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

        loungeButtonView.loungeButton.rx.baseTapGesture()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Void>.empty() }
                return self.loungeManager.presentEntranceLounge(viewController: self)
            }
            .subscribe()
            .disposed(by: disposeBag)

        upButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .map { !($0.y > 0) }
            .bind(to: upButton.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.list
            .map { !$0.isEmpty }
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
