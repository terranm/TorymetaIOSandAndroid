//
//  WilldBackgroundView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/15.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonNetworkErrorView: UIView {
    private static let EXIST = 1
    private let disposeBag = DisposeBag()
    private var host: RetryEnabledProtocol?
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIView()
    private let actionButtonLabel = UILabel()
    private var actionDelegate: (CommonNetworkErrorView) -> Void = { _ in }

    override var intrinsicContentSize: CGSize {
        let imgSize = imageView.intrinsicContentSize
        let titleSize = titleLabel.intrinsicContentSize
        let descriptionSize = descriptionLabel.intrinsicContentSize
        let actionButtonSize: CGFloat = 150

        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = imgSize.height + 30 + titleSize.height + 10
            + descriptionSize.height + 40 + actionButtonSize
        return CGSize(width: width, height: height)
    }

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
        titleLabel.configureFont(.bold20)
        titleLabel.textColor = .togetherWhite
        titleLabel.textAlignment = .center

        descriptionLabel.configureFont(.regular16)
        descriptionLabel.textColor = .togetherWhite
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center

        actionButton.backgroundColor = .togetherWhite
        actionButton.layer.cornerRadius = 10

        actionButtonLabel.configureFont(.bold16)
        actionButtonLabel.textColor = .togetherPurple
    }

    private func layout() {
        addSubviews(imageView, titleLabel, descriptionLabel, actionButton, actionButtonLabel)

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        actionButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 150, height: 44))
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }

        actionButtonLabel.snp.makeConstraints {
            $0.center.equalTo(actionButton)
        }
    }

    private func bind() {
        actionButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                self?.host?.processRetry()
                self?.removeFromSuperview()
            })
            .disposed(by: disposeBag)
    }
}

extension CommonNetworkErrorView {
    func show() {
        guard let superView = host?.retryContainerView else { return }
        let alreadyAdded = superView.subviews.contains(where: { $0.tag == CommonNetworkErrorView.EXIST })
        guard !alreadyAdded else { return }

        superView.addSubview(self)
        self.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    struct NetworkErrorConfigInfo {
        let host: RetryEnabledProtocol
        let img: UIImage?
        let imgUrl: String
        let title: String
        let titleColor: UIColor
        let titleFont: TogetherFontType
        let description: String
        let descriptionColor: UIColor
        let descriptionFont: TogetherFontType
        let buttonTitle: String
        let buttonTitleColor: UIColor
        let buttonTitleFont: TogetherFontType
    }
    private func configure(_ networkErrorConfigInfo: NetworkErrorConfigInfo,
                           actionDelegate: @escaping (CommonNetworkErrorView) -> Void) {
        self.host = networkErrorConfigInfo.host
        imageView.image = networkErrorConfigInfo.img

        if !networkErrorConfigInfo.imgUrl.isEmpty {
            imageView.kf.setImage(with: URL(string: networkErrorConfigInfo.imgUrl))
        }

        titleLabel.text = networkErrorConfigInfo.title
        titleLabel.textColor = networkErrorConfigInfo.titleColor
        titleLabel.configureFont(networkErrorConfigInfo.titleFont)

        descriptionLabel.text = networkErrorConfigInfo.description
        descriptionLabel.textColor = networkErrorConfigInfo.descriptionColor
        descriptionLabel.configureFont(networkErrorConfigInfo.descriptionFont)

        self.actionDelegate = actionDelegate
        actionButtonLabel.text = networkErrorConfigInfo.buttonTitle
        actionButtonLabel.textColor = networkErrorConfigInfo.buttonTitleColor
        actionButtonLabel.configureFont(networkErrorConfigInfo.buttonTitleFont)

        // tag 설정
        self.tag = CommonNetworkErrorView.EXIST
        // frame 설정
        frame = CGRect(origin: .zero, size: intrinsicContentSize)
    }
}

extension CommonNetworkErrorView {
    final class Builder {

        private var backgroundColor: UIColor = .togetherWhite

        private var img: UIImage? = R.image.network_error()
        private var imgUrl: String = ""

        private var title: String = localizable.backgroundViewConnect()
        private var titleColor: UIColor = .togetherBlack
        private var titleFont: TogetherFontType = .bold20

        private var description: String = localizable.backgroundViewOffline()
        private var descriptionColor: UIColor = .togetherBlack
        private var descriptionFont: TogetherFontType = .regular16

        private var actionDelegate: (CommonNetworkErrorView) -> Void = { _ in }
        private var buttonTitle: String = localizable.backgroundViewRetry()
        private var buttonTitleColor: UIColor = .togetherPurple
        private var buttonTitleFont: TogetherFontType = .regular16

        func setBackgroundColor(_ color: UIColor) -> Builder {
            self.backgroundColor = color
            return self
        }

        func setUIImage(_ img: UIImage?) -> Builder {
            self.img = img
            return self
        }

        func setImgUrl(_ imgUrl: String) -> Builder {
            self.imgUrl = imgUrl
            return self
        }

        func setTitle(_ title: String) -> Builder {
            self.title = title
            return self
        }

        func setTitleColor(_ color: UIColor) -> Builder {
            self.titleColor = color
            return self
        }

        func setTitleFont(_ font: TogetherFontType) -> Builder {
            self.titleFont = font
            return self
        }

        func setDescription(_ description: String) -> Builder {
            self.description = description
            return self
        }

        func setDescriptionColor(_ color: UIColor) -> Builder {
            self.descriptionColor = color
            return self
        }

        func setDescriptionFont(_ font: TogetherFontType) -> Builder {
            self.descriptionFont = font
            return self
        }

        func setActionButton(_ title: String, _ delegate: @escaping (CommonNetworkErrorView) -> Void) -> Builder {
            self.buttonTitle = title
            self.actionDelegate = delegate
            return self
        }

        func setButtonTitle(_ title: String) -> Builder {
            self.buttonTitle = title
            return self
        }

        func setButtonColor(_ color: UIColor) -> Builder {
            self.buttonTitleColor = color
            return self
        }

        func setButtonFont(_ font: TogetherFontType) -> Builder {
            self.buttonTitleFont = font
            return self
        }

        func build(host: RetryEnabledProtocol) -> CommonNetworkErrorView {
            CommonNetworkErrorView().then {
                $0.configure(NetworkErrorConfigInfo(host: host,
                                                    img: img,
                                                    imgUrl: imgUrl,
                                                    title: title,
                                                    titleColor: titleColor,
                                                    titleFont: titleFont,
                                                    description: description,
                                                    descriptionColor: descriptionColor,
                                                    descriptionFont: descriptionFont,
                                                    buttonTitle: buttonTitle,
                                                    buttonTitleColor: buttonTitleColor,
                                                    buttonTitleFont: buttonTitleFont),
                             actionDelegate: actionDelegate)
            }
        }
    }
}
