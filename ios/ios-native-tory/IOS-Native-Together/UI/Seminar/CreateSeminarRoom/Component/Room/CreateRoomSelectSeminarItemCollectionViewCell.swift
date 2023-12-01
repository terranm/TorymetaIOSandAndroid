//
//  CreateRoomSelectSeminarItemCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/30.
//

import Foundation
import RxSwift
import RxCocoa

final class CreateRoomSelectSeminarItemCollectionViewCell: BaseCollectionViewCell {

    var disposBag = DisposeBag()

    private let thumbnailImgView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.heightAnchor.constraint(equalToConstant: 204).isActive = true
    }

    private let descriptionLabel = WilldUILabel.create(font: .regular16,
                                                       text: "",
                                                       color: .togetherBlack)

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposBag = DisposeBag()
    }

    func configure(_ data: SeminarRoomTypeListResultDto.Item) {
        if data.isSelect {
            thumbnailImgView.layer.borderColor = UIColor.togetherPurple.cgColor
            thumbnailImgView.layer.borderWidth = 4

        } else {
            thumbnailImgView.layer.borderColor = UIColor.clear.cgColor
            thumbnailImgView.layer.borderWidth = 0
        }

        thumbnailImgView.kf.setImage(with: (URL(string: data.roomImageUrl)))
        descriptionLabel.text = data.roomName
    }

    private func layout() {
        contentView.addSubviews(thumbnailImgView, descriptionLabel)

        thumbnailImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImgView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
