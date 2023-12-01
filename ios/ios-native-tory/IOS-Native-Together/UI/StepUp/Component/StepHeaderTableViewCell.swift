//
//  StepHeaderTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/13.
//

import UIKit
import RxSwift
import RxCocoa

final class StepHeaderTableViewCell: UIView {

    let disposeBag = DisposeBag()

    private let checkInButton = WilldUIView.createFillView(backgroudColor: .togetherPurple,
                                                           heightType: .small,
                                                           cornerRoundType: .medium)
    private let checkInButtonLabel = WilldUILabel.create(font: .regular16,
                                                         text: localizable.stepHeaderInsideCampus(),
                                                         color: .togetherWhite)
    private let checkOutButton = WilldUIView.createBorderView(borderColor: .togetherPurple,
                                                              heightType: .small,
                                                              cornerRoundType: .medium)
    private let checkOutButtonLabel = WilldUILabel.create(font: .regular16,
                                                          text: localizable.stepHeaderOutsideCampus(),
                                                          color: .togetherPurple)
    private lazy var checkInOutStackView = UIStackView(arrangedSubviews: [checkInButton, checkOutButton]).then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = 20
    }
    private let infoLabel = WilldUILabel.create(font: .bold16,
                                                text: localizable.stepHeaderCurrentSteps(),
                                                color: .togetherBlack)
    private let whatIsButton = WilldUIImageView.create(size: 44, assetsName: R.image.step_what.name, type: .plain)
    private let stepCountingLabel = WilldUILabel.create(font: .bold32, text: "", color: .clear)
    private let maxCountingLabel = WilldUILabel.create(font: .regular14, text: "", color: .togetherGray2)
    private let stepImageView = WilldUIImageView.create(width: 110,
                                                        height: 92,
                                                        contentMode: .scaleAspectFit,
                                                        type: .plain)
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubviews(checkInOutStackView, checkInButtonLabel, checkOutButtonLabel,
                    infoLabel, whatIsButton, stepCountingLabel, maxCountingLabel, stepImageView)

        checkInOutStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        checkInButtonLabel.snp.makeConstraints {
            $0.center.equalTo(checkInButton)
        }

        checkOutButtonLabel.snp.makeConstraints {
            $0.center.equalTo(checkOutButton)
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(checkInOutStackView.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
        }

        whatIsButton.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel)
            $0.leading.equalTo(infoLabel.snp.trailing)
        }

        stepCountingLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(infoLabel)
        }

        maxCountingLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountingLabel.snp.bottom).offset(6)
            $0.centerX.equalTo(infoLabel)
        }

        stepImageView.snp.makeConstraints {
            $0.top.equalTo(maxCountingLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(62)
        }
    }

    func bind(_ viewModel: StepUpViewModel) {
        whatIsButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.showWhatIsBanner()
            }
            .disposed(by: disposeBag)

        Observable
            .merge(checkOutButton.rx.tapGesture().map { _ in return  StepUpViewModel.State.checkOut },
                   checkInButton.rx.tapGesture().map { _ in return StepUpViewModel.State.checkIn })
            .distinctUntilChanged()
            .bind(to: viewModel.checkInOutUistate)
            .disposed(by: disposeBag)

        viewModel.checkInOutUistate
            .bind { [weak self] in
                self?.setCheckStatusUI($0)
            }
            .disposed(by: disposeBag)

        viewModel.stepCounting
            .map {
                WDHelper.numberToNumberSeparator($0)
            }
            .bind(to: stepCountingLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.stepColor
            .drive(stepCountingLabel.rx.textColor)
            .disposed(by: disposeBag)

        viewModel.countingMax
            .map {
                "/ \(WDHelper.numberToNumberSeparator($0))" + localizable.stepPaySteps()
            }
            .drive(maxCountingLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.stepImage
            .drive(stepImageView.rx.image)
            .disposed(by: disposeBag)
    }

    private func showWhatIsBanner() {
        let banner = StepUpBannerViewController(viewModel: RefactoringBaseViewModel())
        banner.modalTransitionStyle = .crossDissolve
        banner.modalPresentationStyle = .overFullScreen
        banner.view.backgroundColor = .clear
        banner.setDelegate {
            let userDefaultManager = WDUserDefaultManager.shared
            userDefaultManager.save(value: "false", key: WDUserDefaultManager.Key.isStepUpBannerShow)
            banner.dismiss(animated: true)
        }
        topMostViewController?.present(banner, animated: true)
    }

    private func setCheckStatusUI(_ checkStatus: StepUpViewModel.State) {
        switch checkStatus {
        case.checkIn:
            self.checkInButton.configureBackgroundColor(color: .togetherPurple)
            self.checkInButton.configureBorder(width: 0, color: .clear)
            self.checkInButtonLabel.textColor = .togetherWhite

            self.checkOutButton.configureBackgroundColor(color: .togetherWhite)
            self.checkOutButton.configureBorder(width: 1, color: .togetherPurple)
            self.checkOutButtonLabel.textColor = .togetherPurple

        case.checkOut:
            self.checkInButton.configureBackgroundColor(color: .togetherWhite)
            self.checkInButton.configureBorder(width: 1, color: .togetherPurple)
            self.checkInButtonLabel.textColor = .togetherPurple

            self.checkOutButton.configureBackgroundColor(color: .togetherPurple)
            self.checkOutButton.configureBorder(width: 0, color: .clear)
            self.checkOutButtonLabel.textColor = .togetherWhite
        }
    }
}
