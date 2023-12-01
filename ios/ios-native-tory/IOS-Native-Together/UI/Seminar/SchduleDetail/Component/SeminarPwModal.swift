//
//  SeminarPwModal.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import PanModal
import RxSwift
import RxCocoa

final class SeminarPwModal: RefactoringBaseViewController<SeminarPwModalViewModel> {
    private let titleLabel = WilldUILabel.create(font: .bold14,
                                                 text: localizable.seminarPasswordInsertPasswordTitle(),
                                                 color: .togetherBlack)

    private let pwInfoLabel = WilldUILabel.create(font: .regular14,
                                                  text: localizable.seminarPasswordInsertPassword(),
                                                  color: .togetherBlack)

    private lazy var pwInputTextField = WilldUITextField(
        .init(fontType: .regular20,
              placeholder: localizable.seminarPasswordInsertPasswordDesc(), keyboardType: .default,
              isSecureTextEntry: true))
//    private let pwInputTextField = WilldUITextField.create(
//        fontType: .regular20,
//        placeholder: localizable.seminarPasswordInsertPasswordDesc(),
//        textColor: .togetherBlack,
//        keyboardType: .default,
//        textAlignment: .left,
//        clearButtonMode: .whileEditing
//    ).then {
//        $0.isSecureTextEntry = true
//    }

    private let pwUnderlineView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        $0.backgroundColor = .togetherGray3
    }

    private let pwConfirmLabel = WilldUILabel.create(font: .regular14,
                                                     text: localizable.seminarPasswordCheck(),
                                                     color: .togetherBlack)

    private lazy var pwConfirmTextFeild = WilldUITextField(.init(fontType: .regular20,
                                                                 placeholder: localizable.seminarPasswordInsertAgain(),
                                                                 isSecureTextEntry: true))
//    private let pwConfirmTextFeild = WilldUITextField.create(
//        fontType: .regular20,
//        placeholder: localizable.seminarPasswordInsertAgain(),
//        textColor: .togetherBlack,
//        keyboardType: .default,
//        textAlignment: .left,
//        clearButtonMode: .whileEditing
//    ).then {
//        $0.isSecureTextEntry = true
//    }

    private let pwConfirmUnderlineView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        $0.backgroundColor = .togetherGray3
    }

    private let completeButtonLabel = WilldUILabel.create(font: .bold20,
                                                          text: localizable.seminarPasswordConfirm(),
                                                          color: .togetherWhite)

    private lazy var completeButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 56).isActive = true
        $0.layer.cornerRadius = 28
        $0.backgroundColor = .togetherPurple

        $0.addSubview(completeButtonLabel)
        completeButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let maxLength = 20
    private var isSucess = false

    private var completeDelegate: (String?) -> Void = { _ in }

    override func bind(_ viewModel: SeminarPwModalViewModel) {
        super.bind(viewModel)
        view.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)

        pwInputTextField.becomeFirstResponder()

        pwInputTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                guard text.count > self?.maxLength ?? 0 else {
                    return
                }

                let endIndex = text.index(text.startIndex, offsetBy: self?.maxLength ?? 0)
                self?.pwInputTextField.text = String(text[..<endIndex])
            })
            .disposed(by: disposeBag)

        pwConfirmTextFeild.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                guard text.count > self?.maxLength ?? 0 else {
                    return
                }

                let endIndex = text.index(text.startIndex, offsetBy: self?.maxLength ?? 0)
                self?.pwConfirmTextFeild.text = String(text[..<endIndex])
            })
            .disposed(by: disposeBag)

        completeButton.rx.baseTapGesture()
            .bind(to: viewModel.completeButtonTap)
            .disposed(by: disposeBag)

        pwInputTextField.rx.text
            .map { $0?.isEmpty ?? false }
            .map { return $0 ? UIColor.togetherGray3 : UIColor.togetherPurple }
            .bind(to: pwUnderlineView.rx.backgroundColor)
            .disposed(by: disposeBag)

        pwConfirmTextFeild.rx.text
            .map { $0?.isEmpty ?? false }
            .map { return $0 ? UIColor.togetherGray3 : UIColor.togetherPurple }
            .bind(to: pwConfirmUnderlineView.rx.backgroundColor)
            .disposed(by: disposeBag)

        viewModel.presentCompleteButton
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                if viewModel.hidePasswordConfirm {
                    if self.pwInputTextField.text?.count ?? 0 > 0 {
                        self.isSucess = true
                        self.dismiss(animated: true) {
                            self.completeDelegate(self.pwInputTextField.text)
                        }
                    } else {
                        CommonModal.Builder()
                            .setTitle(localizable.seminarPasswordAlert())
                            .setMessage(localizable.seminarPasswordInsertPasswordDesc())
                            .setPositiveButton(localizable.seminarPasswordConfirm()) {
                                $0.dismiss(animated: true)
                            }
                            .setPositiveButtonColor(.togetherPurple)
                            .build()
                            .show()
                    }
                } else {
                    if self.pwInputTextField.text == self.pwConfirmTextFeild.text {
                        self.isSucess = true
                        self.dismiss(animated: true) {
                            self.completeDelegate(self.pwInputTextField.text)
                        }
                    } else {
                        CommonModal.Builder()
                            .setTitle(localizable.seminarPasswordAlert())
                            .setMessage(localizable.seminarPasswordWrongMessage())
                            .setPositiveButton(localizable.seminarPasswordConfirm()) {
                                $0.dismiss(animated: true)
                            }
                            .setPositiveButtonColor(.togetherPurple)
                            .build()
                            .show()
                    }
                }
            })
            .disposed(by: disposeBag)
    }

//    func isValidPassword(_ password: String) -> Bool {
//        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$"
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
//        return passwordTest.evaluate(with: password)
//    }

    func setCompleteDelegate(_ delegate: @escaping (String?) -> Void) {
        self.completeDelegate = delegate
    }

    override func layout() {
        super.layout()

        pwConfirmLabel.isHidden = viewModel.hidePasswordConfirm
        pwConfirmTextFeild.isHidden = viewModel.hidePasswordConfirm
        pwConfirmUnderlineView.isHidden = viewModel.hidePasswordConfirm

        view.addSubviews(titleLabel, pwInfoLabel, pwInputTextField, pwUnderlineView,
                         pwConfirmLabel, pwConfirmTextFeild, pwConfirmUnderlineView,
                         completeButton)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        pwInfoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.leading.equalTo(titleLabel)
        }

        pwInputTextField.snp.makeConstraints {
            $0.top.equalTo(pwInfoLabel.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        pwUnderlineView.snp.makeConstraints {
            $0.top.equalTo(pwInputTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(pwInputTextField)
        }

        pwConfirmLabel.snp.makeConstraints {
            $0.top.equalTo(pwUnderlineView.snp.bottom).offset(40)
            $0.leading.equalTo(titleLabel)
        }

        pwConfirmTextFeild.snp.makeConstraints {
            $0.top.equalTo(pwConfirmLabel.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        pwConfirmUnderlineView.snp.makeConstraints {
            $0.top.equalTo(pwConfirmTextFeild.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(pwConfirmTextFeild)
        }

        completeButton.snp.makeConstraints {
            $0.top.equalTo(pwConfirmUnderlineView.snp.bottom).offset(42)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

extension SeminarPwModal: PanModalPresentable {

    var showDragIndicator: Bool {
        return false
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }

    var anchorModalToLongForm: Bool {
        return false
    }

    func panModalDidDismiss() {
        if !isSucess {
            completeDelegate("")
        }
    }
}
