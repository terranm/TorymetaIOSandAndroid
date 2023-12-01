//
//  SeminarCountTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa

final class SeminarCountTableViewCell: BaseTableViewCell {

    let cntLabel = WilldUILabel.create(font: .regular12, text: "", color: .togetherGray2)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ allCnt: Int) {
        cntLabel.text = localizable.seminarCountAll() + WDHelper.numberToNumberSeparator(allCnt)
    }

    func layout() {
        contentView.addSubview(cntLabel)

        cntLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
