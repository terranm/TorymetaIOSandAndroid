//
//  UIImageViewExtension.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/21.
//

import UIKit

enum TogetherImageViewType {
    case plain
    case cirecle
    case cornerRound
}

extension UIImageView {

    static func create(width: CGFloat,
                       height: CGFloat,
                       tintColor: UIColor?,
                       imageSystemName: String = "") -> UIImageView {
        return UIImageView().then { imageView in
            imageView.tintColor = tintColor
            imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
            imageView.image = UIImage(systemName: imageSystemName)
        }
    }

    static func create(width: CGFloat,
                       height: CGFloat,
                       contentMode: ContentMode,
                       type: TogetherImageViewType,
                       imageAssetsName: String = "") -> UIImageView {
        return UIImageView().then { imageView in
            imageView.contentMode = contentMode
            imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
            imageView.configureCornerRound(type: type, circleSize: width)
            imageView.image = UIImage(named: imageAssetsName)
        }
    }

    func configureCornerRound(type: TogetherImageViewType, circleSize: CGFloat = 0) {
        switch type {
        case.plain:
            return
        case.cirecle:
            self.layer.masksToBounds = true
            self.layer.cornerRadius = circleSize / 2

        case.cornerRound:
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 8
        }
    }
}
