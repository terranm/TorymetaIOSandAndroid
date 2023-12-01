//
//  UserToryChargeHeaderViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa

final class PointChargeHeaderView: UIView {

    let disposeBag = DisposeBag()

    let toryImageView = WilldUIImageView.create(width: 247, height: 124, assetsName: R.image.mypage_toryCoin.name)
        .then {
            $0.contentMode = .scaleToFill
        }

    let acceptToryLabel = WilldUILabel.create(font: .regular12,
                                              text: localizable.pointChargeToryBalance(),
                                              color: .togetherGray1)

    let toryPointLabel = WilldUILabel.create(font: .bold32,
                                             text: "",
                                             color: .togetherBlack)

    let underLineView = WilldUIView.createUnderLineView(height: 26, color: .togetherGray1)

    let chargeCashLabel = WilldUILabel.create(font: .regular14,
                                              text: localizable.pointChargeCash(),
                                              color: .togetherWhite)

    let transactionLabel = WilldUILabel.create(font: .regular14,
                                               text: localizable.pointChargePayPrice(),
                                               color: .togetherWhite)

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind() {
        repository
            .point
            .map { $0.point }
            .map { WDHelper.numberToNumberSeparator($0) }
            .asDriver(onErrorDriveWith: .empty())
            .drive(toryPointLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func layout() {
        addSubviews(toryImageView, acceptToryLabel, toryPointLabel, underLineView, chargeCashLabel, transactionLabel)

        toryImageView.snp.makeConstraints {
            $0.bottom.equalTo(underLineView.snp.top)
            $0.trailing.equalToSuperview()
        }

        underLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25)
        }

        chargeCashLabel.snp.makeConstraints {
            $0.centerY.equalTo(underLineView)
            $0.leading.equalTo(underLineView).inset(34)
        }

        transactionLabel.snp.makeConstraints {
            $0.centerY.equalTo(underLineView)
            $0.trailing.equalTo(underLineView).inset(35)
        }

        toryPointLabel.snp.makeConstraints {
            $0.bottom.equalTo(underLineView.snp.top).offset(-4)
            $0.leading.equalToSuperview().inset(16)
        }

        acceptToryLabel.snp.makeConstraints {
            $0.bottom.equalTo(toryPointLabel.snp.top)
            $0.leading.equalTo(toryPointLabel)
        }
    }
}
