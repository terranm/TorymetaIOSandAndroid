//
//  BuildingDetailViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/28.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa

final class BuildingDetailViewController: RefactoringBaseViewController<BuildingDetailViewModel>,
                                 RefactoringBasePanModalPresentable {
    var shortFormHeight: PanModalHeight { .contentHeight(150) }
    var longFormHeight: PanModalHeight { .contentHeight(150) }
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override func bind(_ viewModel: BuildingDetailViewModel) {
        super.bind(viewModel)
        viewModel.detailData?
            .map { $0.placeName }
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.detailData?
            .map { $0.addressName }
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        titleLabel.font = R.font.notoSansSemiBold(size: 20)
        titleLabel.textColor = .togetherPurple

        descriptionLabel.font = R.font.notoSansRegular(size: 14)
        descriptionLabel.textColor = .togetherBlack
    }

    override func layout() {
        super.layout()
        view.addSubviews(titleLabel, descriptionLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(titleLabel)
        }
    }
}
