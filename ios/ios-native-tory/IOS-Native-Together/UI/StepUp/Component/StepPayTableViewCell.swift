//
//  StepPayTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/08.
//

import UIKit
import RxSwift
import RxCocoa

final class StepPayTableViewCell: WilldUITableViewCell {

    var diseposeBag = DisposeBag()
    private let payImageView = WilldUIImageView.create(size: 30, assetsName: "", type: .plain)
    private let stepLabel = WilldUILabel.create(font: .regular20, text: "", color: .togetherBlack)
    let mileagePayButton = WilldUIView.createFillView(backgroudColor: .togetherPurple,
                                                      heightType: .small,
                                                      cornerRoundType: .small).then {
        $0.widthAnchor.constraint(equalToConstant: 128).isActive = true
    }
    private let mileagePayButtonLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherWhite)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        diseposeBag = DisposeBag()
    }

    func configure(_ data: StepUpPageDto.PaymentItem, _ viewModel: StepUpViewModel) {
        payImageView.image = UIImage(named: data.assetImageName)
        stepLabel.text = WDHelper.numberToNumberSeparator(data.stepCount) + localizable.stepPaySteps()

        if data.isPayment {
            mileagePayButtonLabel.text = WDHelper.numberToNumberSeparator(data.paymentMileage)
                + localizable.stepPayRecieved()
            mileagePayButton.backgroundColor = .togetherGray1
        } else {
            mileagePayButtonLabel.text = WDHelper.numberToNumberSeparator(data.paymentMileage)
                + localizable.stepPayRecieving()
            self.mileagePayButton.backgroundColor = data.isGet ? .togetherPurple : .togetherGray3
        }
    }

    private func layout() {
        contentView.addSubviews(payImageView, stepLabel, mileagePayButton, mileagePayButtonLabel)

        payImageView.snp.makeConstraints {
            $0.centerY.equalTo(mileagePayButton)
            $0.leading.equalToSuperview()
        }

        stepLabel.snp.makeConstraints {
            $0.centerY.equalTo(mileagePayButton)
            $0.leading.equalTo(payImageView.snp.trailing).offset(10)
        }

        mileagePayButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
        }

        mileagePayButtonLabel.snp.makeConstraints {
            $0.center.equalTo(mileagePayButton)
        }
    }
}
