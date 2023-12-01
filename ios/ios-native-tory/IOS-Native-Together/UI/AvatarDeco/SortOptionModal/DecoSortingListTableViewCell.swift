//
//  DecoSortingListTableViewCell.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/08/02.
//

import UIKit
import SnapKit

final class DecoSortingListTableViewCell: UITableViewCell {
    var sortTitle: String? {
        didSet {
            setCellInfo()
        }
    }
    private let titleLabel = UILabel()
    private let selectStatusImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        selectionStyle = .none
        titleLabel.textColor = UIColor("#666666")
        titleLabel.font = UIFont(name: AppConfigure.textRegular, size: 14)
    }

    private func layout() {
        contentView.addSubviews(titleLabel, selectStatusImageView)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.left.equalToSuperview().inset(16)
        }

        selectStatusImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }
    }

    private func setCellInfo() {
        guard let sortTitle else { return }
        titleLabel.text = sortTitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let selectStatusImage = selected ? R.image.option_active : R.image.option_deactive
        selectStatusImageView.image = UIImage(named: selectStatusImage.name)
    }
}
