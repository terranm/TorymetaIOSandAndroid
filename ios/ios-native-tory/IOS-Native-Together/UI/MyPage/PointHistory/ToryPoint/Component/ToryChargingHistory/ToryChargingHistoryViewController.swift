//
//  ToryChargingHistoryViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/07.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import RxCocoa

final class ToryChargingHistoryViewController: RefactoringBaseViewController<ToryChargingHistoryViewModel>, IndicatorInfoProvider {
    override var analyticsId: String { AnalyticsManager.toryChargeHistory }
    var filterItems: [PointFilterDto] = []
    lazy var filterFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 12
        $0.minimumInteritemSpacing = 0
        $0.scrollDirection = .horizontal
        let width = ((12 * 4 + view.frame.width) / 7) - 1
        $0.itemSize = .init(width: width, height: 44)
    }

    lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterFlowLayout).then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.backgroundColor = .togetherWhite
        $0.register(ToryChargingFilterCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: ToryChargingFilterCollectionViewCell.self))
    }

    var historyItems: [PointChargingHistoryListResultDto.Item] = []
    let historyTableView = UITableView().then {
        $0.backgroundColor = .togetherWhite
        $0.separatorStyle = .none
        $0.register(ToryChargingHistoryTableViewCell.self,
                    forCellReuseIdentifier: String(describing: ToryChargingHistoryTableViewCell.self))
    }

    let emptyLabel = WilldUILabel.create(font: .regular16,
                                         text: localizable.toryPointNoChargeHistory(),
                                         color: .togetherGray2)

    override func bind(_ viewModel: ToryChargingHistoryViewModel) {
        super.bind(viewModel)

        filterCollectionView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)

        viewModel.filterItems
            .bind(onNext: { [weak self] in
                self?.filterItems = $0
                self?.filterCollectionView.reloadData()
            })
            .disposed(by: disposeBag)

        historyTableView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)

        viewModel.historyItems
            .bind(onNext: { [weak self] in
                self?.historyItems = $0
                self?.historyTableView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel.historyItems
            .map { $0.count }
            .map { $0 > 0 }
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)

        historyTableView.rx.contentOffset
            .map { [weak self] contentOffset -> Bool in
                guard let self = self else { return false }
                let contentOffsetY = contentOffset.y
                /*
                 변화하는 전체 Size
                 */
                let contentSize   = self.historyTableView.contentSize.height

                let paginationY = contentSize * 0.5

                return contentOffsetY > contentSize - paginationY
            }
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: viewModel.paging)
            .disposed(by: disposeBag)

    }

    override func layout() {
        super.layout()
        view.addSubviews(filterCollectionView, historyTableView, emptyLabel)

        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(21)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        historyTableView.snp.makeConstraints {
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalTo(historyTableView)
        }

    }

    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController)
        -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: localizable.toryPointChargeHistory())
    }
}

extension ToryChargingHistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterItems.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: ToryChargingFilterCollectionViewCell.self),
                                 for: indexPath) as? ToryChargingFilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellData = filterItems[indexPath.row]
        cell.configure(data: cellData)
        cell.rx.tapGesture()
            .when(.recognized)
            .map { [weak self] _ in
                guard let self = self else { return [] }

                self.viewModel.currentPage.accept(0)
                self.viewModel.isLastPage.accept(false)

                if !self.viewModel.historyItems.value.isEmpty {
                    let topIndexPath = IndexPath(row: 0, section: 0)
                    self.historyTableView.scrollToRow(at: topIndexPath, at: .top, animated: false)
                }

                var items = self.viewModel.filterItems.value
                for index in items.indices {
                    items[index].isSelect = false
                }
                items[indexPath.row].isSelect = true
                return items
            }
            .bind(to: viewModel.filterItems)
            .disposed(by: cell.diseposeBag)
        return cell
    }
}

extension ToryChargingHistoryViewController: UITableViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: ToryChargingHistoryTableViewCell.self),
                                 for: indexPath) as? ToryChargingHistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(historyItems[indexPath.row])
        return cell
    }
}
