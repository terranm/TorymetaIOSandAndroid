//
//  UITextFieldExtension.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/21.
//

import UIKit

enum TogetherTextFieldType {
    case plain
    case roundCircle
}

extension UITextField {

    static func create(type: TogetherTextFieldType,
                       placholder: String? = nil,
                       keyboardType: UIKeyboardType? = nil,
                       textAlignment: NSTextAlignment? = nil,
                       clearButtonMode: ViewMode? = nil) -> UITextField {

        return UITextField().then { textField in
            textField.configureFont(type: .regular20)
            if let placholder = placholder { textField.placeholder = placholder }
            if let keyboardType = keyboardType { textField.keyboardType = keyboardType }
            if let textAlignment = textAlignment { textField.textAlignment = textAlignment }
            if let clearButtonMode = clearButtonMode { textField.clearButtonMode = clearButtonMode }
            switch type {
            case.plain:
                textField.configureRightAndLeftPadding(padding: 0)
                textField.layer.backgroundColor = UIColor.togetherWhite.cgColor

            case.roundCircle:
                let height: CGFloat = 48
                textField.heightAnchor.constraint(equalToConstant: height).isActive = true
                textField.configureRightAndLeftPadding(padding: 24)
                let conerRadius = height / 2
                textField.layer.cornerRadius = conerRadius
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.togetherGray2.cgColor
            }
        }
    }

    func configureRightAndLeftPadding(padding: CGFloat) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: 0.0))
        self.leftView = leftView
        let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: 0.0))
        self.rightView = rightView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }

    func configureFont(type: TogetherFontType) {
        let fontDto = FontValue.getFont(with: type)
        self.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
    }

    // font, size,

}
