//
//  SeminarSearchViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/09.
//

import UIKit
import RxSwift
import RxCocoa

final class SeminarSearchViewController: RefactoringBaseViewController<SeminarSearchViewModel> {
    override var analyticsId: String { AnalyticsManager.seminarSearch }
    override var navigationTitle: String { localizable.seminarSearchTitle() }
    var allCnt = 0

    let exitNavigationButton = UIImageView()
    let tableView = UITableView()
    let emptyLabel = UILabel()
    let upButton = UIImageView()

    let seminarManager = SeminarManager()

    override func attribute() {
        super.attribute()

        exitNavigationButton.image = R.image.default_banner_exit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitNavigationButton)

        tableView.separatorStyle = .none
        tableView.register(SeminarSearchTableViewCell.self,
                    forCellReuseIdentifier: SeminarSearchTableViewCell.identifier)
        tableView.register(SeminarSearchTitleTableView.self,
                    forCellReuseIdentifier: SeminarSearchTitleTableView.identifier)
        tableView.register(SeminarSearchItemTableViewCell.self,
                    forCellReuseIdentifier: SeminarSearchItemTableViewCell.identifier)

        emptyLabel.font = R.font.notoSansRegular(size: 16)
        emptyLabel.text = localizable.seminarSearchDesc()
        emptyLabel.textColor = .togetherGray2
        emptyLabel.textAlignment = .center

        upButton.image = R.image.seminar_up()
    }

    override func layout() {
        super.layout()
        exitNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        view.addSubviews(tableView, emptyLabel, upButton)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        upButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    override func bind(_ viewModel: SeminarSearchViewModel) {
        super.bind(viewModel)

        exitNavigationButton.rx.baseTapGesture()
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        repository.seminarSearchReload
            .map { seminarId in
                var list = viewModel.list.value
//                for index in 0..<list.count {
//                    if seminarId == list[index].id {
//                        list[index].participationYn = "Y"
//                    }
//                }
                for index in 0..<list.count where seminarId == list[index].id {
                    list[index].participationYn = "Y"
                }
                return list
            }
            .bind(to: viewModel.list)
            .disposed(by: disposeBag)

        tableView.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)

        viewModel.list
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.allCnt = 2 + $0.count
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        tableView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)

        viewModel.list
            .map { !$0.isEmpty }
            .skip(1)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.emptyLabel.text = localizable.seminarSearchNoResult()
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
            .map { !($0.y > 0) }
            .bind(to: upButton.rx.isHidden)
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

//        /*
//         paging...
//         */
        tableView.rx.contentOffset
            .map { [weak self] contentOffset -> Bool in
                guard let self = self else { return false }
                let contentOffsetY = contentOffset.y
                /*
                 변화하는 전체 Size
                 */
                let contentSize = self.tableView.contentSize.height

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
    }

}

extension SeminarSearchViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCnt
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SeminarSearchTableViewCell.identifier,
                                     for: indexPath) as? SeminarSearchTableViewCell else {
                return UITableViewCell()
            }

            cell.textField.rx.text
                .bind(to: viewModel.query)
                .disposed(by: cell.disposeBag)

            cell.textField.rx.controlEvent(.editingDidEndOnExit)
                .flatMap { [weak self] _ -> Observable<[SeminarListResultDto.Item]> in
                    guard let self = self else { return  Observable.just([]) }
                    let query: String = self.viewModel.query.value ?? ""
                    return self.viewModel.repository.getSearchSeminarList(query: query)
                }
                .bind { [weak self] seminarList in
                    self?.viewModel.list.accept(seminarList)
                    self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    self?.viewModel.isLastPage.accept(false)
                }
                .disposed(by: cell.disposeBag)
            return cell
        case 1:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SeminarSearchTitleTableView.identifier,
                                     for: indexPath) as? SeminarSearchTitleTableView else {
                return UITableViewCell()
            }
            let cnt = !viewModel.list.value.isEmpty ? allCnt - 2: 0
            cell.configure(cnt: cnt)
            return cell
        default:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SeminarSearchItemTableViewCell.identifier,
                                     for: indexPath) as? SeminarSearchItemTableViewCell else {
                return UITableViewCell()
            }
            let seminarManager = self.seminarManager
            let item = self.viewModel.list.value[indexPath.row - 2]
            cell.configure(item, seminarManager)
            cell.thumbnailImgView.rx.baseTapGesture()
                .bind(onNext: { [weak self] in
                    guard let self = self else { return }
                    let seminarScheduleDetailViewModel
                    = SeminarScheduleDetailViewModel(id: self.viewModel.list.value[indexPath.row - 2].id)
                    let seminarScheduleDetailViewController
                    = SeminarScheduleDetailViewController(viewModel: seminarScheduleDetailViewModel)

                    self.presentNavigationViewController(viewController: seminarScheduleDetailViewController, title: "")
                })
                .disposed(by: cell.disposeBag)

            cell.participateButton.rx.baseTapGesture()
                .flatMap { [weak self] in
                    seminarManager.seminarButtonTapUseCase(viewController: self, item: item)
                }
                .subscribe()
                .disposed(by: cell.disposeBag)

            return cell
        }
    }
}
