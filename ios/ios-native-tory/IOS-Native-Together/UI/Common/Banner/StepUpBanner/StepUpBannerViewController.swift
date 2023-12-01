//
//  StepUpBannerViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/28.
//

import UIKit
import RxSwift
import RxCocoa

final class StepUpBannerViewController: RefactoringBaseViewController<RefactoringBaseViewModel> {
    private let blurView = UIView()
    private let closeButton = UIView()
    private let closeLabel = UILabel()
    private let bannerImageView = UIImageView()

    private var delegate: () -> Void = {}

    override func attribute() {
        super.attribute()
        blurView.backgroundColor = .togetherBlack.withAlphaComponent(0.2)

        closeLabel.font = R.font.notoSansSemiBold(size: 14)
        closeLabel.text = localizable.stepUpBannerCloseButtonText()
        closeLabel.textColor = .togetherBlack

        bannerImageView.image = R.image.step_banner()
        bannerImageView.clipsToBounds = true
        bannerImageView.layer.cornerRadius = 25
    }

    override func layout() {
        super.layout()

        view.addSubviews(blurView, bannerImageView, closeButton, closeLabel)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bannerImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 298, height: 648))
            $0.center.equalToSuperview()
        }
        closeLabel.snp.makeConstraints {
            $0.bottom.equalTo(bannerImageView).inset(15)
            $0.trailing.equalTo(bannerImageView).inset(25)
        }
        closeButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.center.equalTo(closeLabel)
        }
    }

    override func bind(_ viewModel: RefactoringBaseViewModel) {
        super.bind(viewModel)

        closeButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.userDefaultManager.save(value: "false", key: WDUserDefaultManager.Key.isStepUpBannerShow)
                self?.dismiss(animated: true) {
                    guard let self = self else { return }
                    self.delegate()
                }
            })
            .disposed(by: disposeBag)
    }

    func setDelegate(_ delegate: @escaping () -> Void) {
        self.delegate = delegate
    }
}
