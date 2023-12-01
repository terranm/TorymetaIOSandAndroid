//
//  UserToryChargeUseInfoTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import UIKit

final class PointChargeFooterViewCell: WilldUITableViewCell {

    let underLineView = WilldUIView.createUnderLineView(height: 1, color: .togetherGray3)

    let userHeaderLabel = WilldUILabel.create(font: .bold20,
                                              text: localizable.pointChargeGuide(),
                                              color: .togetherBlack)

    let infoLabel = WilldUILabel.create(font: .regular16,
                                        text: localizable.pointChargeGiudeDesc(),
                                        color: .togetherBlack)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubviews(underLineView, userHeaderLabel, infoLabel)

        underLineView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
        }

        userHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(userHeaderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(54)
        }
    }
}
