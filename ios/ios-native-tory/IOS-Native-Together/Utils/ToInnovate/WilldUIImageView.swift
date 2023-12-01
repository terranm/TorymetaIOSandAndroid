//
//  WilldUIImageView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/12.
//

import UIKit

final class WilldUIImageView: UIImageView {

    static func create(cornerRadius: CGFloat = 0,
                       mode: UIView.ContentMode = .scaleAspectFill) -> WilldUIImageView {
        return WilldUIImageView().then {
            $0.configureCornerRadius(radius: cornerRadius)
            $0.contentMode = mode
        }
    }

    static func create(width: CGFloat,
                       height: CGFloat,
                       cornerRadius: CGFloat = 0,
                       mode: UIView.ContentMode = .scaleAspectFill) -> WilldUIImageView {
        return WilldUIImageView().then {
            $0.configureSize(width: width, height: height)
            $0.configureCornerRadius(radius: cornerRadius)
            $0.contentMode = mode
        }
    }

    static func create(width: CGFloat,
                       height: CGFloat,
                       systemName: String,
                       cornerRadius: CGFloat = 0,
                       mode: UIView.ContentMode = .scaleAspectFill) -> WilldUIImageView {
        return WilldUIImageView().then {
            $0.configureSize(width: width, height: height)
            $0.image = UIImage(systemName: systemName)
            $0.configureCornerRadius(radius: cornerRadius)
            $0.contentMode = mode
        }
    }

    static func create(width: CGFloat,
                       height: CGFloat,
                       assetsName: String,
                       cornerRadius: CGFloat = 0,
                       mode: UIView.ContentMode = .scaleAspectFill) -> WilldUIImageView {
        return WilldUIImageView().then {
            $0.configureSize(width: width, height: height)
            $0.image = UIImage(named: assetsName)
            $0.configureCornerRadius(radius: cornerRadius)
            $0.contentMode = mode
        }
    }

    // size equals
    static func create(size: CGFloat, type: TogetherImageViewType,
                       mode: UIView.ContentMode = .scaleAspectFill) -> WilldUIImageView {
        return WilldUIImageView().then {
            $0.configureSize(width: size, height: size)
            $0.configureType(size: size, type: type)
            $0.contentMode = mode
        }
    }

    static func create(size: CGFloat, systemName: String, type: TogetherImageViewType,
                       mode: UIView.ContentMode = .scaleAspectFill) -> WilldUIImageView {
        return WilldUIImageView().then {
            $0.configureSize(width: size, height: size)
            $0.image = UIImage(systemName: systemName)
            $0.configureType(size: size, type: type)
            $0.contentMode = mode
        }
    }

    static func create(size: CGFloat, assetsName: String, type: TogetherImageViewType,
                       mode: UIView.ContentMode = .scaleAspectFill) -> WilldUIImageView {
        return WilldUIImageView().then {
            $0.configureSize(width: size, height: size)
            $0.image = UIImage(named: assetsName)
            $0.configureType(size: size, type: type)
            $0.contentMode = mode
        }
    }

    func setKingFisher(urlName: String, placeholderSystemName: String = "") {
        self.kf.setImage(with: URL(string: urlName), placeholder: UIImage(systemName: placeholderSystemName))
    }

    func setKingFisher(urlName: String, placeholderAssetsName: String = "") {
        self.kf.setImage(with: URL(string: urlName), placeholder: UIImage(named: placeholderAssetsName))
    }

    func configureType(size: CGFloat, type: TogetherImageViewType) {
        switch type {
        case.plain:
            return
        case.cornerRound:
            self.configureCornerRadius(radius: 8)
        case.cirecle:
            let cornerRadius = size / 2
            self.configureCornerRadius(radius: cornerRadius)
        }
    }

    func configureCornerRadius(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }

    func configureSize( width: CGFloat, height: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
