//
//  LoginAlarmViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginAlarmSettingViewController: RefactoringBaseViewController<LoginAlarmSettingViewModel> {

    let loginSettingHeaderLabel = WilldUILabel.create(font: .bold16,
                                                      text: localizable.loginAlarmLoginSettings(),
                                                      color: .togetherBlack)

    let autoLoginSettingLabel = WilldUILabel.create(font: .regular16,
                                                    text: localizable.loginAlarmAutoLogin(),
                                                    color: .togetherBlack)

    let autoLoginSwitch = UISwitch().then {
        $0.setOn(false, animated: false)
        $0.onTintColor = .togetherPurple
    }

    let underLineView = WilldUIView.createUnderLineView(height: 1, color: .togetherGray3)

    let eventAlarmSettingHeaderLabel = WilldUILabel.create(font: .bold16,
                                                           text: localizable.loginAlarmEventNoti(),
                                                           color: .togetherBlack)

    let appPushSettingLabel = WilldUILabel.create(font: .regular16,
                                                  text: localizable.loginAlarmPushSetting(),
                                                  color: .togetherBlack)

    let appPushSwitch = UISwitch().then {
        $0.setOn(false, animated: false)
        $0.onTintColor = .togetherPurple
    }

    let emailSettingLabel = WilldUILabel.create(font: .regular16,
                                                text: localizable.loginAlarmEmailMMS(),
                                                color: .togetherBlack)

    let emailSwitch = UISwitch().then {
        $0.setOn(false, animated: false)
        $0.onTintColor = .togetherPurple
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func bind(_ viewModel: LoginAlarmSettingViewModel) {
        super.bind(viewModel)

        viewModel.initAutoLogin
            .drive(onNext: { [weak self] in
                self?.autoLoginSwitch.setOn($0, animated: false)
            })
            .disposed(by: disposeBag)

        viewModel.initAppPush
            .drive(onNext: { [weak self] in
                self?.appPushSwitch.setOn($0, animated: false)
            })
            .disposed(by: disposeBag)

        viewModel.initEmail
            .drive(onNext: { [weak self] in
                self?.emailSwitch.setOn($0, animated: false)
            })
            .disposed(by: disposeBag)

        autoLoginSwitch.rx.isOn
            .bind(to: viewModel.isAutoLogin)
            .disposed(by: disposeBag)

        appPushSwitch.rx.isOn
            .bind(to: viewModel.isAppPush)
            .disposed(by: disposeBag)

        emailSwitch.rx.isOn
            .bind(to: viewModel.isEmail)
            .disposed(by: disposeBag)

        viewModel.presentAutoLogin
            .drive { [weak self] in
                self?.autoLoginSwitch.setOn($0, animated: true)
                self?.userDefaultManager.save(value: $0, key: WDUserDefaultManager.Key.isAutoLogin)
                if $0 {
                    CommonToast.Builder()
                        .setMessage(localizable.loginAlarmActiveAutoLogin())
                        .build()
                        .show()
                } else {
                    CommonToast.Builder()
                        .setMessage(localizable.loginAlarmDeactiveAutoLogin())
                        .build()
                        .show()
                }
            }
            .disposed(by: disposeBag)

        viewModel.presentAppPush
            .drive { [weak self] in
                self?.repository.isPushAgree.accept($0)

                self?.appPushSwitch.setOn($0, animated: true)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                let currentTime = formatter.string(from: Date())
                if $0 {
                    CommonToast.Builder()
                        .setMessage(localizable.loginAlarmActiveDesc(currentTime))
                        .setHeightSize(98)
                        .build()
                        .show()
                } else {
                    CommonToast.Builder()
                        .setMessage(localizable.loginAlarmDeactiveDesc(currentTime))
                        .setHeightSize(98)
                        .build()
                        .show()
                }
            }
            .disposed(by: disposeBag)

        viewModel.presentMail
            .drive { [weak self] in
                self?.emailSwitch.setOn($0, animated: true)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                let currentTime = formatter.string(from: Date())
                if $0 {
                    CommonToast.Builder()
                        .setMessage(localizable.loginAlarmAgreeDesc(currentTime))
                        .setHeightSize(98)
                        .build()
                        .show()
                } else {
                    CommonToast.Builder()
                        .setMessage(localizable.loginAlarmDisagreeDesc(currentTime))
                        .setHeightSize(98)
                        .build()
                        .show()
                }
            }
            .disposed(by: disposeBag)
    }

    override func layout() {
        super.layout()

        view.addSubviews(loginSettingHeaderLabel, autoLoginSettingLabel, autoLoginSwitch, underLineView,
                         eventAlarmSettingHeaderLabel, appPushSettingLabel, appPushSwitch,
                         emailSettingLabel, emailSwitch)

        loginSettingHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.leading.equalToSuperview().inset(16)
        }

        autoLoginSettingLabel.snp.makeConstraints {
            $0.top.equalTo(loginSettingHeaderLabel.snp.bottom).offset(24)
            $0.leading.equalTo(loginSettingHeaderLabel)
        }

        autoLoginSwitch.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginSettingLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        underLineView.snp.makeConstraints {
            $0.top.equalTo(autoLoginSettingLabel.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview()
        }

        eventAlarmSettingHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(35)
            $0.leading.equalTo(loginSettingHeaderLabel)
        }

        appPushSettingLabel.snp.makeConstraints {
            $0.top.equalTo(eventAlarmSettingHeaderLabel.snp.bottom).offset(25)
            $0.leading.equalTo(loginSettingHeaderLabel)
        }

        appPushSwitch.snp.makeConstraints {
            $0.centerY.equalTo(appPushSettingLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        emailSettingLabel.snp.makeConstraints {
            $0.top.equalTo(appPushSettingLabel.snp.bottom).offset(24)
            $0.leading.equalTo(loginSettingHeaderLabel)
        }

        emailSwitch.snp.makeConstraints {
            $0.centerY.equalTo(emailSettingLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
