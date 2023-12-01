//
//  ReqPermissionFooterTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/17.
//

import UIKit

final class ReqPermissionFooterTableViewCell: WilldUITableViewCell {

    lazy var descriptionLabel = WilldUILabel.create(
        font: .regular12,
        text: localizable.requestPermissionFooter(),
        color: .togetherGray2
    )

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
