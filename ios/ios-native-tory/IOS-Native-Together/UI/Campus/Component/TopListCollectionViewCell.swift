//
//  TopListCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/25.
//

import UIKit

final class TopListCollectionViewCell: UICollectionViewCell {

    let backView = WilldUIView.createBorderView(borderColor: .togetherPurple, heightType: .small, cornerRoundType: .circle)
    let imageView = WilldUIImageView.create(size: 16, assetsName: "", type: .plain)
    let label = WilldUILabel.create(font: .regular16, text: "", color: .togetherBlack)

    lazy var stackView = UIStackView(arrangedSubviews: [imageView, label]).then {
        $0.spacing = 8
        $0.axis = .horizontal
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(assetsImageName: String, categoryName: String) {
        imageView.image = UIImage(named: assetsImageName)
        label.text = categoryName
    }

    private func layout() {
        contentView.addSubviews(backView, stackView)

        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.center.equalTo(backView)
        }
    }
}
