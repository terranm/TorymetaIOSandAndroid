//
//  UIView+extension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit

extension UIView {
    func snapshot() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func removeAllSubview() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }

    func debugBounds(_ color: UIColor = .magenta) {
        #if DEBUG
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        #endif
    }
}
