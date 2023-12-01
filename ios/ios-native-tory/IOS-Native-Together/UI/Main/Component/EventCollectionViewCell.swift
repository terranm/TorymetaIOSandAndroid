//
//  EventCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/30.
//

import UIKit
import RxSwift

final class EventCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    private let imgView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    private let titleLabel = WilldUILabel.create(font: .bold20,
                                                 text: localizable.createSeminar(),
                                                 color: UIColor("#37424D"))
    private let descriptionLabel = WilldUILabel.create(font: .regular12,
                                                       text: localizable.seminarDesc(),
                                                       color: UIColor("#37424D"))
    private let createButtonLabel = WilldUILabel.create( font: .regular14,
                                                         text: localizable.openSeminar(),
                                                         color: .togetherWhite)

    private(set) lazy var createButton = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 68).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true

        $0.layer.cornerRadius = 8
        $0.backgroundColor = UIColor("#37424D")

        $0.addSubview(createButtonLabel)
        createButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

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

    func configure(imgUrl: String) {
        imgView.kf.setImage(with: URL(string: imgUrl))
        titleLabel.isHidden = true
        descriptionLabel.isHidden = true
        createButton.isHidden = true
    }

    func configure(imgName: String) {
        imgView.image = UIImage(named: imgName)
        titleLabel.isHidden = false
        descriptionLabel.isHidden = false
        createButton.isHidden = false
    }

    private func layout() {
        contentView.addSubviews(imgView, titleLabel, descriptionLabel, createButton)

        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }

        createButton.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
