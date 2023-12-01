//
//  NSObject+extension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation

extension NSObject {
    class var tag: String {
        String(describing: self)
    }
    class  var className: String {
        String(describing: type(of: self))
    }
    var tag: String {
        String(describing: self)
    }
    var className: String {
        String(describing: type(of: self))
    }
}
