//
//  MyWritedViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/28.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

final class MyCommentViewController: RefactoringBaseViewController<MyCommentViewModel>, IndicatorInfoProvider {

    let emptyLabel = WilldUILabel.create(
        font: .regular16,
        text: localizable.myWriteNoPost(),
        color: .togetherGray3
    )

    let tableView = UITableView().then {
        $0.register(MyCommentTableViewCell.self,
                    forCellReuseIdentifier: String(describing: MyCommentTableViewCell.self))
        $0.separatorStyle = .none
        $0.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 1))
        $0.backgroundColor = .togetherWhite
    }

    private var delegate: ((MyCommentListResultDto.Item) -> Void) = { _ in }

    override func bind(_ viewModel: MyCommentViewModel) {
        super.bind(viewModel)

        viewModel.items?
            .drive(tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: String(describing: MyCommentTableViewCell.self),
                                         for: indexPath) as? MyCommentTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(data: data)
                cell.rx.tapGesture()
                    .when(.recognized)
                    .bind(onNext: { [weak self] _ in
                        guard let self = self else { return }
                        self.delegate(data)
                    })
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.items?
            .map {
                // swiftlint:disable empty_count
                $0.count > 0
            }
            .drive(emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)

    }

    func setDelegate(_ delegate: @escaping (MyCommentListResultDto.Item) -> Void) {
        self.delegate = delegate
    }

    override func layout() {
        super.layout()

        view.addSubviews(tableView, emptyLabel)

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController)
        -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: localizable.myCommentMyReply())
    }
}
