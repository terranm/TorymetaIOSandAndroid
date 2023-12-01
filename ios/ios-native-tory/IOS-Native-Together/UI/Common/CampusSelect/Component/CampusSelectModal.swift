//
//  MyCampusSelectBottomViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal

final class CampusSelectModal: RefactoringBaseViewController<RefactoringBaseViewModel> {
    private let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 1))
        $0.backgroundColor = .togetherWhite
        $0.register(CampusSelectModalTableViewCell.self,
                    forCellReuseIdentifier: String(describing: CampusSelectModalTableViewCell.self))
    }
    private var items: Driver<[UniversityListResultDto.Item]>! = nil
    private var delegate: (UniversityListResultDto.Item) -> Void = { _ in }

    override func layout() {
        super.layout()

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
        }
    }

    override func bind(_ viewModel: RefactoringBaseViewModel) {
        super.bind(viewModel)

        repository.universityList.asDriver(onErrorDriveWith: .empty())
            .drive(tableView.rx.items) { [weak self] tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: CampusSelectModalTableViewCell.self),
                    for: indexPath) as? CampusSelectModalTableViewCell else { return UITableViewCell() }
                cell.configure(data: data)
                cell.rx.tapGesture()
                    .when(.recognized)
                    .bind(onNext: { [weak self] _ in
                        self?.dismiss(animated: true)
                        self?.delegate(data)
                    })
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
    }

    func setDelegate(delegate: @escaping (UniversityListResultDto.Item) -> Void) {
        self.delegate = delegate
    }
}

// MARK: - Pan Modal

extension CampusSelectModal: PanModalPresentable {
    var dragIndicatorBackgroundColor: UIColor { .clear }
    var panScrollable: UIScrollView? { self.tableView }
    var shortFormHeight: PanModalHeight { .contentHeight(532) }
    var longFormHeight: PanModalHeight { .contentHeight(532) }
    var anchorModalToLongForm: Bool { true }
}
