//
//  WDUIView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/19.
//

import UIKit

/*
 corner의 size 또한 일괄적인것 같다.
 */

enum WDBorderRound: CGFloat {
    case none
    case circle
    case radius10  = 10
    case radius16  = 16
    case radius24  = 24
}

enum WDBorderWidth: CGFloat {
    case none
    case width1 = 1
    case width2 = 2
}

/*
 relative라는 것은 snpakit으로 size를 결정 하겠다는 것
 */
/*
 width의 size 또한 일괄적인것 같다.
 */
enum WDWidthSize: CGFloat {
    case relative
    case widthA
    case widthB
    case widthC
}

/*
 height의 size 또한 일괄적인것 같다.
 */
enum WDHeightSize: CGFloat {
    case relative
    case height32 = 32
    case height44 = 44
    case height50 = 50
    case height56 = 56
}

enum WDFont: String {
    /*
     *** 이것은 논의가 필요하다.
     */
    case b48 = "b_48"
    case b40 = "b_40"
    case bold32 = "b_32"
    case bold24 = "b_24"
    case bold20 = "b_20"
    case bold16 = "b_16"
    case bold14 = "b_14"
    case bold12 = "b_12"

    case l32 = "l_32"
    case l24 = "l_24"
    case regular20 = "l_20"
    case regular16 = "l_16"
    case regular14 = "l_14"
    case regular12 = "l_12"

    static func getFont(_ font: WDFont) -> FontDto {
        let split = font.rawValue.split(separator: "_")
        guard !split.isEmpty else { return FontDto(name: "", size: 0) }

        var name = ""
        let size = Int(split[1]) ?? 0
        if String(split[0]) == "b" {
            name = AppConfigure.textBold
        } else if String(split[0]) == "l" {
            name = AppConfigure.textRegular
        }
        return FontDto(name: name, size: CGFloat(size))
    }

    struct FontDto {
        let name: String
        let size: CGFloat
    }
}

extension UIView {
    struct ConfigureInfo {
        let isHidden: Bool
        let customWidth: CGFloat
        let width: WDWidthSize
        let customHeight: CGFloat
        let height: WDHeightSize
        let backgroundColor: UIColor
        let borderRound: WDBorderRound
        let borderWidth: WDBorderWidth
        let borderColor: UIColor
    }
    // swiftlint:disable cyclomatic_complexity function_parameter_count
    fileprivate func configure(_ configureInfo: ConfigureInfo) {
        self.isHidden = configureInfo.isHidden

        if configureInfo.customWidth != 0 {
            self.widthAnchor.constraint(equalToConstant: configureInfo.customWidth).isActive = true
        } else {
            switch configureInfo.width {
            case.relative:
                 break
            default:
                self.widthAnchor.constraint(equalToConstant: configureInfo.width.rawValue).isActive = true
            }
        }

        if configureInfo.customHeight != 0 {
            self.heightAnchor.constraint(equalToConstant: configureInfo.customHeight).isActive = true
        } else {
            switch configureInfo.height {
            case.relative:
                 break
            default:
                self.heightAnchor.constraint(equalToConstant: configureInfo.height.rawValue).isActive = true
            }
        }

        if configureInfo.backgroundColor != .clear {
            self.backgroundColor = configureInfo.backgroundColor
        }

        switch configureInfo.borderRound {
        case.none:
            break
        case.circle:
            switch ( configureInfo.customWidth, configureInfo.customHeight) {
            case (0, 0):
                switch ( configureInfo.width, configureInfo.height) {
                case (.relative, .relative):
                    break
                case (.relative, _):
                    self.clipsToBounds = true
                    self.layer.cornerRadius = configureInfo.height.rawValue / 2
                case (_, .relative):
                    self.clipsToBounds = true
                    self.layer.cornerRadius = configureInfo.width.rawValue / 2
                default:
                    self.clipsToBounds = true
                    self.layer.cornerRadius = min( configureInfo.width.rawValue, configureInfo.height.rawValue) / 2
                }
            case (0, _):
                self.clipsToBounds = true
                self.layer.cornerRadius = configureInfo.customHeight / 2
            case (_, 0):
                self.clipsToBounds = true
                self.layer.cornerRadius = configureInfo.customWidth / 2
            default:
                self.clipsToBounds = true
                self.layer.cornerRadius = min(configureInfo.customWidth, configureInfo.customHeight) / 2
            }
        default:
            self.clipsToBounds = true
            self.layer.cornerRadius = configureInfo.borderRound.rawValue
        }

        switch configureInfo.borderWidth {
        case.none:
            break
        default:
            self.layer.borderWidth = configureInfo.borderWidth.rawValue
        }

        if configureInfo.borderColor != .clear {
            self.layer.borderColor = configureInfo.borderColor.cgColor
        }
    }
}

