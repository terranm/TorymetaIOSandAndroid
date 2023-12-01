//
//  UIButtonExtension.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/19.
//

import UIKit
import Then

enum TogetherBtnFormat {
    case white
    case purple
    case gray
    case darkGray
    case yellow
}

extension UIButton {

    static func createCircleImageBtn(image: UIImage?,
                                     size: CGFloat = 36,
                                     backgroundColor: UIColor? = .togetherWhite,
                                     imageTintColor: UIColor? = .togetherPurple) -> UIButton {
        return UIButton().then {
            $0.configureCircleImagBtnSize(36)
            $0.configureImage(image, backgroundColor, imageTintColor)
        }
    }

    func configureCircleImagBtnSize(_ size: CGFloat = 36) {
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = size / 2
    }

    func configureImage(_ image: UIImage?,
                        _ backgroundColor: UIColor? = .togetherPurple,
                        _ imageTintColor: UIColor? = .togetherWhite) {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = image
            config.background.backgroundColor = backgroundColor
            config.baseForegroundColor = imageTintColor

            self.configuration = config
        } else {
            self.setImage(image, for: .normal)
            self.backgroundColor = backgroundColor
            self.tintColor = imageTintColor
        }
    }

    static func create(format: TogetherBtnFormat,
                       heightSize: WilldUIViewHeightSize,
                       cornerRound: WilldUIViewCornerRound,
                       title: String = "") -> UIButton {
        return UIButton().then {
            if #available(iOS 15.0, *) {
                $0.configuration = UIButton.Configuration.plain()
            }
            $0.configureFormat(with: format)
            $0.configureSize(with: heightSize)
            $0.configureCornerRound(with: cornerRound, heighSize: heightSize)
            $0.setTitle(title, for: .normal)
            $0.configureFont(.bold20)
        }
    }

    func configureFormat(with format: TogetherBtnFormat) {
        let borderWidth: CGFloat = 1
        if #available(iOS 15.0, *) {
            guard var config = self.configuration else {
                return
            }
            switch format {
            case.white:
                config.background.backgroundColor = .togetherWhite
                self.setTitleColor(.togetherPurple, for: .normal)

                config.background.strokeWidth = borderWidth
                config.background.strokeColor = .togetherGray2
            case.purple:
                config.background.backgroundColor = .togetherPurple
                self.setTitleColor(.togetherWhite, for: .normal)

                config.background.strokeWidth = 0
                config.background.strokeColor = nil
            case.gray:
                config.background.backgroundColor = .togetherGray3
                self.setTitleColor(.togetherWhite, for: .normal)

                config.background.strokeWidth = 0
                config.background.strokeColor = nil
            case.darkGray:
                config.background.backgroundColor = .togetherGray1
                self.setTitleColor(.togetherWhite, for: .normal)

                config.background.strokeWidth = 0
                config.background.strokeColor = nil
            case.yellow:
                config.background.backgroundColor = .togetherWhite
                self.setTitleColor(.togetherYellow, for: .normal)

                config.background.strokeWidth = borderWidth
                config.background.strokeColor = .togetherYellow
            }
            self.configuration = config
        } else {
            switch format {
            case.white:
                self.layer.borderWidth = borderWidth
                self.layer.borderColor = UIColor.togetherGray2.cgColor

                self.backgroundColor = .togetherWhite
                self.setTitleColor(.togetherPurple, for: .normal)
            case.purple:
                self.layer.borderWidth = 0
                self.layer.borderColor = nil

                self.backgroundColor = .togetherPurple
                self.setTitleColor(.togetherWhite, for: .normal)
            case.gray:
                self.layer.borderWidth = 0
                self.layer.borderColor = nil

                self.backgroundColor = .togetherGray3
                self.setTitleColor(.togetherWhite, for: .normal)
            case.darkGray:
                self.layer.borderWidth = 0
                self.layer.borderColor = nil

                self.backgroundColor = .togetherGray1
                self.setTitleColor(.togetherWhite, for: .normal)
            case.yellow:
                self.layer.borderWidth = borderWidth
                self.layer.borderColor = UIColor.togetherYellow.cgColor

                self.backgroundColor = .togetherWhite
                self.setTitleColor(.togetherYellow, for: .normal)
            }
        }
    }

    func configureSize(with heightSize: WilldUIViewHeightSize) {
        let height: CGFloat = heightSize.rawValue
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func configureCornerRound(with cornerRound: WilldUIViewCornerRound, heighSize: WilldUIViewHeightSize = .large) {
        if #available(iOS 15.0, *) {
            guard var config = self.configuration else {
                return
            }
            switch cornerRound {
            case.circle:
                let height: CGFloat = heighSize.rawValue
                let cornerRadius: CGFloat = height / 2
                config.background.cornerRadius = cornerRadius
            case.large:
                return
            case.medium:
                config.background.cornerRadius = cornerRound.rawValue
            case.small:
                config.background.cornerRadius = cornerRound.rawValue
            }
            self.configuration = config
        } else {
            switch cornerRound {
            case.circle:
                let height: CGFloat = heighSize.rawValue
                let cornerRadius: CGFloat = height / 2
                self.layer.cornerRadius = cornerRadius
            case.large:
                return
            case.medium:
                self.layer.cornerRadius = cornerRound.rawValue
            case.small:
                self.layer.cornerRadius = cornerRound.rawValue

            }
        }
    }

    func configureFont(_ fontType: TogetherFontType) {
        let fontDto = FontValue.getFont(with: fontType)
        self.titleLabel?.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
    }
}
