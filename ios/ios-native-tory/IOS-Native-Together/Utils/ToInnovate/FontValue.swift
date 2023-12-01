//
//  FontValue.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/22.
//

import Foundation

enum TogetherFontType {
    case bold10
    case bold12
    case bold14
    case bold16
    case bold20
    case bold22
    case bold24
    case bold32

    case regular10
    case regular12
    case regular14
    case regular16
    case regular20
}

struct FontValue {
    static func getFont(with font: TogetherFontType) -> FontDto {
        switch font {
        case.bold10:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 10)
        case.bold12:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 12)
        case.bold14:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 14)
        case.bold16:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 16)
        case.bold20:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 20)
        case.bold22:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 22)
        case.bold24:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 24)
        case.bold32:
            return FontDto(fontName: AppConfigure.textBold, fontSize: 32)

        case.regular10:
            return FontDto(fontName: AppConfigure.textRegular, fontSize: 10)
        case.regular12:
            return FontDto(fontName: AppConfigure.textRegular, fontSize: 12)
        case.regular14:
            return FontDto(fontName: AppConfigure.textRegular, fontSize: 14)
        case.regular16:
            return FontDto(fontName: AppConfigure.textRegular, fontSize: 16)
        case.regular20:
            return FontDto(fontName: AppConfigure.textRegular, fontSize: 20)
        }
    }
}
