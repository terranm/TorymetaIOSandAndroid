//
//  WilldModal.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/26.
//

import UIKit
import RxSwift
import RxCocoa

/*
 이런식으로 쓰면 됌.
 WilldModal.Builder()
     .setTitle("알림")
     .setMessage("확인")
     .setPositiveButton("긍정") {
         print("긍정")
     }
     .setNagativeButton("부정") {
         print("부정")
     }
     .build()
     .show()
 */

final class CommonModal: RefactoringBaseViewController<RefactoringBaseViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private var titleLabel: UILabel?
    private var imageView: UIImageView?
    private let messageLabel = UILabel()
    private let underlineView = UIView()
    private let nagativeButton = UILabel()
    private var nagativeDelegate: (CommonModal) -> Void = { _ in }
    private let positiveButton = UILabel()
    private var positiveDelegate: (CommonModal) -> Void = { _ in }
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [nagativeButton, positiveButton])
    private let pillarlineView = UIView()

    override func attribute() {
        super.attribute()
        view.backgroundColor = .clear

        backgroundView.backgroundColor = .black.withAlphaComponent(0.7)

        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .white

        messageLabel.numberOfLines = 4
        messageLabel.textAlignment = .center

        underlineView.backgroundColor = .systemGray3

        nagativeButton.textAlignment = .center
        positiveButton.textAlignment = .center

        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal

        pillarlineView.backgroundColor = .systemGray3
    }

    // swiftlint:disable function_body_length
    private func layout(title: String, isImageNotExist: Bool, imageWidth: CGFloat, imageHeight: CGFloat) {
        view.addSubviews(backgroundView, containerView, messageLabel, underlineView, buttonStackView, pillarlineView)

        if !title.isEmpty {
            titleLabel = UILabel()
            titleLabel?.numberOfLines = 1
            titleLabel?.textAlignment = .center
            guard let titleLabel = titleLabel else { return }
            view.addSubview(titleLabel)
        }
        if !isImageNotExist {
            imageView = UIImageView()
            imageView?.contentMode = .scaleAspectFill
            guard let imageView = imageView else { return }
            view.addSubview(imageView)
        }
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        // title 0, iamge 0, message 0,
        if !title.isEmpty && !isImageNotExist {
            guard let titleLabel = titleLabel,
                  let imageView = imageView else { return }
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(titleLabel).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(containerView)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
            imageView.snp.makeConstraints {
                $0.width.equalTo(imageWidth)
                $0.height.equalTo(imageHeight)
                $0.top.equalTo(titleLabel.snp.bottom).offset(16)
                $0.centerX.equalTo(containerView)
            }
            messageLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(16)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        // title 0, image x, message 0,
        if !title.isEmpty && isImageNotExist {
            guard let titleLabel = titleLabel else { return }
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(titleLabel).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }

            titleLabel.snp.makeConstraints {
                $0.top.equalTo(containerView)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }

            messageLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(16)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        // title x, image 0, message 0,
        if title.isEmpty && !isImageNotExist {
            guard let imageView = imageView else { return }
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(imageView).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }

            imageView.snp.makeConstraints {
                $0.width.equalTo(imageWidth)
                $0.height.equalTo(imageHeight)
                $0.top.equalTo(containerView)
                $0.centerX.equalTo(containerView).inset(16)
            }

            messageLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(16)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        // title x, image x, messag 0
        if title.isEmpty && isImageNotExist {
            containerView.snp.makeConstraints {
                $0.width.equalTo(270)
                $0.center.equalToSuperview()
                $0.top.equalTo(messageLabel).offset(-16)
                $0.bottom.equalTo(buttonStackView)
            }

            messageLabel.snp.makeConstraints {
                $0.top.equalTo(containerView)
                $0.leading.trailing.equalTo(containerView).inset(16)
            }
        }
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(containerView)
        }
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(underlineView.snp.bottom)
            $0.leading.trailing.equalTo(containerView)
            $0.bottom.equalTo(containerView)
        }
        pillarlineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.bottom.equalTo(buttonStackView)
            $0.centerX.equalTo(buttonStackView)
        }
    }

    override func bind(_ viewModel: RefactoringBaseViewModel) {
        super.bind(viewModel)
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        nagativeButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.nagativeDelegate(self)
            }
            .disposed(by: disposeBag)

        positiveButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.positiveDelegate(self)
            }
            .disposed(by: disposeBag)
    }
}

