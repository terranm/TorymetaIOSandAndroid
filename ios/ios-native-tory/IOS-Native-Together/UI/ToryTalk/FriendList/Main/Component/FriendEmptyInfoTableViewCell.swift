//
//  FriendEmptyInfoTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/11.
//

import UIKit
import RxSwift
import RxCocoa

final class FriendEmptyInfoTableViewCell: BaseTableViewCell {

    private let infoLabel = WilldUILabel.create(font: .regular16,
                                                text: "",
                                                color: UIColor("#D9D9D9"))

    var infoText: String? {
        didSet {
            configure(infoText)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(_ infoText: String?) {
        infoLabel.text = infoText
    }

    private func layout() {
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
        }
    }
}
