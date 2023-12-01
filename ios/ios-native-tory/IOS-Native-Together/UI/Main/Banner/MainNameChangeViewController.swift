//
//  MainNameChangeViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/08.
//

import UIKit
import RxSwift
import SnapKit

final class MainNameChangeViewController: RefactoringBaseViewController<MainChangeNameViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let nickNameInputField = UITextField()
    private let nickNameInputBackView = UIView()
    private let confirmButtonLabel = UILabel()
    private let confirmButton = UIView()
    private let closeButton = UIImageView()

    private let maxLength = 8

    override func attribute() {
        super.attribute()

        backgroundView.backgroundColor = .togetherBlack.withAlphaComponent(0.3)

        containerView.backgroundColor = .togetherWhite
        containerView.layer.cornerRadius = 16

        titleLabel.font = R.font.notoSansSemiBold(size: 14)
        titleLabel.text = localizable.modifyProfileName()
        titleLabel.textColor = .togetherBlack

        descriptionLabel.font = R.font.notoSansRegular(size: 12)
        descriptionLabel.text = localizable.nameWarnMessage()
        descriptionLabel.textColor = .togetherGray1

        nickNameInputField.placeholder = ""
        nickNameInputField.textColor = .togetherBlack
        nickNameInputField.keyboardType = .default
        nickNameInputField.textAlignment = .center
        nickNameInputField.clearButtonMode = .never

        nickNameInputBackView.layer.borderWidth = 1
        nickNameInputBackView.layer.cornerRadius = 8
        nickNameInputBackView.layer.borderColor = UIColor.togetherGray2.cgColor

        confirmButtonLabel.font = R.font.notoSansSemiBold(size: 14)
        confirmButtonLabel.text = localizable.modify()
        confirmButtonLabel.textColor = .togetherWhite

        confirmButton.backgroundColor = .togetherPurple
        confirmButton.layer.cornerRadius = 8

        closeButton.image = R.image.default_banner_exit()
    }

    override func layout() {
        super.layout()

        view.addSubviews(backgroundView,
                         containerView,
                         titleLabel,
                         descriptionLabel,
                         nickNameInputBackView,
                         nickNameInputField,
                         confirmButton,
                         confirmButtonLabel,
                         closeButton)

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 270, height: 156))
            $0.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(16)
            $0.centerX.equalTo(containerView)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(containerView)
        }

        nickNameInputBackView.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(containerView).inset(32)
        }
        nickNameInputField.snp.makeConstraints {
            $0.top.bottom.equalTo(nickNameInputBackView)
            $0.leading.trailing.equalTo(nickNameInputBackView).inset(8)
        }

        confirmButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalTo(nickNameInputBackView.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(nickNameInputBackView)
        }

        confirmButtonLabel.snp.makeConstraints {
            $0.center.equalTo(confirmButton)
        }

        closeButton.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.top.trailing.equalTo(containerView)
        }
    }

    override func bind(_ viewModel: MainChangeNameViewModel) {
        super.bind(viewModel)

        backgroundView.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        closeButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        nickNameInputField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                guard text.count > self?.maxLength ?? 0 else { return }
                let endIndex = text.index(text.startIndex, offsetBy: self?.maxLength ?? 0)
                self?.nickNameInputField.text = String(text[..<endIndex])
            })
            .disposed(by: disposeBag)

        confirmButton.rx.baseTapGesture()
            .filter { [weak self] in
                self?.nickNameInputField.text != ""
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<String?>.empty() }
                if self.filterKoreanCharacters(self.nickNameInputField.text) {
                    self.showAlert(localizable.insertNameAgain())
                    return Observable<String?>.empty()
                } else {
                    return Observable.just(self.nickNameInputField.text)
                }
            }
            .bind(to: viewModel.confirmButtonTap)
            .disposed(by: disposeBag)

        viewModel.presentConfirmButtonTap?
            .emit(onNext: { [weak self] isSuccess in
                guard let self = self else { return }
                self.dismiss(animated: true) { [weak self] in
                    if isSuccess {
                        self?.showAlert(localizable.sucessModifyName(), .togetherPurple)
                    } else {
                        self?.dismiss(animated: true) {
                            self?.showAlert(localizable.failureModifyName(), .togetherPurple)
                        }
                    }
                }
            })
            .disposed(by: disposeBag)

        nickNameInputField.text = viewModel.repository.member.value.profileName
    }
}

extension MainNameChangeViewController {
    private func showAlert(_ message: String, _ positiveButtonColor: UIColor? = nil) {
        var alert = CommonModal.Builder()
        alert = alert.setMessage(message)
        alert = alert.setPositiveButton(localizable.confirm()) {
            $0.dismiss(animated: true)
        }
        if let positiveButtonColor {
            alert = alert.setPositiveButtonColor(positiveButtonColor)
        }
        alert.build().show()
    }

    private func filterKoreanCharacters(_ text: String?) -> Bool {
        let isVowelOrConsonant = text?.range(of: "^[ㄱ-ㅎㅏ-ㅣ]+$", options: .regularExpression) != nil
        return isVowelOrConsonant
    }
}
