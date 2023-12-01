//
//  TTCUniversityLoginView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import RxSwift
import RxRelay

final class TTCUniversityLoginView: UIView {

    private let disposeBag = DisposeBag()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let viewModel: TTCLoginViewModel

    private let emailLabel = UILabel()
    private let emailBottomBorder = UIView()
    private let passwordLabel = UILabel()
    private let passwordBottomBorder = UIView()

    init(frame: CGRect = .zero, _ viewModel: TTCLoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func attribute() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholder = localizable.ttcLoginID()
        emailTextField.autocorrectionType = .no
        emailTextField.clearButtonMode = .whileEditing
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = localizable.ttcLoginPasswordPlaceholder()
        passwordTextField.clearButtonMode = .whileEditing

        emailLabel.text = localizable.ttcLoginID()
        emailLabel.font = R.font.notoSansRegular.callAsFunction(size: 14)
        emailBottomBorder.backgroundColor = UIColor("#D9D9D9")
        passwordLabel.text = localizable.ttcLoginPassword()
        passwordLabel.font = R.font.notoSansRegular.callAsFunction(size: 14)
        passwordBottomBorder.backgroundColor = UIColor("#D9D9D9")
    }

    func layout() {
        addSubviews(emailLabel, emailTextField, emailBottomBorder,
                    passwordLabel, passwordTextField, passwordBottomBorder)

        emailLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(22)
        }

        emailBottomBorder.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }

        passwordLabel.snp.makeConstraints {
            $0.bottom.equalTo(passwordTextField.snp.top).offset(-16)
            $0.left.equalToSuperview()
        }

        passwordTextField.snp.makeConstraints {
            $0.bottom.equalTo(passwordBottomBorder.snp.top).offset(-6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(22)
        }

        passwordBottomBorder.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func bind() {
        Observable.combineLatest(emailTextField.rx.text, passwordTextField.rx.text)
            .bind { [weak self] email, password in
                self?.viewModel.checkValidLoginInfo(email, password)
            }
            .disposed(by: disposeBag)
    }
}
