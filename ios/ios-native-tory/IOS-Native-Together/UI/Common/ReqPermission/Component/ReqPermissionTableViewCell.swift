//
//  ReqPermissionTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/17.
//

import UIKit

final class ReqPermissionTableViewCell: WilldUITableViewCell {

    private let categoryImageView = WilldUIImageView.create(
        size: 32,
        assetsName: "",
        type: .plain
    )

    private let categoryLabel = CatogoryLabel()

    private let descriptionLabel = WilldUILabel.create(
        font: .regular12,
        text: "",
        color: .togetherGray2
    )

    private lazy var stackView = UIStackView(arrangedSubviews: [categoryLabel, descriptionLabel]).then {
        $0.spacing = 8
        $0.axis = .vertical
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ data: ReqPermissionCellDto) {
        categoryImageView.image = UIImage(named: data.imgName)

        categoryLabel.configure(text: data.category, isSelect: data.isSelect)
        descriptionLabel.text = data.description
    }

    private func layout() {
        contentView.addSubviews(categoryImageView, stackView)
        categoryImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.centerY.equalTo(categoryImageView)
            $0.bottom.equalToSuperview().inset(22)
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }

    final class CatogoryLabel: UIView {
        private let catogiryLabel = UILabel()
        private let optionLabel = UILabel()

        override var intrinsicContentSize: CGSize {
            return CGSize(width: UIScreen.main.bounds.width, height: catogiryLabel.intrinsicContentSize.height)
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            attribute()
            layout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func configure(text: String, isSelect: Bool) {
            catogiryLabel.text = text
            optionLabel.text = isSelect
            ? " \(localizable.requestPermissionSelect())"
            : " \(localizable.requestPermissionEssential())"
            optionLabel.configureFont(isSelect ? .regular14: .bold14)
        }

        private func attribute() {
            catogiryLabel.configureFont(.regular14)
        }

        private func layout() {
            addSubviews(catogiryLabel, optionLabel)
            catogiryLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            optionLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(catogiryLabel.snp.trailing)
            }
        }
    }
}
