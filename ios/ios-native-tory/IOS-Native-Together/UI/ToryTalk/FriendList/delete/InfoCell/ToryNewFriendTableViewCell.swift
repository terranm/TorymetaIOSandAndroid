//
//  ToryRequestFriendTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/09.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ToryRequestFriendTableViewCell: WilldUITableViewCell {
    var disposeBag = DisposeBag()

    let profileImageView = WilldUIImageView.create(
        size: 44,
        assetsName: "",
        type: .cirecle
    )

    let nickNameLabel = WilldUILabel.create(
        font: .l_16,
        text: "",
        color: .togetherBlack
    )

    let acceptButton = WilldUIView.createBorderView(
        borderColor: .clear,
        heightType: .verySmall,
        cornerRoundType: .circle
    ).then {
        $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    let acceptButtonLabel = WilldUILabel.create(
        font: .l_16,
        text: "",
        color: .clear
    )

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

    func configure(data: ToryRequestFriendDto) {
        profileImageView.kf.setImage(with: URL(string: data.imgUrl))
        nickNameLabel.text = data.nickName
        if data.isAccept {
            acceptButton.configureBorder(width: 1, color: .togetherGray_1)
            acceptButton.configureBackgroundColor(color: .togetherWhite)
            acceptButtonLabel.textColor = .togetherBlack
            acceptButtonLabel.text = "요청 완료"
        } else {
            acceptButton.configureBorder(width: 0, color: .clear)
            acceptButton.configureBackgroundColor(color: .togetherGray_3)
            acceptButtonLabel.textColor = .togetherWhite
            acceptButtonLabel.text = "친구 요청"
        }
    }

    private func layout() {
        contentView.addSubviews(profileImageView, nickNameLabel, acceptButton, acceptButtonLabel)

        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }

        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }

        acceptButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(profileImageView)
        }

        acceptButtonLabel.snp.makeConstraints {
            $0.center.equalTo(acceptButton)
        }
    }
}