extension CommonModal {
    func show() {
        if topMostViewController !== self {
            self.modalTransitionStyle = .crossDissolve
            self.modalPresentationStyle = .overFullScreen
            topMostViewController?.present(self, animated: true)
        }
    }

    private func setImage(image: UIImage?, imageURL: String?) {
        if let image = image {
            imageView?.image = image
        }
        if let imageURL = imageURL {
            imageView?.kf.setImage(with: URL(string: imageURL))
        }
    }

    struct ModalConfigInfo {
        let title: String
        let message: String
        let attributedMessage: NSMutableAttributedString?
        let image: UIImage?
        let imageUrl: String?
        let imgWidth: CGFloat
        let imgHeight: CGFloat
        let nagativeButtonStr: String
        let positiveButtonStr: String
        // 속성
        let titleColor: UIColor
        let messageColor: UIColor
        let nagativeButtonColor: UIColor
        let positiveButtonColor: UIColor
        let modalBackgroundColor: UIColor
        let lineColor: UIColor
        // 설정
        let titleFont: TogetherFontType
        let messageFont: TogetherFontType
        let buttonFont: TogetherFontType
    }

    private func configure(_ modalConfigInfo: ModalConfigInfo,
                           nagativeButtonDelegate: @escaping (CommonModal) -> Void,
                           positiveButtonDelegate: @escaping (CommonModal) -> Void) {
        let isImageNotExist = (modalConfigInfo.imageUrl?.isEmpty == true) || modalConfigInfo.image == nil
        self.layout(title: modalConfigInfo.title, isImageNotExist: isImageNotExist,
                    imageWidth: modalConfigInfo.imgWidth, imageHeight: modalConfigInfo.imgHeight)

        self.messageLabel.text = modalConfigInfo.message

        if let attributedMessage = modalConfigInfo.attributedMessage {
             messageLabel.attributedText = attributedMessage
         }

        // title 0, iamge 0, message 0,
        if !modalConfigInfo.title.isEmpty && !isImageNotExist {
            self.titleLabel?.text = modalConfigInfo.title
            self.setImage(image: modalConfigInfo.image, imageURL: modalConfigInfo.imageUrl)
        }

        // title 0, image x, message 0,
        if !modalConfigInfo.title.isEmpty && isImageNotExist {
            self.titleLabel?.text = modalConfigInfo.title
        }

        // title x, image 0, message 0,
        if modalConfigInfo.title.isEmpty && !isImageNotExist {
            self.setImage(image: modalConfigInfo.image, imageURL: modalConfigInfo.imageUrl)
        }

        // title x, image x, messag 0
        if modalConfigInfo.title.isEmpty && isImageNotExist {}
        // setNavigationButton을 안한다면 숨겨서 positiveButton만 보이게 동작하자...
        self.nagativeButton.isHidden = modalConfigInfo.nagativeButtonStr.isEmpty
        self.pillarlineView.isHidden = modalConfigInfo.nagativeButtonStr.isEmpty

        self.nagativeButton.text = modalConfigInfo.nagativeButtonStr
        self.nagativeDelegate = nagativeButtonDelegate

        self.positiveButton.text = modalConfigInfo.positiveButtonStr
        self.positiveDelegate = positiveButtonDelegate
        // 속성
        self.titleLabel?.textColor = modalConfigInfo.titleColor
        self.messageLabel.textColor = modalConfigInfo.messageColor
        self.nagativeButton.textColor = modalConfigInfo.nagativeButtonColor
        self.positiveButton.textColor = modalConfigInfo.positiveButtonColor
        self.containerView.backgroundColor = modalConfigInfo.modalBackgroundColor
        self.underlineView.backgroundColor = modalConfigInfo.lineColor
        self.pillarlineView.backgroundColor = modalConfigInfo.lineColor
        // 설정
        let titleFontDto = FontValue.getFont(with: modalConfigInfo.titleFont)
        self.titleLabel?.font = UIFont(name: titleFontDto.fontName, size: titleFontDto.fontSize)

        let messageFontDto = FontValue.getFont(with: modalConfigInfo.messageFont)
        self.messageLabel.font = UIFont(name: messageFontDto.fontName, size: messageFontDto.fontSize)

        let buttonFontDto = FontValue.getFont(with: modalConfigInfo.buttonFont)
        self.nagativeButton.font = UIFont(name: buttonFontDto.fontName, size: buttonFontDto.fontSize)
        self.positiveButton.font = UIFont(name: buttonFontDto.fontName, size: buttonFontDto.fontSize)
    }
}

