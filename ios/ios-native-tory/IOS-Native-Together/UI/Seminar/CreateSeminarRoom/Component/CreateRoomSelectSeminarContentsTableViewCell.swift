//
//  CreateRoomSelectSeminarContentTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateRoomSelectSeminarContentsTableViewCell: BaseTableViewCell {
    var disposeBag = DisposeBag()
    let backView = WilldUIView()

    let thumbnailImgView = WilldUIImageView().then {
        $0.heightAnchor.constraint(equalToConstant: 214).isActive = true
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    let desctionLabel = WilldUILabel.create(font: .bold16,
                                            text: "-",
                                            color: UIColor("#37424D"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(imgUrl: String, description: String) {
        thumbnailImgView.kf.setImage(with: (URL(string: imgUrl)))
        desctionLabel.text = description
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
        desctionLabel.text = data.roomName
    }

    func layout() {
        contentView.addSubviews(backView, thumbnailImgView, desctionLabel)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        thumbnailImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        desctionLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImgView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
