//
//  DecoSortingListViewController.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/08/02.
//

import UIKit
import SnapKit
import RxSwift
import PanModal

final class DecoSortingListViewController: RefactoringBaseViewController<AvatarDecoViewModel> {
    typealias SortType = AvatarDecoViewModel.SortType

    private let titleLabel = UILabel()
    private let tableView = UITableView()

    override func attribute() {
        super.attribute()

        titleLabel.text = localizable.decoSortingTitle()
        titleLabel.font = UIFont(name: AppConfigure.textBold, size: 14)
        titleLabel.textColor = UIColor("#000000")
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        tableView.separatorStyle = .none
        tableView.register(DecoSortingListTableViewCell.self,
                           forCellReuseIdentifier: DecoSortingListTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
    }

    override func layout() {
        super.layout()
        view.addSubviews(titleLabel, tableView)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: AvatarDecoViewModel) {
        super.bind(viewModel)
    }
}

extension DecoSortingListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 36 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SortType.allCases.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sortType = SortType.allCases[safe: indexPath.row] else { return }
        viewModel.listOptionRelay.accept(.didSelectSortingList(sortType: sortType))
        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: DecoSortingListTableViewCell.identifier,
                                 for: indexPath) as? DecoSortingListTableViewCell else { return UITableViewCell() }
        cell.sortTitle = SortType.allCases[safe: indexPath.row]?.title
        return cell
    }
}

extension DecoSortingListViewController: PanModalPresentable {
    var panScrollable: UIScrollView? { tableView }
    var dragIndicatorBackgroundColor: UIColor { .clear }
    var longFormHeight: PanModalHeight { .contentHeight(215) }
    var anchorModalToLongForm: Bool { true }
}
