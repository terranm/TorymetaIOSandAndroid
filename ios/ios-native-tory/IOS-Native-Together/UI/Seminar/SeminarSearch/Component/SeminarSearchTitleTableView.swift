//
//  SeminarSearchTitleTableView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/09.
//

import Foundation

final class SeminarSearchTitleTableView: BaseTableViewCell {

    let titleLabel = WilldUILabel.create(font: .bold14,
                                         text: localizable.seminarSearchResultTitle(),
                                         color: .togetherBlack)

    let cntLabel = WilldUILabel.create(font: .regular12,
                                       text: "-",
                                       color: .togetherGray2)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(cnt: Int) {
        self.cntLabel.text = localizable.seminarSearchResultCount(cnt)
    }

    func layout() {
        contentView.addSubviews(titleLabel, cntLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(26)
        }

        cntLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel)
        }
    }
}
