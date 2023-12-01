//
//  UserToryChargePointInfoTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa
import StoreKit

final class PointChargePaymentTableViewCell: WilldUITableViewCell {

    var disposeBag = DisposeBag()
    let toryPointLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherBlack)

    let paymentButton = WilldUIView.createFillView(backgroudColor: .togetherPurple,
                                                   heightType: .verySmall,
                                                   cornerRoundType: .small)

    let paymentButtonLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherWhite)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(data: SKProduct) {
        toryPointLabel.text = data.localizedTitle
        paymentButtonLabel.text = data.localizedDescription
    }

    private func layout() {
        contentView.addSubviews(toryPointLabel, paymentButton, paymentButtonLabel)

        toryPointLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(34)
        }

        paymentButton.snp.makeConstraints {
            $0.width.equalTo(96)
            $0.centerY.equalTo(toryPointLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        paymentButtonLabel.snp.makeConstraints {
            $0.center.equalTo(paymentButton)
        }
    }
}
