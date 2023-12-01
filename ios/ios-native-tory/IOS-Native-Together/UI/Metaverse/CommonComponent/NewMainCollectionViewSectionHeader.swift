//
//  NewMainSectionHeader.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/10.
//

import UIKit
import RxSwift
import RxCocoa

final class NewMainCollectionViewSectionHeader: UICollectionReusableView {

    var disposeBag = DisposeBag()

    let titleLabel = WilldUILabel.create(font: .bold16, text: "-", color: .togetherBlack)
    let moreLabel = WilldUILabel.create(font: .regular12,
                                        text: localizable.mainCollectionMore(),
                                        color: .togetherGray1)
    let rightImg = WilldUIImageView.create(size: 22, assetsName: R.image.common_right_arrow.name, type: .plain).then {
        $0.image = $0.image?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .togetherBlack
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ title: String, isMoreLabelHidden: Bool = true, isRightImgHidden: Bool = true) {
        titleLabel.text = title
        moreLabel.isHidden = isMoreLabelHidden
        rightImg.isHidden = isRightImgHidden
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func layout() {
        addSubviews(titleLabel, moreLabel, rightImg)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        moreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        rightImg.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
