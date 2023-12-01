//
//  WilldUITableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/17.
//

import UIKit

class WilldUITableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .togetherWhite
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
