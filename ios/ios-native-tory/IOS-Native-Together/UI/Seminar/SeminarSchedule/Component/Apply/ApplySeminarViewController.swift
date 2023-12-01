//
//  ApplySeminarViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa
import SwiftDate

final class ApplySeminarViewController: RefactoringBaseViewController<ApplySeminarViewModel> {
    override var analyticsId: String { AnalyticsManager.mySeminarApply }
    private let tableView = UITableView()
    private let emptyLabel = UILabel()
    private let upButton = UIImageView()

    private let seminarManager = SeminarManager()
    override func attribute() {
        super.attribute()

        tableView.contentInset = .init(top: 0, left: 0, bottom: 88, right: 0)
        tableView.separatorStyle = .none

        tableView.register(SeminarCountTableViewCell.self,
                    forCellReuseIdentifier: String(describing: SeminarCountTableViewCell.self))
        tableView.register(ApplySeminarItemTableViewCell.self,
                    forCellReuseIdentifier: String(describing: ApplySeminarItemTableViewCell.self))

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.text = localizable.seminarPagerNotExist()
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
    override func bind(_ viewModel: ApplySeminarViewModel) {
        super.bind(viewModel)
        repository.getSeminarList(query: "participation")
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
                        .dequeueReusableCell(withIdentifier: String(describing: ApplySeminarItemTableViewCell.self),
                                             for: indexPath) as? ApplySeminarItemTableViewCell else {
                        return UITableViewCell()
                    }
                    guard let self = self else { return UITableViewCell() }
                    cell.configure(data, self.seminarManager)

                    if data.isSecret {
                        cell.lockInfoBackView.rx.baseTapGesture()
                            .map { data.id }
                            .bind(to: viewModel.passwordCheckButtonTap)
                            .disposed(by: cell.disposeBag)
                    }

                    cell.detailInfoButton.rx.baseTapGesture()
                        .bind(onNext: { [weak self] in
                            let seminarScheduleDetailViewModel
                            = SeminarScheduleDetailViewModel(id: data.id)
                            let seminarScheduleDetailViewController
                            = SeminarScheduleDetailViewController(viewModel: seminarScheduleDetailViewModel)

                            self?.presentNavigationViewController(viewController: seminarScheduleDetailViewController,
                                                                  title: "")
                        })
                        .disposed(by: cell.disposeBag)

                    cell.participateButton.rx.baseTapGesture()
                        .flatMap { [weak self] in
                            guard let self = self else { return Observable<Void>.empty() }
                            return self.seminarManager.seminarButtonTapUseCase(viewController: self, item: data)
                        }
                        .subscribe()
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
         paging...
         */
        tableView.rx.contentOffset
            .map { [weak self] contentOffset -> Bool in
                guard let self = self else { return false }
                let contentOffsetY = contentOffset.y
                /*
                 변화하는 전체 Size
                 */
                let contentSize   = self.tableView.contentSize.height

                let paginationY = contentSize * 0.3

                return contentOffsetY > contentSize - paginationY
            }
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap {
                viewModel.paging(isBottom: $0)
            }
            .map {
                var list = viewModel.list.value
                list += $0
                return list
            }
            .bind(to: viewModel.list)
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
    }
}

extension ApplySeminarViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController)
        -> XLPagerTabStrip.IndicatorInfo {
        IndicatorInfo(title: localizable.seminarPagerApplySeminar())
    }
}
