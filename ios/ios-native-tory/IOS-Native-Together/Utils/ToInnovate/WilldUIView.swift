//
//  WilldUIView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/11.
//

import UIKit

final class WilldUIView: UIView {

    static func createBackgroundView(backgroundColor: UIColor) -> WilldUIView {
        return WilldUIView().then {
            $0.configureBackgroundColor(color: backgroundColor)
        }
    }

    static func createUnderLineView(height: CGFloat, color: UIColor) -> WilldUIView {
        return WilldUIView().then {
            $0.configureHeight(height: height)
            $0.configureBackgroundColor(color: color)
        }
    }

    static func createPillarLine(width: CGFloat, color: UIColor) -> WilldUIView {
        return WilldUIView().then {
            $0.configureWidth(width: width)
            $0.configureBackgroundColor(color: color)
        }

    }

    static func createFillView(backgroudColor: UIColor,
                               heightType: WilldUIViewHeightSize,
                               cornerRoundType: WilldUIViewCornerRound) -> WilldUIView {
        return WilldUIView().then {
            $0.configureHeight(height: heightType)
            $0.configureCornerRadius(height: heightType, cornerRound: cornerRoundType)

            $0.configureBackgroundColor(color: backgroudColor)
            $0.configureBorder(width: 0, color: .clear)
        }
    }

    static func createBorderView(borderColor: UIColor,
                                 heightType: WilldUIViewHeightSize,
                                 cornerRoundType: WilldUIViewCornerRound) -> WilldUIView {
        return WilldUIView().then {
            $0.configureHeight(height: heightType)
            $0.configureCornerRadius(height: heightType, cornerRound: cornerRoundType)

            $0.configureBackgroundColor(color: .togetherWhite)
            $0.configureBorder(width: 1, color: borderColor)
        }
    }

    static func createFillView(backgroudColor: UIColor,
                               width: CGFloat,
                               height: CGFloat,
                               cornerRound: CGFloat) -> WilldUIView {
        return WilldUIView().then {
            $0.configureWidth(width: width)
            $0.configureHeight(height: height)
            $0.layer.cornerRadius = cornerRound

            $0.configureBackgroundColor(color: backgroudColor)
            $0.configureBorder(width: 0, color: .clear)
        }
    }

    static func createBorderView(borderColor: UIColor,
                                 width: CGFloat,
                                 height: CGFloat,
                                 cornerRound: CGFloat) -> WilldUIView {
        return WilldUIView().then {
            $0.configureWidth(width: width)
            $0.configureHeight(height: height)

            $0.layer.cornerRadius = cornerRound

            $0.configureBackgroundColor(color: .togetherWhite)
            $0.configureBorder(width: 1, color: borderColor)
        }
    }

//    static func createCircleFillView(size: CGFloat, fillColor: UIColor) -> WilldUIView {
//        return WilldUIView().then {
//            $0.widthAnchor.constraint(equalToConstant: size).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: size).isActive = true
//            $0.layer.cornerRadius = size / 2
//            $0.configureBackgroundColor(color: fillColor)
//            $0.configureBorder(width: 0, color: .clear)
//
//        }
//    }
//
//    static func createCircleBorderView(size: CGFloat, borderColor: UIColor) -> WilldUIView {
//        return WilldUIView().then {
//            $0.widthAnchor.constraint(equalToConstant: size).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: size).isActive = true
//            $0.layer.cornerRadius = size / 2
//            $0.configureBackgroundColor(color: .togetherWhite)
//            $0.configureBorder(width: 1, color: borderColor)
//        }
//    }
//
//
//    static func createRoundFillView(size: CGFloat, fillColor: UIColor, round: CGFloat) -> WilldUIView {
//        return WilldUIView().then {
//            $0.widthAnchor.constraint(equalToConstant: size).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: size).isActive = true
//            $0.layer.cornerRadius = round
//            $0.configureBackgroundColor(color: fillColor)
//            $0.configureBorder(width: 0, color: .clear)
//
//        }
//    }
//
//    static func createRoundBorderView(size: CGFloat, borderColor: UIColor, round: CGFloat) -> WilldUIView {
//        return WilldUIView().then {
//            $0.widthAnchor.constraint(equalToConstant: size).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: size).isActive = true
//            $0.layer.cornerRadius = round
//            $0.configureBackgroundColor(color: .togetherWhite)
//            $0.configureBorder(width: 1, color: borderColor)
//        }
//    }

    func configureBackgroundColor(color: UIColor) {
        self.backgroundColor = color
    }

    func configureBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

    private func configureHeight(height: WilldUIViewHeightSize) {
        self.heightAnchor.constraint(equalToConstant: height.rawValue).isActive = true
    }

    private func configureHeight(height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    private func configureWidth(width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    private func configureCornerRadius(height: WilldUIViewHeightSize, cornerRound: WilldUIViewCornerRound) {
        switch cornerRound {
        case.circle:
            let cornerRound = height.rawValue / 2
            self.layer.cornerRadius = cornerRound
        default:
            self.layer.cornerRadius = cornerRound.rawValue
        }
    }

    private func configureCornerRadius(cornerRound: CGFloat) {
        self.layer.cornerRadius = cornerRound
    }
}
