//
//  UserToryPointChargeViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa
import EasyTipView
import PanModal
import StoreKit

final class PointChargeViewController: RefactoringBaseViewController<PointChargeViewModel> {
    override var navigationTitle: String { localizable.toryPointCharge() }

    override var analyticsId: String { AnalyticsManager.toryCharge }

    var pointInfoItems: [SKProduct] = []

    lazy var tableView = UITableView().then {
        $0.register(PointChargePaymentTableViewCell.self, forCellReuseIdentifier:
                        String(describing: PointChargePaymentTableViewCell.self))
        $0.register(PointChargeFooterViewCell.self, forCellReuseIdentifier:
                        String(describing: PointChargeFooterViewCell.self))
        $0.separatorStyle = .none
        $0.backgroundColor = .togetherWhite
    }

    let whatIsToryButton = WilldUIImageView.create(
        size: 48,
        assetsName: R.image.mypage_whais.name,
        type: .plain
    )
    lazy var rightBarButton = UIBarButtonItem(customView: whatIsToryButton)

    override func bind(_ viewModel: PointChargeViewModel) {
        super.bind(viewModel)

        let headerView = PointChargeHeaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 212))
        tableView.tableHeaderView = headerView

        viewModel.presentUserToryPointItems
            .drive(onNext: { [weak self] in
                self?.pointInfoItems = $0
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        tableView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)

        whatIsToryButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let viewModel = WhatIsPointViewModel(pointStatus: .tory)
                let whatIsPointModal = WhatIsPointViewController(viewModel: viewModel)

                self?.presentPanmodal(panModel: whatIsPointModal, backgroundColor: .togetherPurple)
            })
            .disposed(by: disposeBag)

        MyProducts.iapService.getProducts { [weak self] _, products in
            guard let products = products else { return }
            self?.viewModel.userToryPointItems.accept(products)
        }

        NotificationCenter.default.addObserver(
          self,
          selector: #selector(handlePurchaseNoti(_:)),
          name: .iapServicePurchaseNotification,
          object: nil
        )
    }

    @objc private func handlePurchaseNoti(_ notification: Notification) {
        guard let quantity = notification.object as? Int else { return }
        let receipt = MyProducts.iapService.getReceiptData()
        viewModel.charging.accept((quantity, receipt ?? ""))
    }

    override func attribute() {
        super.attribute()
        self.navigationItem.rightBarButtonItem = rightBarButton
    }

    override func layout() {
        super.layout()
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

    }

}

extension PointChargeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointInfoItems.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != pointInfoItems.count {
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: PointChargePaymentTableViewCell.self),
                                     for: indexPath) as? PointChargePaymentTableViewCell else {
                return UITableViewCell()
            }
            let cellData = pointInfoItems[indexPath.row]
            cell.configure(data: cellData)
            cell.paymentButton.rx.tapGesture()
                .when(.recognized)
                .bind(onNext: { _ in
                    MyProducts.iapService.buyProduct(cellData)
                })
                .disposed(by: cell.disposeBag)
            return cell
        } else {
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: PointChargeFooterViewCell.self),
                                     for: indexPath) as? PointChargeFooterViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}
