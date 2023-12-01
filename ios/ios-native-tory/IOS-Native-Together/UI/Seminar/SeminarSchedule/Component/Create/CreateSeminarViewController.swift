//
//  CreateSeminarViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

final class CreateSeminarViewController: RefactoringBaseViewController<CreateSeminarViewModel> {
    override var analyticsId: String { AnalyticsManager.mySeminarSet }

    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    private let upButton = UIImageView()
    private let listUpdate = PublishRelay<Void>()

    override func attribute() {
        super.attribute()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 88, right: 0)
        tableView.separatorStyle = .none
        tableView.register(SeminarCountTableViewCell.self,
                    forCellReuseIdentifier: String(describing: SeminarCountTableViewCell.self))
        tableView.register(CreateSeminarItemTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CreateSeminarItemTableViewCell.self))

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.text = localizable.createSeminarViewDesc()
        emptyLabel.textColor = .togetherGray3
        emptyLabel.textAlignment = .center

        upButton.image = R.image.seminar_up()
    }

    override func layout() {
        super.layout()

        view.addSubviews(tableView, emptyLabel, upButton)

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(88)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    // swiftlint:disable function_body_length
    override func bind(_ viewModel: CreateSeminarViewModel) {
        listUpdate.flatMap {
            viewModel.repository.getSeminarList(query: "create")
        }
        .map {
            var items = $0
            items.insert(.init(), at: 0)
            return items
        }
        .bind(onNext: { [weak self] in
            guard let self = self else { return }
            viewModel.list.accept($0)

            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)

            viewModel.isLastPage.accept(false)
        })
        .disposed(by: disposeBag)

        repository.getSeminarList(query: "create")
            .map {
                var items = $0
                items.insert(.init(), at: 0)
                return items
            }
            .bind(to: viewModel.list)
            .disposed(by: disposeBag)

        viewModel.list
            .filter {
                !$0.isEmpty
            }
            .bind(to: tableView.rx.items) { [weak self] tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                if row == 0 {
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: String(describing: SeminarCountTableViewCell.self),
                                             for: indexPath) as? SeminarCountTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(viewModel.list.value.count - 1)
                    return cell
                } else {
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: String(describing: CreateSeminarItemTableViewCell.self),
                                             for: indexPath) as? CreateSeminarItemTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(data)
                    if data.isSecret {
                        cell.lockInfoBackView.rx.baseTapGesture()
                            .map {
                                data.id
                            }
                            .bind(to: viewModel.passwordCheckButtonTap)
                            .disposed(by: cell.disposeBag)
                    }

                    cell.infoButton.rx.baseTapGesture()
                        .bind(onNext: { [weak self] in
                            guard let self = self else { return }
                            let createSeminarRoomViewModel = CreateSeminarRoomViewModel(id: data.id, parentListUpdate: self.listUpdate)
                            let createSeminarRoomViewController = CreateSeminarRoomViewController(viewModel: createSeminarRoomViewModel)

                            self.presentNavigationViewController(viewController: createSeminarRoomViewController,
                                                                 title: "")
                        })
                        .disposed(by: cell.disposeBag)

                    cell.deleteButton.rx.baseTapGesture()
                        .bind(onNext: {
                            CommonModal.Builder()
                                .setMessage(localizable.createSeminarViewDelete())
                                .setPositiveButton(localizable.seminarSearchInsertConfirm()) {
                                    $0.dismiss(animated: true) {
                                        viewModel.deleteButtonTap.accept(data.id)
                                    }
                                }
                                .setPositiveButtonColor(.togetherBlack)
                                .setNagativeButton(localizable.seminarSearchInsertIgnore()) {
                                    $0.dismiss(animated: true)
                                }
                                .setNagativeButtonColor(.togetherPurple)
                                .build()
                                .show()
                        })
                        .disposed(by: cell.disposeBag)

                    cell.lockInfoBackView.rx.baseTapGesture()
                        .bind(onNext: {
                            if !data.password.isEmpty {
                                UIPasteboard.general.string = data.password
                                CommonToast.Builder()
                                    .setMessage(localizable.seminarPagerPasswordCopied())
                                    .build()
                                    .show()
                            }
                        })
                        .disposed(by: cell.disposeBag)

                    cell.enterButton.rx.baseTapGesture()
                        .bind(onNext: {
                            let item = viewModel.list.value[indexPath.row]

                            let now = Date()
                            if !now.isBeforeDate(item.endDate ?? Date(), granularity: .second) {
                                /*
                                 종료
                                 */
                                CommonModal.Builder()
                                    .setMessage(localizable.seminarSearchClosed())
                                    .setPositiveButton(localizable.seminarSearchConfirm()) {
                                        $0.dismiss(animated: true)
                                    }
                                    .build()
                                    .show()
                            } else {
                                /*
                                 시작전 또는 진행중
                                 */
                                CommonModal.Builder()
                                    .setMessage(localizable.seminarSearchEntranceDesc())
                                    .setNagativeButton(localizable.seminarSearchInsertIgnore()) {
                                        $0.dismiss(animated: true)
                                    }
                                    .setPositiveButton(localizable.seminarSearchInsertConfirm()) {
                                        /*
                                         Unity 진입.....
                                         */
                                        $0.dismiss(animated: true) {
                                            let item = viewModel.list.value[indexPath.row]
                                            viewModel.seminarItem.accept(item)

                                            let params = (data.id, data.password)
                                            viewModel.liveSeminarParticipateButtonTap.accept(params)
                                        }
                                    }
                                    .build()
                                    .show()
                            }

                        })
                        .disposed(by: cell.disposeBag)
                    return cell
                }
            }
            .disposed(by: disposeBag)

        viewModel.presentPasswordCheckButtonTap?
            .emit(onNext: { data in
                var items = viewModel.list.value

//                for index in 0..<items.count {
//                    if data.roomId == items[index].id {
//                        items[index].password = data.password
//                    }
//                }
                for index in 0..<items.count where data.roomId == items[index].id {
                    items[index].password = data.password
                }
                viewModel.list.accept(items)
            })
            .disposed(by: disposeBag)

        /*
         삭제
         */
        viewModel.presentDeleteButtonTap?
            .emit(onNext: { [weak self] data in
                /*
                 SeminarMainUpdate
                 */
                self?.repository.seminarMainReload.accept(())
                /*
                 MainPage Update
                 */
//                self.repository.newMainSeminarLeeLoad.accept(())

                var items = viewModel.list.value

//                for index in 0..<items.count {
//                    if data.roomId == items[index].id {
//                        items.remove(at: index)
//                        break
//                    }
//                }
                for index in 0..<items.count where data.roomId == items[index].id {
                    items.remove(at: index)
                    break
                }
                viewModel.list.accept(items)
            })
            .disposed(by: disposeBag)

        viewModel.list
            .map {
                $0.count - 1 > 0
            }
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.emptyLabel.isHidden = $0
                self.tableView.isScrollEnabled = $0
            })
            .disposed(by: disposeBag)

        upButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .map {
                !($0.y > 0)
            }
            .bind(to: upButton.rx.isHidden)
            .disposed(by: disposeBag)

        /*
         paging...
         */
        tableView.rx.contentOffset
            .filter { [weak self] in
                $0.y > (self?.tableView.contentSize.height ?? 0) * 0.7
            }
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { _ in viewModel.paging() }
            .map {
                var list = viewModel.list.value
                list += $0
                return list
            }
            .bind(to: viewModel.list)
            .disposed(by: disposeBag)

        /*
         enter
         */
        viewModel.presentLiveSeminarParticipateButtonTap?
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                if self.repository.hasAvaterAttr.value {
                    let status = MetaWorldSceneStatus.seminar(roomID: $0.roomId,
                                                              unitySeminarID: $0.unitySeminarId,
                                                              seminarURL: $0.seminarUrl,
                                                              title: viewModel.seminarItem.value.title,
                                                              videoStartTime: viewModel.seminarItem.value.startAt)
                    let metaWorldViewModel = MetaWorldViewModel(metaworldSceneStatus: status)
                    let metaWorldViewController = MetaWorldViewController(viewModel: metaWorldViewModel)

                    self.presentViewController(viewController: metaWorldViewController,
                                               modalTransitionStyle: .crossDissolve,
                                               modalPresentationStyle: .fullScreen)
                } else {
                    CommonModal.Builder()
                        .setMessage(localizable.seminarSearchSelectAvatar())
                        .setPositiveButton(localizable.seminarSearchConfirm()) {
                            $0.dismiss(animated: true)
                        }
                        .build()
                        .show()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CreateSeminarViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController)
        -> XLPagerTabStrip.IndicatorInfo {
        IndicatorInfo(title: localizable.seminarSearchOpenSeminar())
    }
}
