//
//  ChattingLoungePasswordViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/18.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungePasswordViewController: RefactoringBaseViewController<ChattingLoungePasswordViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIImageView()
    private let passwordBackgroundView = UIView()
    private let passwordInputFiled = UITextField()
    private let warningLabel = UILabel()
    private let entranceButton = UIView()
    private let entranceButtonLabel = UILabel()

    private var entranceAbleDelegate: () -> Void = {}

    override func bind(_ viewModel: ChattingLoungePasswordViewModel) {
        super.bind(viewModel)
        containerView.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)

        Observable.merge(backgroundView.rx.baseTapGesture(), closeButton.rx.baseTapGesture())
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        passwordInputFiled.rx.text
            .orEmpty
            .map { $0.prefix(6) }
            .map { String($0) }
            .bind(onNext: { [weak self] in
                self?.warningLabel.isHidden = true
                self?.passwordInputFiled.text = $0
            })
            .disposed(by: disposeBag)

        passwordInputFiled.rx.text
            .orEmpty
            .map {
                !$0.isEmpty && $0.count <= 6
            }
            .map {
                $0 ? .togetherPurple : .togetherGray3
            }
            .bind(to: entranceButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        entranceButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let inputText = self.passwordInputFiled.text ?? ""
                if inputText == viewModel.password {
                    self.dismiss(animated: true) {
                        self.entranceAbleDelegate()
                    }
                } else {
                    self.warningLabel.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()
        backgroundView.backgroundColor = viewModel.isBackgroundClear ? .clear : .togetherBlack.withAlphaComponent(0.7)

        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .togetherWhite

        titleLabel.text = localizable.chattingLoungePasswordPassword()
        titleLabel.configureFont(.bold14)

        closeButton.image = R.image.chatting_lounge_common_exit()

        passwordBackgroundView.layer.cornerRadius = 8
        passwordBackgroundView.layer.borderColor = UIColor("#D9D9D9").cgColor
        passwordBackgroundView.layer.borderWidth = 1

        passwordInputFiled.configureFont(type: .regular14)
        passwordInputFiled.textColor = .togetherBlack
        passwordInputFiled.attributedPlaceholder = NSAttributedString(
            string: localizable.chattingLoungePasswordPasswordInput(),
            attributes: [NSAttributedString
                .Key.foregroundColor: UIColor("#D9D9D9")])
        passwordInputFiled.keyboardType = .default
        passwordInputFiled.textAlignment = .center
        passwordInputFiled.clearButtonMode = .never
        passwordInputFiled.isSecureTextEntry = true

        warningLabel.text = localizable.chattingLoungePasswordPasswordCheck()
        warningLabel.configureFont(.regular10)
        warningLabel.textColor = .red

        entranceButton.layer.cornerRadius = 8

        entranceButtonLabel.text = localizable.chattingLoungePasswordEntrance()
        entranceButtonLabel.configureFont(.bold14)
        entranceButtonLabel.textColor = .togetherWhite
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView, containerView, titleLabel, closeButton,
                         passwordBackgroundView, passwordInputFiled,
                         warningLabel, entranceButton, entranceButtonLabel)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalTo(270)
            $0.height.equalTo(152)
            $0.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(16)
            $0.centerX.equalTo(containerView)
        }
        closeButton.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(4)
            $0.trailing.equalTo(containerView).inset(4)
        }
        passwordBackgroundView.snp.makeConstraints {
            $0.width.equalTo(190)
            $0.height.equalTo(32)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(containerView)
        }
        passwordInputFiled.snp.makeConstraints {
            $0.top.bottom.equalTo(passwordBackgroundView).inset(4)
            $0.leading.trailing.equalTo(passwordBackgroundView).inset(8)
        }
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(passwordBackgroundView.snp.bottom).offset(2)
            $0.centerX.equalTo(containerView)
        }
        entranceButton.snp.makeConstraints {
            $0.width.equalTo(190)
            $0.height.equalTo(32)
            $0.top.equalTo(warningLabel.snp.bottom).offset(6)
            $0.centerX.equalTo(containerView)
        }
        entranceButtonLabel.snp.makeConstraints {
            $0.center.equalTo(entranceButton)
        }
    }
}

extension ChattingLoungePasswordViewController {
    func setEntranceAbleDelegate(_ delegate: @escaping () -> Void) {
        self.entranceAbleDelegate = delegate
    }
}
