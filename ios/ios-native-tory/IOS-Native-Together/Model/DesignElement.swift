//
//  DesignElement.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/25.
//

import Foundation

enum WilldUIViewHeightSize: CGFloat {
    case large = 56
    case medium = 50
    case small = 44
    case verySmall = 32
}

enum WilldUIViewCornerRound: CGFloat {
    case circle
    case large = 24
    case medium = 16
    case small = 10
}

struct FontDto {
    let fontName: String
    let fontSize: CGFloat

    init() {
        self.fontName = ""
        self.fontSize = 0.0
    }

    init(fontName: String, fontSize: CGFloat) {
        self.fontName = fontName
        self.fontSize = fontSize
    }
}
