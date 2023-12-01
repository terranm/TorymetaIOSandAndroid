//
//  BaseExtension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/07.
//

import UIKit

extension UINavigationItem {

    func setTitle(title: String, subtitle: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -8, width: 0, height: 0)).then {
            let fontDto = FontValue.getFont(with: .bold20)
            $0.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
            $0.textColor = .togetherBlack
            $0.text = title
            $0.sizeToFit()

        }

        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0)).then {
            let fontDto = FontValue.getFont(with: .regular12)
            $0.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
            $0.textColor = .togetherGray2
            $0.text = subtitle
            $0.sizeToFit()
        }

        let titleView = UIView(frame: CGRect(x: 0, y: 0,
                                             width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width),
                                             height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }

        self.titleView = titleView
    }
}
