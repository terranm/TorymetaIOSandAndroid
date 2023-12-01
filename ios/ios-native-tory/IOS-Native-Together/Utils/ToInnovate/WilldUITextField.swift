//
//  WilldUITextField.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/12.
//

import UIKit

final class WilldUITextField: UITextField {

    struct TextFieldAttribute {
        var textColor: UIColor = .togetherBlack
        var textAlignment: NSTextAlignment = .left
        var fontType: TogetherFontType = .regular14
        var placeholder: String?
        var placeholderColor: UIColor = .placholderDefault
        var keyboardType: UIKeyboardType = .default
        var clearButtonMode: ViewMode = .whileEditing
        var returnKeyType: UIReturnKeyType = .default
        var isSecureTextEntry: Bool = false
    }

    init(frame: CGRect = .zero, _ textFieldAttribute: TextFieldAttribute) {
        super.init(frame: frame)
        self.textColor = textFieldAttribute.textColor
        self.textAlignment = textFieldAttribute.textAlignment
        self.font = UIFont(name: FontValue.getFont(with: textFieldAttribute.fontType).fontName,
                           size: FontValue.getFont(with: textFieldAttribute.fontType).fontSize)
        if let placeholder = textFieldAttribute.placeholder {
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: textFieldAttribute.placeholderColor]
            self.attributedPlaceholder =  NSAttributedString(string: placeholder, attributes: attributes)
        }
        self.keyboardType = textFieldAttribute.keyboardType
        self.clearButtonMode = textFieldAttribute.clearButtonMode
        self.returnKeyType = textFieldAttribute.returnKeyType
        self.isSecureTextEntry = textFieldAttribute.isSecureTextEntry
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    static func create(fontType: TogetherFontType,
//                       placeholder: String,
//                       textColor: UIColor,
//                       keyboardType: UIKeyboardType,
//                       textAlignment: NSTextAlignment,
//                       clearButtonMode: ViewMode,
//                       placeholderColor: UIColor = .placholderDefault) -> WilldUITextField {
//        return WilldUITextField().then {
//            $0.configureFont(fontType)
//            $0.textColor = textColor
//            $0.attributedPlaceholder = NSAttributedString(string: placeholder,
//                                                          attributes: [NSAttributedString
//                                                            .Key.foregroundColor: placeholderColor])
//            $0.keyboardType = keyboardType
//            $0.textAlignment = textAlignment
//            $0.clearButtonMode = clearButtonMode
//        }
//    }

//    func configureFont(_ type: TogetherFontType) {
//        let fontDto = FontValue.getFont(with: type)
//        self.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
//    }
}
