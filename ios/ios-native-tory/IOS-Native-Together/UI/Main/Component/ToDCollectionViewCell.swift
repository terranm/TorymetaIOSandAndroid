//
//  ToDCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/30.
//

import UIKit
import RxSwift

final class ToDCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    private let thumnailImgView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }

    private let titleLabel = WilldUILabel.create(font: .bold12, text: "-", color: .clear).then {
        $0.textAlignment = .center
    }

    private let entranceButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 64).isActive = true
        $0.layer.cornerRadius = 4
    }

    private let entranceLabel = WilldUILabel.create(font: .bold12, text: "-", color: .togetherWhite)

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

    func configure(_ data: ToDDto) {
        thumnailImgView.image = UIImage(named: data.imgName)

        titleLabel.text = data.title
        titleLabel.textColor = UIColor(data.titleColor)

        entranceButton.backgroundColor = UIColor(data.btnColor)

        entranceLabel.textColor = UIColor(data.btnTextColor)
        entranceLabel.text = data.btnStr
    }

    private func layout() {
        contentView.addSubviews(thumnailImgView, titleLabel, entranceButton, entranceLabel)

        thumnailImgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumnailImgView).inset(16)
            $0.centerX.equalTo(thumnailImgView)
        }

        entranceButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(thumnailImgView)
        }

        entranceLabel.snp.makeConstraints {
            $0.center.equalTo(entranceButton)
        }
    }
}
