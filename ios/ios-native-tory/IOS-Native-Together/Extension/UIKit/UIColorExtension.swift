//
//  UIColorExtension.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 10/18/23.
//

import UIKit

extension UIColor {
    convenience init(_ hexColor: String) {
        var hexNumber: UInt64 = 0
        Scanner(string: hexColor.replacingOccurrences(of: "#", with: "")).scanHexInt64(&hexNumber)
        let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
        let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
        let blue = CGFloat(hexNumber & 0x0000FF) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