class WDView: UIView {

    class Builder {
        fileprivate var isHidden: Bool = false

        /*
         customWidth과 Width의 우선 순위는 custom이 더 높다
         */
        fileprivate var customWidth: CGFloat = 0
        fileprivate var width: WDWidthSize = .relative

        /*
         customHeight과 Hight의 우선 순위는 custom이 더 높다
         */
        fileprivate var customHeight: CGFloat = 0
        fileprivate var height: WDHeightSize = .relative

        fileprivate var backgroundColor: UIColor = .clear

        fileprivate var borderRound: WDBorderRound = .none
        fileprivate var borderWidth: WDBorderWidth = .none
        fileprivate var borderColor: UIColor = .clear

        func setIsHidden(_ isHidden: Bool) -> Builder {
            self.isHidden = isHidden
            return self
        }

        func setCustomWidth(_ size: CGFloat) -> Builder {
            self.customWidth = size
            return self
        }

        func setWidth(_ size: WDWidthSize) -> Builder {
            self.width = size
            return self
        }

        func setCustomHeight(_ size: CGFloat) -> Builder {
            self.customHeight = size
            return self
        }

        func setHeight(_ size: WDHeightSize) -> Builder {
            self.height = size
            return self
        }

        func setBackgroundColor(_ color: UIColor) -> Builder {
            self.backgroundColor = color
            return self
        }

        func setBorder(round: WDBorderRound, width: WDBorderWidth, color: UIColor) -> Builder {
            self.borderRound = round
            self.borderWidth = width
            self.borderColor = color
            return self
        }

        func builder(_ superView: UIView) -> WDView {
            let view = WDView().then {
                $0.configure(ConfigureInfo(isHidden: isHidden,
                                           customWidth: customWidth,
                                           width: width,
                                           customHeight: customHeight,
                                           height: height,
                                           backgroundColor: backgroundColor,
                                           borderRound: borderRound,
                                           borderWidth: borderWidth,
                                           borderColor: borderColor))
            }
            superView.addSubview(view)
            return view
        }
    }
}

class WDLabel: UILabel {

    private func configure(text: String,
                           font: WDFont,
                           textColor: UIColor,
                           textAlignment: NSTextAlignment,
                           numberOfLine: Int) {
        self.text = text
        self.setFont(font)
        self.textColor = textColor

        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLine
    }

    func setFont(_ font: WDFont) {
        let fontDto = WDFont.getFont(font)
        self.font = UIFont(name: fontDto.name, size: fontDto.size)
    }

    class Builder: WDView.Builder {
        private var text = ""
        private var font: WDFont = .regular12
        private var textColor: UIColor = .clear

        private var textAlignment: NSTextAlignment = .left
        private var numberOfLine: Int = 0

        func setText(_ text: String, _ font: WDFont, _ textColor: UIColor) -> Builder {
            self.text = text
            self.font = font
            self.textColor = textColor
            return self
        }

        func setTextAlignment(_ alignment: NSTextAlignment) -> Builder {
            self.textAlignment = alignment
            return self
        }

        func setNumberOfLine(_ numberOfLine: Int) -> Builder {
            self.numberOfLine = numberOfLine
            return self
        }

        func bulider(_ superView: UIView) -> WDLabel {
            let view = WDLabel().then {
                // view에 대한 설정
                $0.configure(ConfigureInfo(isHidden: isHidden,
                                           customWidth: customWidth,
                                           width: width,
                                           customHeight: customHeight,
                                           height: height,
                                           backgroundColor: backgroundColor,
                                           borderRound: borderRound,
                                           borderWidth: borderWidth,
                                           borderColor: borderColor))
                // text에 대한 설정
                $0.configure(text: text,
                             font: font,
                             textColor: textColor,
                             textAlignment: textAlignment,
                             numberOfLine: numberOfLine)
            }
            superView.addSubview(view)
            return view
        }
    }
}

final class WDImageView: UIImageView {

