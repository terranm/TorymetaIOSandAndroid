//
//  UIImage+extension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

    func resize(newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / self.size.width // 새 이미지 확대/축소 비율
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
