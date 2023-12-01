//
//  RecommendMetaCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/30.
//

import UIKit
import RxSwift

final class RecommendMetaCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    private let thumbnailImgView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 140).isActive = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }

    private let titleLabel = WilldUILabel.create(font: .regular16,
                                                 text: "-",
                                                 color: .togetherBlack)

    let entranceButton = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 68).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.backgroundColor = .togetherYellow
        $0.layer.cornerRadius = 8
    }

    private let entranceLabel = WilldUILabel.create(font: .regular14,
                                                    text: localizable.entrance(),
                                                    color: .togetherWhite)

    override var intrinsicContentSize: CGSize {
        let thumbnailImgSize: CGFloat = 140
        let entranceSize: CGFloat = 32
        let width: CGFloat = UIScreen.main.bounds.width
        let height = thumbnailImgSize + 12 + entranceSize
        return CGSize(width: width, height: height)
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

    func configure(_ data: SeminarRoomTypeListResultDto.Item) {
        thumbnailImgView.kf.setImage(with: URL(string: data.roomImageUrl))
        titleLabel.text = data.roomName
    }

    private func layout() {
        contentView.addSubviews(thumbnailImgView, titleLabel, entranceButton, entranceLabel)

        thumbnailImgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        entranceButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailImgView.snp.bottom).offset(12)
            $0.trailing.equalTo(thumbnailImgView)
        }

        entranceLabel.snp.makeConstraints {
            $0.center.equalTo(entranceButton)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImgView)
            $0.centerY.equalTo(entranceButton)
        }
    }
}
