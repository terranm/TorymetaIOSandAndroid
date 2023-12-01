//
//  WilldUILabel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/12.
//

import UIKit

final class WilldUILabel: UILabel {

    static func create(font: TogetherFontType,
                       text: String? = nil,
                       color: UIColor,
                       numberOfLines: Int = 0) -> WilldUILabel {
        return WilldUILabel().then {
            $0.numberOfLines = numberOfLines
            $0.configureFont(fontType: font)
            $0.text = text
            $0.textColor = color
        }
    }

    func configureFont(fontType: TogetherFontType) {
        let fontDto = FontValue.getFont(with: fontType)
        self.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
    }
}
