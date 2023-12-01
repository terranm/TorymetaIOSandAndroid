//
//  TagRoomCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/18.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

final class TagRoomCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    let sumbnailImageView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 190).isActive = true
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    let titleLabel = WilldUILabel.create(font: .regular16, text: "-", color: .togetherBlack)

    let participateButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 68).isActive = true
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 8
    }

    let participateButtonLabel = WilldUILabel.create(font: .regular14,
                                                     text: localizable.tagRoomJoin(),
                                                     color: .togetherWhite)
    let descriptionLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherGray2)
    let numberOfPeopleLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherGray2)

    override var intrinsicContentSize: CGSize {
        let sumbnailHeightSize: CGFloat = 190
        let titleSize = titleLabel.intrinsicContentSize
        let descriptionSize = descriptionLabel.intrinsicContentSize

        let width: CGFloat = UIScreen.main.bounds.width
        let hegith = sumbnailHeightSize + 16 + titleSize.height + 8 + descriptionSize.height
        return CGSize(width: width, height: hegith)
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

//    func configre(_ data: SeminarTagRoomDto) {
//        sumbnailImageView.kf.setImage(with: URL(string: data.imgUrl))
//        titleLabel.text = data.title
//        descriptionLabel.text = "최대 인원 \(data.maxPeople)명"
//        numberOfPeopleLabel.text = "\(data.participatePeople)/\(data.maxPeople)"
//    }

    func layout() {
        contentView.addSubviews(sumbnailImageView, titleLabel, participateButton, participateButtonLabel,
                                descriptionLabel, numberOfPeopleLabel)

        sumbnailImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(sumbnailImageView.snp.bottom).offset(16)
            $0.leading.equalTo(sumbnailImageView)
        }

        participateButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(sumbnailImageView)
        }

        participateButtonLabel.snp.makeConstraints {
            $0.center.equalTo(participateButton)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(participateButton.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }

        numberOfPeopleLabel.snp.makeConstraints {
            $0.centerY.equalTo(descriptionLabel)
            $0.trailing.equalTo(participateButton)
        }
    }
}
