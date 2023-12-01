//
//  TextViewExtension.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/19.
//

import UIKit
import Then

extension UILabel {

    static func create(font: TogetherFontType,
                       text: String?,
                       color: UIColor?) -> UILabel {
        return UILabel().then { label in
            label.configureFont(font)
            if let text = text { label.text = text }
            if let color = color { label.textColor = color}
        }
    }

    func configureFont(_ fontType: TogetherFontType) {
        let fontDto = FontValue.getFont(with: fontType)
        self.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
    }
}
