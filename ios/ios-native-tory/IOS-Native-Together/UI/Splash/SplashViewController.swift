//
//  LaunchViewController.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SplashViewController: RefactoringBaseViewController<SplashViewModel> {

    override var analyticsId: String { AnalyticsManager.intro }
    private let appIconImageView = UIImageView()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PushNotificationManager.globalNavigationRelay?.accept(navigationController)
    }

    override func attribute() {
        super.attribute()
        appIconImageView.image = R.image.appIcon_border()
        appIconImageView.contentMode = .scaleAspectFit
    }

    override func layout() {
        super.layout()
        view.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 110, height: 106))
            $0.center.equalToSuperview()
        }
    }

    override func bind(_ viewModel: SplashViewModel) {
        super.bind(viewModel)
        /*
         1. AppVersionCheck
         2. isAutoLogin
         3. init
         4. universityCode
         */
        self.viewModel.isAutoLogin
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                if $0 {
                    _ = self.repository.updatePushToken()
                        .take(1)
                        .subscribe(onNext: {
                            if !$0 {
                                self.showTemporaryAlert()
                            }
                        })
                } else {
                    let onboardingViewController = OnboardingViewController(viewModel: RefactoringBaseViewModel())
                    self.changeRootViewController(viewController: onboardingViewController, backgroundColor: .togetherWhite)
                }
            })
            .disposed(by: disposeBag)

        self.viewModel.isUniversityConfirm
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                WDPermissionManager.shared.isPermissionPageShow {
                    if $0 {
                        let requestPermissionViewModel = RequestPermissionViewModel()
                        let requestPermissionViewController = RequestPermissionViewController(viewModel: requestPermissionViewModel)

                        self.changeRootViewController(viewController: requestPermissionViewController)
                    } else {
                        if !WDRepository.pushActionUrl.isEmpty {
                            let avatarReViewViewModel = AvatarPreviewViewModel()
                            let newMainViewModel = MainViewModel(avatarReViewViewModel)
                            let newMainViewController = MainViewController(viewModel: newMainViewModel)

                            self.changeRootViewController(viewController: newMainViewController)
                        } else {
                            let avatarReViewViewModel = AvatarPreviewViewModel()
                            let newMainViewModel = MainViewModel(avatarReViewViewModel)
                            let newMainViewController = MainViewController(viewModel: newMainViewModel)

                            self.changeRootViewController(viewController: newMainViewController)
                        }
                    }
                }
            })
            .disposed(by: disposeBag)

        self.viewModel.appversionCheck
            .drive(onNext: { [weak self] in
                guard let self = self else { return }

                switch $0 {
                case .noUpdate:
                    self.viewModel.processState.accept(0)
                case .optionalUpdate:
                    if AppConfigure.isProductRelease {
                        self.showRecommendUpdateAlert()
                    } else {
                        self.viewModel.processState.accept(0)
                    }
                case .forceUpdate:
                    if AppConfigure.isProductRelease {
                        self.showForcedUpdateAlert()
                    } else {
                        self.viewModel.processState.accept(0)
                    }
                }

            })
            .disposed(by: disposeBag)
    }
}

extension SplashViewController {
    private func showTemporaryAlert() {
        CommonModal.Builder()
            .setTitle(localizable.splashErrorTitle())
            .setMessage(localizable.splashErrorMessage())
            .setPositiveButton(localizable.splashRestartMessage()) {
                $0.dismiss(animated: true)
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
            }
            .build()
            .show()
    }

    private func showRecommendUpdateAlert() {
        CommonModal.Builder()
            .setTitle(localizable.splashNotifyTitle())
            .setMessage(localizable.recommendUpdateMessage())
            .setNagativeButton(localizable.recommendUpdateIgnore()) { _ in
                self.viewModel.processState.accept(0)
            }
            .setPositiveButton(localizable.recommendUpdateConfirm()) { _ in
                self.openAppStore(appId: AppConfigure.appleAppstoreID)
            }
            .build()
            .show()
    }

    private func showForcedUpdateAlert() {
        CommonModal.Builder()
            .setTitle(localizable.splashNotifyTitle())
            .setMessage(localizable.forcedUpdateMessage())
            .setPositiveButton(localizable.forcedUpdateConfirm()) { _ in
                self.openAppStore(appId: AppConfigure.appleAppstoreID)
            }
            .build()
            .show()
    }

    private func openAppStore(appId: Int) {
        let url = "itms-apps://itunes.apple.com/app/\(appId)"
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}
