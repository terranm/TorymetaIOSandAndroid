//
//  EmptyCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/12.
//

import UIKit

final class EmptyTableViewCell: BaseTableViewCell {

    private let label = WilldUILabel.create(font: .regular16, text: "", color: .togetherGray2).then {
        $0.textAlignment = .center
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, top: CGFloat = 0, bottom: CGFloat = 0) {
        label.text = title
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(top)
            $0.centerX.equalToSuperview()
        }
    }

    private func layout() {
        contentView.addSubview(label)
    }
}

final class EmptyCollectionViewCell: BaseCollectionViewCell {

    private let label = WilldUILabel.create(font: .regular16, text: "", color: UIColor("#D9D9D9")).then {
        $0.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, top: CGFloat = 0, bottom: CGFloat = 0) {
        label.text = title
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(top)
            $0.centerX.equalToSuperview()
        }
    }

    func configure(center title: String, top: CGFloat = 0, bottom: CGFloat = 0) {
        label.text = title
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func layout() {
        contentView.addSubview(label)
    }
}
