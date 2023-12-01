//
//  WilldToastView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/26.
//

import UIKit
import Toast
import RxCocoa
import RxSwift
import PanModal

final class CommonToast: UIImageView {
    private let disposeBag = DisposeBag()
    private var onClickDelegate: (CommonToast) -> Void = { _ in }
    private let messageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
    }

    private func layout() {
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func bind() {
        self.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.onClickDelegate(self)
            })
            .disposed(by: disposeBag)
    }
}
extension CommonToast {
    // PanModal 전용
    func show(_ height: CGFloat) {
        let superview = topMostViewController?.view ?? UIView()
        let point = CGPoint(x: superview.bounds.size.width / 2.0, y: (height - (self.frame.size.height / 2.0)))
        superview.showToast(self, duration: 1, point: point)
    }

    func show() {
        topMostViewController?.view.showToast(self, duration: 1, position: .bottom)
    }

    func showToastWithCenterAndCustomWidth(width: CGFloat) {
        self.frame = .init(x: 0, y: 0, width: width, height: 56)
        topMostViewController?.view.showToast(self, duration: 1, position: .center)
    }

    struct ToastConfigInfo {
        let message: String
        let messageFont: TogetherFontType
        let messageColor: UIColor
        let backgroundColor: UIColor
        let backgroundImage: UIImage?
    }
    private func configure(_ toastConfigInfo: ToastConfigInfo, onClickDelegate: @escaping (CommonToast) -> Void) {
        self.messageLabel.text = toastConfigInfo.message
        self.messageLabel.configureFont(toastConfigInfo.messageFont)
        self.messageLabel.textColor = toastConfigInfo.messageColor

        self.backgroundColor = toastConfigInfo.backgroundColor
        if let backgroundImage = toastConfigInfo.backgroundImage {
            self.backgroundColor = .clear
            self.image = backgroundImage
        }

        self.onClickDelegate = onClickDelegate
    }
}

extension CommonToast {
    final class Builder {
        private var message: String = ""
        private var messageFont: TogetherFontType = .regular16
        private var messageColor: UIColor = .togetherWhite
        private var backgroundColor: UIColor = .togetherGray2
        private var backgroundImage: UIImage?
        private var heightSize: CGFloat = 56

        private(set) var onClickDelegate: (CommonToast) -> Void = {_ in}

        func setMessage(_ message: String) -> Builder {
            self.message = message
            return self
        }

        func setMessageFont(_ font: TogetherFontType) -> Builder {
            self.messageFont = font
            return self
        }

        func setMessageColor(_ color: UIColor) -> Builder {
            self.messageColor = color
            return self
        }

        func setBackgroundColor(_ color: UIColor) -> Builder {
            self.backgroundColor = color
            return self
        }

        func setBackgroundImage(_ image: UIImage?) -> Builder {
            self.backgroundImage = image
            return self
        }

        func setHeightSize(_ height: CGFloat) -> Builder {
            self.heightSize = height
            return self
        }

        func setOnClickDelegate(_ delegate: @escaping (CommonToast) -> Void) -> Builder {
            self.onClickDelegate = delegate
            return self
        }

        func build() -> CommonToast {
            let rootViewController =
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController
            let rect = CGRect(x: 0, y: 0, width: rootViewController?.view.frame.width ?? 0, height: heightSize)
            return CommonToast(frame: rect).then {
                $0.configure(ToastConfigInfo(message: message,
                                             messageFont: messageFont,
                                             messageColor: messageColor,
                                             backgroundColor: backgroundColor,
                                             backgroundImage: backgroundImage),
                             onClickDelegate: onClickDelegate)
            }
        }
    }
}
