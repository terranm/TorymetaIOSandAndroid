//
//  MypageIntroduceBannerViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class MypageIntroduceBanner: RefactoringBaseViewController<RefactoringBaseViewModel> {
    let backgroundImageView = UIImageView()
    let exitImageView = UIImageView()
    lazy var exitLabel = UILabel()

    override func attribute() {
        super.attribute()
        backgroundImageView.image = R.image.mypage_introduceBack_img()

        exitImageView.image = R.image.introduce_exit()
        exitImageView.contentMode = .scaleAspectFill

        exitLabel.font = R.font.notoSansRegular(size: 16)
        exitLabel.text = localizable.mypageIntroduceBannerDontWatchAgain()
        exitLabel.textColor = .togetherBlack
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundImageView, exitImageView, exitLabel)

        backgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }

        exitLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(16)
        }

        exitImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalTo(exitLabel)
            $0.trailing.equalTo(exitLabel.snp.leading)
        }
    }

    override func bind(_ viewModel: RefactoringBaseViewModel) {
        super.bind(viewModel)
        Observable.merge(exitLabel.rx.baseTapGesture(), exitImageView.rx.baseTapGesture())
            .bind(onNext: { [weak self] in
                WDUserDefaultManager.shared.save(value: "false", key: .guideMypage)
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
