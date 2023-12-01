//
//  BaseCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/04.
//

import UIKit

protocol BaseCollectionViewCellProtocol {

}

extension BaseCollectionViewCellProtocol {

}

extension UICollectionViewCell: BaseCollectionViewCellProtocol {

}

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