    private func configure(imgUrl: String, assetImageName: String, systemImgName: String, imgMode: UIView.ContentMode) {
        if !imgUrl.isEmpty {
            self.kf.setImage(with: URL(string: imgUrl))
        }

        if !assetImageName.isEmpty {
            self.image = UIImage(named: assetImageName)
        }

        if !systemImgName.isEmpty {
            self.image = UIImage(systemName: systemImgName)
        }

        self.contentMode = imgMode
    }

    class Builder: WDView.Builder {
        private var imgUrl: String = ""
        private var assetImageName: String = ""
        private var systemImgName: String = ""
        private var imgMode: UIView.ContentMode = .scaleAspectFit

        func setImgUrl(_ url: String) -> Builder {
            self.imgUrl = url
            return self
        }

        func setassetImageName(_ assetImageName: String) -> Builder {
            self.assetImageName = assetImageName
            return self
        }

        func setSystemImgName(_ systemImgName: String) -> Builder {
            self.systemImgName = systemImgName
            return self
        }

        func build(superView: UIView) -> WDImageView {
            let view = WDImageView().then {
                $0.configure(ConfigureInfo(isHidden: isHidden,
                                           customWidth: customWidth,
                                           width: width,
                                           customHeight: customHeight,
                                           height: height,
                                           backgroundColor: backgroundColor,
                                           borderRound: borderRound,
                                           borderWidth: borderWidth,
                                           borderColor: borderColor))

                $0.configure(imgUrl: imgUrl,
                             assetImageName: assetImageName,
                             systemImgName: systemImgName,
                             imgMode: imgMode)
            }
            superView.addSubview(view)
            return view
        }
    }
}

final class WDTextField: UITextField {

    private func configure(font: WDFont,
                           textColor: UIColor,
                           placeholder: String,
                           placeholderColor: UIColor,
                           keyboardType: UIKeyboardType,
                           textAlignment: NSTextAlignment,
                           clearButtonMode: ViewMode) {
        self.setFont(font)
        self.textColor = textColor

        if placeholderColor != .clear {
            let placeholderAttributes = [NSAttributedString.Key.foregroundColor: placeholderColor]
            let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)

            self.attributedPlaceholder = attributedPlaceholder
        } else {
            self.placeholder = placeholder
        }

        self.keyboardType = keyboardType
        self.textAlignment = textAlignment
        self.clearButtonMode = clearButtonMode
    }

    func setFont(_ font: WDFont) {
        let fontDto = WDFont.getFont(font)
        self.font = UIFont(name: fontDto.name, size: fontDto.size)
    }

    class Builder: WDView.Builder {
        private var font: WDFont = .regular12
        private var textColor: UIColor = .clear

        private var placeholder: String = ""
        private var placeholderColor: UIColor = .clear

        private var keyboardType: UIKeyboardType = .default
        private var textAlignment: NSTextAlignment = .left
        private var clearButtonMode: ViewMode = .never

        func setText(_ font: WDFont, _ textColor: UIColor) -> Builder {
            self.font = font
            self.textColor = textColor
            return self
        }

        func setPlaceHolder(_ placeholder: String) -> Builder {
            self.placeholder = placeholder
            return self
        }

        func setPlaceholderColor(_ color: UIColor) -> Builder {
            self.placeholderColor = color
            return self
        }

        func setKeyboardType(_ type: UIKeyboardType) -> Builder {
            self.keyboardType = type
            return self
        }

        func setTextAlignment(_ alignment: NSTextAlignment) -> Builder {
            self.textAlignment = alignment
            return self
        }

        func setClearButtonMode(_ mode: ViewMode) -> Builder {
            self.clearButtonMode = mode
            return self
        }

        func build(superView: UIView) -> WDTextField {
            let view = WDTextField().then {
                $0.configure(ConfigureInfo(isHidden: isHidden,
                                           customWidth: customWidth,
                                           width: width,
                                           customHeight: customHeight,
                                           height: height,
                                           backgroundColor: backgroundColor,
                                           borderRound: borderRound,
                                           borderWidth: borderWidth,
                                           borderColor: borderColor))
                $0.configure(font: font,
                             textColor: textColor,
                             placeholder: placeholder,
                             placeholderColor: placeholderColor,
                             keyboardType: keyboardType,
                             textAlignment: textAlignment,
                             clearButtonMode: clearButtonMode)
            }
            superView.addSubview(view)
            return view
        }
    }
}
