//
//  ChattingLoungeChattingEntranceContentView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/06/30.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Title View
final class ChattingLoungeChattingEntranceTitleView: UIView {

    private let disposeBag = DisposeBag()
    private let parentViewModel: ChattingLoungeChattingEntranceViewModel
    private let titleLabel = UILabel()
    private let titleTextFieldBackgroundView = UIView()
    let titleTextField = UITextField()
    private let underlineView = UIView()

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 35
        return CGSize(width: width, height: height)
    }

    init(frame: CGRect = .zero, parentViewModel: ChattingLoungeChattingEntranceViewModel) {
        self.parentViewModel = parentViewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(parentViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(_ viewModel: ChattingLoungeChattingEntranceViewModel) {
        titleTextField.rx.text
            .orEmpty
            .map { $0.prefix(25) }
            .map { String($0) }
            .bind(onNext: { [weak self] in
                viewModel.title.accept($0)
                self?.titleTextField.text = $0
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        titleLabel.attributedText = NSMutableAttributedString()
            .attributed(localizable.chattingLoungeChattingEntranceTitleTitle(), fontType: .bold12, fontColor: .black)
            .attributed("＊", fontType: .regular14, fontColor: .red)

        titleTextFieldBackgroundView.layer.cornerRadius = 6
        titleTextFieldBackgroundView.backgroundColor = UIColor("#F8F8FA")

        titleTextField.configureFont(type: .regular12)
        titleTextField.textColor = .togetherBlack
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: localizable.chattingLoungeChattingEntranceTitleTitleCreateInputMessage(),
            attributes: [NSAttributedString
                .Key.foregroundColor: UIColor("#D9D9D9")])
        titleTextField.keyboardType = .default
        titleTextField.textAlignment = .left

        underlineView.backgroundColor = UIColor("#F8F8FA")
    }

    private func layout() {
        addSubviews(titleLabel, titleTextFieldBackgroundView, titleTextField, underlineView)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        titleTextFieldBackgroundView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(300)
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(25)
        }
        titleTextField.snp.makeConstraints {
            $0.top.bottom.equalTo(titleTextFieldBackgroundView).inset(6)
            $0.leading.trailing.equalTo(titleTextFieldBackgroundView).inset(8)
        }
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(titleTextFieldBackgroundView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Public Option View 
final class ChattingLoungeChattingEntrancePublicOptionView: UIView {
    private let disposeBag = DisposeBag()
    private let parentViewModel: ChattingLoungeChattingEntranceViewModel
    private let publicLabel = UILabel()
    private let openSelectView = SelectView(name: localizable.chattingLoungeChattingEntrancePublicOptionOpen())
    private let secretSelectView = SelectView(name: localizable.chattingLoungeChattingEntrancePublicOptionSecret())
    let warningLabel = UILabel()

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let heigth: CGFloat = 44
        return CGSize(width: width, height: heigth)
    }

    init(frame: CGRect = .zero, parentViewModel: ChattingLoungeChattingEntranceViewModel) {
        self.parentViewModel = parentViewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(parentViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        publicLabel.attributedText = NSMutableAttributedString()
            .attributed(localizable.chattingLoungeChattingEntrancePublicOptionDisclosure(),
                        fontType: .bold12,
                        fontColor: .black)
            .attributed("＊", fontType: .regular14, fontColor: .red)

        warningLabel.text = localizable.chattingLoungeChattingEntrancePublicOptionPasswordNotMachMessage()
        warningLabel.configureFont(.regular10)
        warningLabel.textColor = .red
    }

    private func bind(_ viewModel: ChattingLoungeChattingEntranceViewModel) {
        viewModel.isSecret
            .bind(onNext: { [weak self] in
                self?.allCheckOff()
                if $0 {
                    self?.secretSelectView.checkOn()
                } else {
                    self?.openSelectView.checkOn()
                }
            })
            .disposed(by: disposeBag)

        openSelectView.rx.baseTapGesture()
            .map { false }
            .bind(to: viewModel.isSecret)
            .disposed(by: disposeBag)

        secretSelectView.rx.baseTapGesture()
            .map { true }
            .bind(to: viewModel.isSecret)
            .disposed(by: disposeBag)
    }

    private func allCheckOff() {
        openSelectView.checkOff()
        secretSelectView.checkOff()
    }

    private func layout() {
        addSubviews(publicLabel, openSelectView, secretSelectView, warningLabel)
        publicLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        openSelectView.snp.makeConstraints {
            $0.centerY.equalTo(publicLabel)
            $0.leading.equalTo(publicLabel.snp.trailing).offset(25)
        }
        secretSelectView.snp.makeConstraints {
            $0.centerY.equalTo(publicLabel)
            $0.leading.equalTo(openSelectView.snp.trailing).offset(2)
        }
        warningLabel.snp.makeConstraints {
            $0.centerY.equalTo(publicLabel)
            $0.trailing.equalToSuperview()
        }
    }

    final class SelectView: UIView {
        private let button = UIImageView()
        private let buttonLabel = UILabel()

        override var intrinsicContentSize: CGSize {
            let width: CGFloat = 44 + buttonLabel.intrinsicContentSize.width
            let height: CGFloat = 44
            return CGSize(width: width, height: height)
        }

        init(frame: CGRect = .zero, name: String) {
            buttonLabel.text = name
            super.init(frame: frame)
            attribute()
            initUI()
            layout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func checkOn() {
            button.image = R.image.chat_enterance_on()
        }

        func checkOff() {
            initUI()
        }

        private func initUI() {
            button.image = R.image.chat_enterance_off()
        }

        private func attribute() {
            buttonLabel.configureFont(.regular14)
        }

        private func layout() {
            addSubviews(button, buttonLabel)
            snp.makeConstraints {
                $0.size.equalTo(intrinsicContentSize)
            }
            button.snp.makeConstraints {
                $0.width.height.equalTo(18)
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
            }

            buttonLabel.snp.makeConstraints {
                $0.centerY.equalTo(button)
                $0.leading.equalTo(button.snp.trailing).offset(12)
            }
        }

    }
}

// MARK: - PasswordInput View
final class ChattingLoungeChattingEntrancePasswordInputView: UIView {
    private let disposeBag = DisposeBag()
    private let parentViewModel: ChattingLoungeChattingEntranceViewModel
    private let backgroundView = UIView()
    private let passwordInputView = InputView()
    private let passwordConfirmView = InputView()

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let hegith: CGFloat = 44
        return CGSize(width: width, height: hegith)
    }

    init(frame: CGRect = .zero, parentViewModel: ChattingLoungeChattingEntranceViewModel) {
        self.parentViewModel = parentViewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(parentViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initStatus() {
        passwordInputView.initStatus()
        passwordConfirmView.initStatus()
    }

    private func bind(_ viewModel: ChattingLoungeChattingEntranceViewModel) {
        passwordInputView.inputTextObserver()
            .orEmpty
            .map { $0.prefix(6) }
            .map { String($0) }
            .bind(onNext: { [weak self] in
                viewModel.secretPassword.accept($0)
                self?.passwordInputView.setInputText(text: $0)
            })
            .disposed(by: disposeBag)

        passwordConfirmView.inputTextObserver()
            .orEmpty
            .map { $0.prefix(6) }
            .map { String($0) }
            .bind(onNext: { [weak self] in
                viewModel.secretConformPassword.accept($0)
                self?.passwordConfirmView.setInputText(text: $0)
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        backgroundView.layer.cornerRadius = 8
        backgroundView.backgroundColor = UIColor("#F8F8FA")

        passwordInputView.setTitle(
            text: localizable.chattingLoungeChattingEntrancePasswordInputPassword())
        passwordInputView.setTextInputPlaceHold(
            placeHolder: localizable.chattingLoungeChattingEntrancePasswordInputPasswordPlacholder())

        passwordConfirmView.setTitle(
            text: localizable.chattingLoungeChattingEntrancePasswordInputPasswordConfirm())
        passwordConfirmView.setTextInputPlaceHold(
            placeHolder: localizable.chattingLoungeChattingEntrancePasswordInputPasswordConfirmPlaceholder())
    }

    private func layout() {
        addSubviews(backgroundView, passwordInputView, passwordConfirmView)
        snp.makeConstraints {
            $0.size.equalTo(intrinsicContentSize)
        }
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        passwordInputView.snp.makeConstraints {
            $0.centerY.equalTo(backgroundView)
            $0.leading.equalTo(backgroundView).inset(6)
        }
        passwordConfirmView.snp.makeConstraints {
            $0.centerY.equalTo(backgroundView)
            $0.leading.equalTo(passwordInputView.snp.trailing).offset(6)
        }
    }

    final class InputView: UIView {
        private let titleLabel = UILabel()
        private let textInputBackgroundView = UIView()
        private let textInputField = UITextField()

        override var intrinsicContentSize: CGSize {
            let width: CGFloat = titleLabel.intrinsicContentSize.width + 118
            let height: CGFloat = 30
            return CGSize(width: width, height: height)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            attribute()
            layout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setInputText(text: String) {
            textInputField.text = text

        }

        func inputTextObserver() -> ControlProperty<String?> {
            textInputField.rx.text
        }

        func initStatus() {
            textInputField.text = ""
        }

        func setTitle(text: String) {
            titleLabel.attributedText = NSMutableAttributedString()
                .attributed(text, fontType: .regular10, fontColor: .black)
                .attributed("＊", fontType: .regular14, fontColor: .red)
            snp.makeConstraints {
                $0.size.equalTo(intrinsicContentSize)
            }
        }

        func setTextInputPlaceHold(placeHolder: String) {
            textInputField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                                      attributes: [NSAttributedString
                                                                        .Key.foregroundColor: UIColor("#D9D9D9")])
        }

        private func attribute() {
            textInputBackgroundView.layer.cornerRadius = 8
            textInputBackgroundView.layer.borderColor = UIColor("#E6E6E6").cgColor
            textInputBackgroundView.layer.borderWidth = 1

            textInputField.configureFont(type: .regular10)
            textInputField.textColor = .togetherBlack

            textInputField.keyboardType = .default
            textInputField.textAlignment = .left
            textInputField.clearButtonMode = .never
            textInputField.isSecureTextEntry = true
        }

        private func layout() {
            addSubviews(titleLabel, textInputBackgroundView, textInputField)
            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
            }
            textInputBackgroundView.snp.makeConstraints {
                $0.width.equalTo(120)
                $0.height.equalTo(30)
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(titleLabel.snp.trailing)
            }
            textInputField.snp.makeConstraints {
                $0.top.bottom.equalTo(textInputBackgroundView).inset(6)
                $0.leading.trailing.equalTo(textInputBackgroundView).inset(8)
            }
        }
    }
}
