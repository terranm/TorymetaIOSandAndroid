//
//  WhatIsPointDetailViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/30.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa

final class WhatIsPointViewController: RefactoringBaseViewController<WhatIsPointViewModel>,
                                       RefactoringBasePanModalPresentable {
    var shortFormHeight: PanModalHeight { .contentHeight(182) }
    var longFormHeight: PanModalHeight { .contentHeight(182) }
    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    let underLine = UIView()

    override func attribute() {
        super.attribute()
        headerLabel.font = R.font.notoSansSemiBold(size: 24)
        headerLabel.textColor = .togetherWhite

        descriptionLabel.font = R.font.notoSansRegular(size: 16)
        descriptionLabel.textColor = .togetherWhite

        underLine.backgroundColor = .togetherGray3
    }

    override func bind(_ viewModel: WhatIsPointViewModel) {
        super.bind(viewModel)

        viewModel.getHeader()?
            .drive(headerLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.getDescription()?
            .map { $0.description }
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func layout() {
        super.layout()
        view.addSubviews(headerLabel, descriptionLabel, underLine)
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(33)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(11)
            $0.leading.equalTo(headerLabel)
        }
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(23)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
