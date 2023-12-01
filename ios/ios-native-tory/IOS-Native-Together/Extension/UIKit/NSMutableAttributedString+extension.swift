//
//  NSMutableAttributedString.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit

extension NSMutableAttributedString {

    func attributed(_ string: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func attributed(_ string: String, fontType: TogetherFontType, fontColor: UIColor) -> NSMutableAttributedString {
        let fontDto = FontValue.getFont(with: fontType)
        let font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
        ?? UIFont.systemFont(ofSize: fontDto.fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: fontColor]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func attachImage(_ imageName: String,
                     _ bounds: CGRect = CGRect(x: 0, y: -4, width: 16, height: 16)) -> NSMutableAttributedString {
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: imageName)
        textAttachment.bounds = bounds
        self.append(NSAttributedString(attachment: textAttachment))
        return self
    }
}
