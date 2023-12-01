//
//  MyCommentTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MyCommentTableViewCell: WilldUITableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
    }

    let typeBackView = WilldUIView.createBorderView(borderColor: .togetherPurple,
                                                    heightType: .verySmall,
                                                    cornerRoundType: .circle)

    let typeImageView = WilldUIImageView.create(size: 32, assetsName: "", type: .plain)

    let typeLabel = WilldUILabel.create(font: .regular14, text: localizable.myWriteOutParty(), color: .togetherBlack)
        .then {
            $0.numberOfLines = 2
        }

    lazy var typeStackView = UIStackView(arrangedSubviews: [typeImageView, typeLabel]).then {
        $0.axis = .horizontal
    }

    let descriptionLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherBlack).then {
        $0.numberOfLines = 2
    }

    let dateLabel = WilldUILabel.create(font: .regular14, text: "", color: .togetherGray2)

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

    func configure(data: MyCommentListResultDto.Item) {
        switch data.boardType {
        case.MARKET:
            typeImageView.image = R.image.board_Market_old()
            typeLabel.text = localizable.myWriteOutParty()
        case.MEETING:
            typeImageView.image = R.image.board_we_old()
            typeLabel.text = localizable.myWriteToryMark()
        case.HELP:
            typeImageView.image = R.image.board_help_old()
            typeLabel.text = localizable.myWriteParty()
        case.TALK:
            typeImageView.image = R.image.board_Talk_old()
            typeLabel.text = localizable.myWriteHelp()
        }
        descriptionLabel.text = data.comment

        let split = data.regDt.split(separator: " ")
        if !split.isEmpty {
            dateLabel.text = String(split[0])
        }
    }

    private func layout() {
        contentView.addSubviews(backView, typeBackView, typeStackView, descriptionLabel, dateLabel)

        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(descriptionLabel).inset(-20)
        }

        typeStackView.snp.makeConstraints {
            $0.leading.equalTo(backView).inset(30)
            $0.top.equalToSuperview().inset(20)
        }

        typeBackView.snp.makeConstraints {
            $0.top.bottom.equalTo(typeStackView)
            $0.leading.equalTo(typeStackView).inset(-10)
            $0.trailing.equalTo(typeStackView).inset(-14)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(typeBackView.snp.bottom).offset(15)
            $0.leading.equalTo(typeBackView)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(40)
        }

        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(typeBackView).inset(24)
            $0.trailing.equalTo(backView).inset(24)
        }
    }
}
