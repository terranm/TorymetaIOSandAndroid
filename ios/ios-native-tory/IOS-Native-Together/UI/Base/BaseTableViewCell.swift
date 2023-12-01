//
//  BaseTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/04.
//

import UIKit

protocol BaseTableViewCellProtocol {

}

extension BaseTableViewCellProtocol {

}

extension UITableViewCell: BaseTableViewCellProtocol {

}

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
