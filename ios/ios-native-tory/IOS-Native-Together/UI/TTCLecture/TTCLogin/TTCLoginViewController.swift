//
//  TTCLoginViewController.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture

final class TTCLoginViewController: RefactoringBaseViewController<TTCLoginViewModel> {

    private let closeButton = UIButton()
    private lazy var universityInfoView = TTCUniversityInfoView(viewModel)
    private lazy var universityLoginView = TTCUniversityLoginView(viewModel)
    private let submitButton = UIButton()
    private let titleLabel = UILabel()
    private let descLabel = UILabel()

    override func attribute() {
        super.attribute()
        view.backgroundColor = .clear
        closeButton.setImage(R.image.common_back(), for: .normal)

        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 28
        submitButton.setTitle(localizable.ttcLoginSubmit(), for: .normal)
        submitButton.setTitleColor(UIColor("#ffffff"), for: .normal)
        submitButton.setBackgroundColor(UIColor("#6C5CE7"), for: .normal)
        submitButton.setBackgroundColor(UIColor("#D9D9D9"), for: .disabled)

        submitButton.titleLabel?.font = R.font.notoSansSemiBold.callAsFunction(size: 20)
        submitButton.adjustsImageWhenHighlighted = false
        submitButton.isEnabled = false

        titleLabel.font = R.font.notoSansSemiBold.callAsFunction(size: 20)
        titleLabel.text = localizable.ttcLoginTitle()
        titleLabel.textAlignment = .center

        descLabel.font = R.font.notoSansRegular.callAsFunction(size: 14)
        descLabel.numberOfLines = 2
        descLabel.text = localizable.ttcLoginDesc()
    }

    override func layout() {
        super.layout()
        view.addSubviews(closeButton, titleLabel, universityInfoView, universityLoginView, submitButton, descLabel)

        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.size.equalTo(44)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(44)
        }
        universityInfoView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
//            $0.height.equalTo(69) // TODO: 학교 로고 및 교명, 전공명 임시 숨김 처리
            $0.height.equalTo(0)
        }

        universityLoginView.snp.makeConstraints {
            $0.top.equalTo(universityInfoView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(146)
        }

        submitButton.snp.makeConstraints {
            $0.top.equalTo(universityLoginView.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }

        descLabel.snp.makeConstraints {
            $0.top.equalTo(submitButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }

    override func bind(_ viewModel: TTCLoginViewModel) {
        super.bind(viewModel)

        view.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)

        closeButton.rx.controlEvent(.touchUpInside)
            .bind { [weak self] _ in
                self?.viewModel.loginStatusRelay.accept(.cancel)
            }
            .disposed(by: disposeBag)

        viewModel.ttcAuthRelay
            .bind { [weak self] isValid in
                self?.submitButton.isEnabled = isValid
            }
            .disposed(by: disposeBag)

        submitButton.rx.controlEvent(.touchUpInside)
            .bind { [weak self] _ in
                self?.viewModel.tryLogin()
            }
            .disposed(by: disposeBag)

        viewModel.loginStatusRelay
            .bind { [weak self] loginStatus in
                switch loginStatus {
                case .cancel:
                    self?.dismiss(animated: true)
                case let .failure(message):
                    self?.showLoginFailAlert(message)
                case .authorized:
                    self?.dismiss(animated: true)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }

    private func showLoginFailAlert(_ message: String) {
        CommonModal.Builder()
            .setMessage(message)
            .setPositiveButton(localizable.decoConfirm()) { $0.dismiss(animated: true) }
            .build()
            .show()
    }
}
