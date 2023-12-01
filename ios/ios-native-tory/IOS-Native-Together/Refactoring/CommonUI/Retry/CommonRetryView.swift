//
//  CommonRetryView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/24.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonRetryView: UIView {
    private static let EXIST = 1
    private let disposeBag = DisposeBag()
    private var host: RetryEnabledProtocol?
    private let titleLabel = UILabel()
    private let buttonLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let titleSize = titleLabel.intrinsicContentSize
        let buttonSize = buttonLabel.intrinsicContentSize
        let width = min(titleSize.width, buttonSize.width)
        let height = titleSize.height + 16 + buttonSize.height
        return CGSize(width: width, height: height)
    }

    private func attribute() {
        buttonLabel.textColor = .togetherPurple
    }

    private func layout() {
        addSubviews(titleLabel, buttonLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        buttonLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(titleLabel)
        }
    }

    private func bind() {
        buttonLabel.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.host?.processRetry()
                self?.removeFromSuperview()
            })
            .disposed(by: disposeBag)
    }
}

extension CommonRetryView {
    func show() {
        guard let superView = host?.retryContainerView else { return }
        let alreadyAdded = superView.subviews.contains(where: { $0.tag == CommonRetryView.EXIST })
        guard !alreadyAdded else { return }

        superView.addSubview(self)
        self.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func configure(host: RetryEnabledProtocol?, _ title: String, _ buttonText: String) {
        self.host = host
        titleLabel.text = title
        buttonLabel.text = buttonText

        /*
         tag 설정
         */
        self.tag = CommonRetryView.EXIST
        /*
         frame 설정
         */
        self.frame = CGRect(origin: .zero, size: intrinsicContentSize)
    }
}

extension CommonRetryView {
    final class Builder {
        var title: String = ""
        var buttoText: String = ""

        func setTitle(_ title: String) -> Self {
            self.title = title
            return self
        }

        func setButtonText(_ text: String) -> Self {
            self.buttoText = text
            return self
        }

        func build(host: RetryEnabledProtocol?) -> CommonRetryView {
            CommonRetryView().then {
                $0.configure(host: host, title, buttoText)
            }
        }
    }
}
