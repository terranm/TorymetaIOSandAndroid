//
//  CampusInficatorCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/11.
//

import UIKit
import SnapKit
import RxSwift

final class CampusInficatorCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()
    private let imgView = WilldUIImageView.create(size: 24, assetsName: "", type: .plain)
    private let titleLabel = WilldUILabel.create(font: .regular12, text: "", color: .togetherWhite)

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(_ data: CampusTopIndicatorDto) {
        imgView.image = UIImage(named: data.imgName)
        titleLabel.text = data.title
    }

    private func layout() {
        contentView.addSubviews(imgView, titleLabel)

        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(5)
            $0.centerX.equalTo(imgView)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