extension CommonModal {
    final class Builder {
        private var title: String = ""
        private var message: String = ""
        private var attributedMessage: NSMutableAttributedString?

        private var image: UIImage?
        private var imageUrl: String?
        private var imageWidth: CGFloat = 0.0
        private var imageHeight: CGFloat = 0.0

        private var nagativeButtonStr: String = ""
        private var nagativeButtonDelegate: (CommonModal) -> Void = { _ in }
        private var positiveButtonStr: String = ""
        private var positiveButtonDelegate: (CommonModal) -> Void = { _ in }

        /*
         color 속성
         */
        private var titleColor: UIColor = .togetherBlack
        private var messageColor: UIColor = .togetherBlack
        private var nagativeButtonColor: UIColor = .togetherBlack
        private var positiveButtonColor: UIColor = .togetherPurple
        private var modalBackgroindColor: UIColor = .togetherWhite
        private var lineColor: UIColor = .togetherGray3

        /*
         글자 크기 속성
         */
        private var titleFont: TogetherFontType = .bold20
        private var messageFont: TogetherFontType = .regular14
        private var buttonFont: TogetherFontType = .regular16

        func setTitle(_ title: String) -> Self {
            self.title = title
            return self
        }

        func setMessage(_ message: String) -> Self {
            self.message = message
            return self
        }

        func setAttributedMessage(_ attributedMessage: NSMutableAttributedString) -> Self {
            self.attributedMessage = attributedMessage
            return self
        }

        func setMessageColor(_ color: UIColor) -> Self {
            self.messageColor = color
            return self
        }

        func setImage(_ image: UIImage?, width: CGFloat, height: CGFloat) -> Self {
            self.image = image
            self.imageWidth = width
            self.imageHeight = height
            return self
        }

        func setImageUrl(_ url: String?, width: CGFloat, height: CGFloat) -> Self {
            self.imageUrl = url
            self.imageWidth = width
            self.imageHeight = height
            return self
        }

        func setNagativeButton(_ label: String, _ delegate: @escaping (CommonModal) -> Void) -> Self {
            self.nagativeButtonStr = label
            self.nagativeButtonDelegate = delegate
            return self
        }

        func setPositiveButton(_ label: String, _ delegate: @escaping (CommonModal) -> Void) -> Self {
            self.positiveButtonStr = label
            self.positiveButtonDelegate = delegate
            return self
        }

        /*
         color 속성
         */
        func setTitleColor(_ color: UIColor) -> Self {
            self.titleColor = color
            return self
        }

        func messageColor(_ color: UIColor) -> Self {
            self.messageColor = color
            return self
        }

        func setNagativeButtonColor(_ color: UIColor) -> Self {
            self.nagativeButtonColor = color
            return self
        }

        func setPositiveButtonColor(_ color: UIColor) -> Self {
            self.positiveButtonColor = color
            return self
        }

        func setModalBackgroundColor(_ color: UIColor) -> Self {
            self.modalBackgroindColor = color
            return self
        }

        func setLineColor(_ color: UIColor) -> Self {
            self.lineColor = color
            return self
        }

        /*
         글자 크기 속성
         */
        func setTitleFont(_ font: TogetherFontType) -> Self {
            self.titleFont = font
            return self
        }

        func setMessageFont(_ font: TogetherFontType) -> Self {
            self.messageFont = font
            return self
        }

        func setButtonFont(_ font: TogetherFontType) -> Self {
            self.buttonFont = font
            return self
        }

        func build() -> CommonModal {
            CommonModal(viewModel: RefactoringBaseViewModel()).then {
                $0.configure(ModalConfigInfo(title: title,
                                             message: message,
                                             attributedMessage: attributedMessage,
                                             image: image,
                                             imageUrl: imageUrl,
                                             imgWidth: imageWidth,
                                             imgHeight: imageHeight,
                                             nagativeButtonStr: nagativeButtonStr,
                                             positiveButtonStr: positiveButtonStr,
                                             titleColor: titleColor,
                                             messageColor: messageColor,
                                             nagativeButtonColor: nagativeButtonColor,
                                             positiveButtonColor: positiveButtonColor,
                                             modalBackgroundColor: modalBackgroindColor,
                                             lineColor: lineColor,
                                             titleFont: titleFont,
                                             messageFont: messageFont,
                                             buttonFont: buttonFont),
                             nagativeButtonDelegate: nagativeButtonDelegate,
                             positiveButtonDelegate: positiveButtonDelegate)
            }
        }
    }
}
