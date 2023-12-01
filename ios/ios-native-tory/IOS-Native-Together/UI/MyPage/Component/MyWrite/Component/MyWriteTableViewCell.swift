//
//  MyWriteTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/16.
//

import UIKit
import RxSwift
import RxCocoa

final class MyWriteTableViewCell: WilldUITableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
    }

    let titleLabel = WilldUILabel.create(font: .bold16, text: "", color: .togetherBlack).then {
        $0.numberOfLines = 1
    }

    let descriptionLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherGray1).then {
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

    func configure(data: MyWriteListResultDto.Item) {
        titleLabel.text = data.bbsTitle
        descriptionLabel.text = data.bbsContent
        let split = data.regDt.split(separator: " ")
        if !split.isEmpty {
            dateLabel.text = String(split[0])
        }
    }

    private func layout() {
        contentView.addSubviews(backView, titleLabel, descriptionLabel, dateLabel)

        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(descriptionLabel).inset(-20)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backView).inset(20)
            $0.leading.equalTo(backView).inset(24)
            $0.trailing.equalToSuperview().offset(-164)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(backView).inset(42)
            $0.bottom.equalToSuperview().inset(40)
        }

        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(backView).inset(24)
            $0.centerY.equalTo(titleLabel)
        }
    }
}
