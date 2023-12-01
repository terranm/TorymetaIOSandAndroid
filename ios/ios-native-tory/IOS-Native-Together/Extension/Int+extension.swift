//
//  Int+extension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation

extension Int {
    var decimalPointed: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: self as NSNumber)
    }
}
