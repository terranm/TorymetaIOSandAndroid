//
//  MileagePointTransactionHistoryViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/09.
//

import UIKit
import RxSwift
import RxCocoa
import EasyTipView
import PanModal

final class MileageTransactionHistoryViewController: RefactoringBaseViewController<MileagePointTransactionHistoryViewModel> {
    override var navigationTitle: String { localizable.toryTransactionHistory() }
    override var analyticsId: String { AnalyticsManager.mileageHistory }

    var selectNum = 0

    let mileagePointInfoLabel = WilldUILabel.create(font: .regular16,
                                                    text: localizable.mileageBalance(),
                                                    color: .togetherBlack).then {
        $0.textAlignment = .right
    }

    let whatIsMileageImageView = WilldUIImageView.create(size: 48,
                                                         assetsName: R.image.mypage_whais.name,
                                                         type: .plain)

    let mileagePointBorderView = WilldUIView.createBorderView(borderColor: .togetherPurple,
                                                              heightType: .small,
                                                              cornerRoundType: .small)

    let mileagePointLabel = WilldUILabel.create(font: .regular16,
                                                text: "",
                                                color: .togetherPurple)

    let transactionInfoLabel = WilldUILabel.create(font: .bold16,
                                                   text: localizable.mileageTransactionHistory(),
                                                   color: .togetherPurple)

    let transactionUnderLineView = WilldUIView.createUnderLineView(height: 2, color: .togetherPurple)

    let emptyLabel = WilldUILabel.create(font: .regular16,
                                         text: localizable.mileageNoTransactionHistory(),
                                         color: .togetherGray2)

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

    var historyItems: [PointTransactionListResultDto.Item] = []
    let historyTableView = UITableView().then {
        $0.backgroundColor = .togetherWhite
        $0.separatorStyle = .none
        $0.register(TransactionHistoryTableViewCell.self,
                    forCellReuseIdentifier: String(describing: TransactionHistoryTableViewCell.self))
    }

    override func bind(_ viewModel: MileagePointTransactionHistoryViewModel) {
        super.bind(viewModel)

        viewModel.mileagePoint
            .drive(mileagePointLabel.rx.text)
            .disposed(by: disposeBag)

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
            .map {
                $0.count
            }
            .map {
                $0 > 0
            }
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)

        whatIsMileageImageView.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let viewModel = WhatIsPointViewModel(pointStatus: .mileage)
                let whatIsPointModal = WhatIsPointViewController(viewModel: viewModel)

                self?.presentPanmodal(panModel: whatIsPointModal, backgroundColor: .togetherPurple)
            })
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

        view.addSubviews(mileagePointInfoLabel, whatIsMileageImageView, mileagePointBorderView,
                         mileagePointLabel, transactionInfoLabel, transactionUnderLineView, filterCollectionView,
                         historyTableView, emptyLabel)

        mileagePointInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
        }

        whatIsMileageImageView.snp.makeConstraints {
            $0.centerY.equalTo(mileagePointInfoLabel)
            $0.leading.equalTo(mileagePointInfoLabel.snp.trailing)
        }

        mileagePointBorderView.snp.makeConstraints {
            $0.centerY.equalTo(mileagePointInfoLabel)
            $0.leading.equalTo(whatIsMileageImageView.snp.trailing)
            $0.trailing.equalToSuperview().inset(16)
        }

        mileagePointLabel.snp.makeConstraints {
            $0.centerY.equalTo(mileagePointBorderView)
            $0.trailing.equalTo(mileagePointBorderView).inset(18)
        }

        transactionInfoLabel.snp.makeConstraints {
            $0.top.equalTo(mileagePointBorderView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(16)
        }

        transactionUnderLineView.snp.makeConstraints {
            $0.top.equalTo(transactionInfoLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(transactionUnderLineView.snp.bottom).offset(21)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        historyTableView.snp.makeConstraints {
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalTo(historyTableView)
        }

    }
}

extension MileageTransactionHistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: ToryChargingFilterCollectionViewCell.self),
                                 for: indexPath) as? ToryChargingFilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellData = filterItems[indexPath.row]

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
        cell.configure(data: cellData)
        return cell
    }

}

extension MileageTransactionHistoryViewController: UITableViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: TransactionHistoryTableViewCell.self),
                                 for: indexPath) as? TransactionHistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(historyItems[indexPath.row])
        return cell
    }
}
