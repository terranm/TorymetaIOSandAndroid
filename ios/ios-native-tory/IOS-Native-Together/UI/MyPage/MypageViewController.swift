//
//  MypageViewController.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import XLPagerTabStrip
import EasyTipView
import PanModal

final class MypageViewController: RefactoringBasePagerViewController<MypageViewModel> {
    override var analyticsId: String { AnalyticsManager.myPage }
    private let titleNavigationLabel = UILabel()
    private let exitNavigationButton = UIImageView()
    private let settingNavigationButton = UIImageView()
    private let chargeNavigationButton = UIImageView()
    private let profileImgView = UIImageView()
    private let profileDecorageImgView = UIImageView()
    private let nickNameLabel = UILabel()
    private let universityLabel = UILabel()
    private let universityUnderArrowImageView = UIImageView()
    private let universityButton = UIImageView()
    private let toryPointInfoView = PointInfoView(type: 0)
    private let mileagePointInfoView = PointInfoView(type: 1)
    private lazy var pointStackView = UIStackView(arrangedSubviews: [toryPointInfoView, mileagePointInfoView])
    private let underLineView = UIView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if WDUserDefaultManager.shared.guideMypage == "true" {
            let mypageIntroduceBanner = MypageIntroduceBanner(viewModel: RefactoringBaseViewModel())
            mypageIntroduceBanner.view.backgroundColor = .togetherWhite
            mypageIntroduceBanner.modalTransitionStyle = .coverVertical
            mypageIntroduceBanner.modalPresentationStyle = .fullScreen
            self.present(mypageIntroduceBanner, animated: true)
        }
    }

    override func attribute() {
        super.attribute()

        titleNavigationLabel.font = R.font.notoSansSemiBold(size: 20)
        titleNavigationLabel.text = localizable.myPageNavTitle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleNavigationLabel)

        exitNavigationButton.image = R.image.default_banner_exit()
        settingNavigationButton.image = R.image.mypage_settings()
        chargeNavigationButton.image = R.image.mypage_charge2()
        navigationItem.rightBarButtonItems = [
            exitNavigationButton,
            settingNavigationButton,
            chargeNavigationButton
        ].map {
            UIBarButtonItem(customView: $0)
        }

        profileImgView.clipsToBounds = true
        profileImgView.layer.cornerRadius = 48

        profileDecorageImgView.image = R.image.mypage_decorate()

        nickNameLabel.font = R.font.notoSansSemiBold(size: 20)

        universityLabel.font = R.font.notoSansRegular(size: 12)
        universityLabel.text = localizable.myPageUnivUnauthorized()
        universityLabel.textColor = .togetherGray2

        universityUnderArrowImageView.image = R.image.common_under_arrow()

        pointStackView.distribution = .fillEqually
        pointStackView.axis = .horizontal
        pointStackView.spacing = 8

        underLineView.backgroundColor = UIColor("#C7C0FC")

        settings.style.buttonBarBackgroundColor = .togetherWhite
        settings.style.buttonBarItemBackgroundColor = .togetherWhite
        settings.style.selectedBarBackgroundColor = UIColor.togetherPurple
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarItemFont = R.font.notoSansRegular(size: 14) ?? .systemFont(ofSize: 14)
        // swiftlint:disable closure_parameter_position
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,
                                           newCell: ButtonBarViewCell?,
                                           _: CGFloat,
                                           changeCurrentIndex: Bool,
                                           _: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .togetherBlack
            newCell?.label.textColor = .togetherPurple
        }
    }

    override func layout() {
        super.layout()
        [exitNavigationButton, settingNavigationButton, chargeNavigationButton].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(44)
            }
        }
        toryPointInfoView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
        mileagePointInfoView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
        view.addSubviews(profileImgView, profileDecorageImgView, nickNameLabel,
                         universityLabel, universityUnderArrowImageView, universityButton,
                         pointStackView, underLineView)

        profileImgView.snp.makeConstraints {
            $0.size.equalTo(96)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(13)
            $0.leading.equalToSuperview().inset(68)
        }

        profileDecorageImgView.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.bottom.equalTo(profileImgView)
        }

        nickNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImgView.snp.trailing).offset(44)
            $0.top.equalTo(profileImgView).offset(21)
        }

        universityLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nickNameLabel)
        }

        universityUnderArrowImageView.snp.makeConstraints {
            $0.size.equalTo(10)
            $0.centerY.equalTo(universityLabel)
            $0.leading.equalTo(universityLabel.snp.trailing).offset(4)
        }
        universityButton.snp.makeConstraints {
            $0.top.bottom.equalTo(universityLabel)
            $0.leading.equalTo(universityLabel)
            $0.trailing.equalTo(universityUnderArrowImageView)
        }

        pointStackView.snp.makeConstraints {
            $0.top.equalTo(profileImgView.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        underLineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.top.equalTo(pointStackView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }

        pagerButtonBarView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(underLineView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(pagerButtonBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: MypageViewModel) {
        super.bind(viewModel)

        exitNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        settingNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let url = ToryWebViewURL(path: ToryWebViewURLType.setting.path)
                let viewmodel = CommonWebViewModel()
                let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewmodel)

                self?.pushViewController(viewController: commonWebViewController, title: "")
            })
            .disposed(by: disposeBag)

        chargeNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.chargingButtonTap)
            .disposed(by: disposeBag)

        viewModel.universityStr?
            .drive(universityLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.profileImageURL?
            .drive(profileImgView.rx.imageURL)
            .disposed(by: disposeBag)

        viewModel.nickName?
            .drive(nickNameLabel.rx.text)
            .disposed(by: disposeBag)

        universityButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let campusSelectViewModel = CampusSelectViewModel(type: .confirm)
                let campusSelectViewController = CampusSelectViewController(viewModel: campusSelectViewModel)

                self?.presentNavigationViewController(viewController: campusSelectViewController)
            })
            .disposed(by: disposeBag)

        mileagePointInfoView.parentView.rx.baseTapGesture()
            .bind(to: viewModel.mileageButtonTap)
            .disposed(by: disposeBag)

        viewModel.presentMileageDetailPage?
            .emit(onNext: { [weak self] _ in
                let mileageTransactionHistoryViewModel = MileagePointTransactionHistoryViewModel()
                let mileageTransactionHistoryViewController = MileageTransactionHistoryViewController(viewModel: mileageTransactionHistoryViewModel)

                self?.pushViewController(viewController: mileageTransactionHistoryViewController,
                                         title: localizable.myPageTransactionHistory())

            })
            .disposed(by: disposeBag)

        toryPointInfoView.parentView.rx.baseTapGesture()
            .bind(to: viewModel.toryPointButtonTap)
            .disposed(by: disposeBag)

        viewModel.presentToryPointDetailPage?
            .emit(onNext: { [weak self] in
                let toryPointPagerViewModel = ToryPointPagerViewModel()
                let toryPointPagerViewController = ToryPointPagerViewController(viewModel: toryPointPagerViewModel)

                self?.pushViewController(viewController: toryPointPagerViewController, title: "")
            })
            .disposed(by: disposeBag)

        viewModel.presentUserToryPointChargePage?
            .emit(onNext: { [weak self] in
                let pointChargeViewModel = PointChargeViewModel()
                let pointChargeViewController = PointChargeViewController(viewModel: pointChargeViewModel)

                self?.pushViewController(viewController: pointChargeViewController,
                                         title: localizable.myPageChargeHistory())
            })
            .disposed(by: disposeBag)

        profileImgView.rx.baseTapGesture()
            .bind(onNext: { [weak self] _ in
                let profileChangeViewModel = ProfileChangeViewModel()
                let profileChangeViewController = ProfileChangeViewController(viewModel: profileChangeViewModel)

                self?.pushViewController(viewController: profileChangeViewController,
                                         title: localizable.myPageUpdateProfile())
            })
            .disposed(by: disposeBag)

        toryPointInfoView.whatIsImgView.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                let viewModel = WhatIsPointViewModel(pointStatus: .tory)
                let whatIsPointModal = WhatIsPointViewController(viewModel: viewModel)

                self?.presentPanmodal(panModel: whatIsPointModal, backgroundColor: .togetherPurple)
            })
            .disposed(by: disposeBag)

        mileagePointInfoView.whatIsImgView.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                let viewModel = WhatIsPointViewModel(pointStatus: .mileage)
                let whatIsPointModal = WhatIsPointViewController(viewModel: viewModel)

                self?.presentPanmodal(panModel: whatIsPointModal, backgroundColor: .togetherPurple)
            })
            .disposed(by: disposeBag)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let myWriteViewModel = MyWriteViewModel()
        let myWriteVc = MyWriteViewController(viewModel: myWriteViewModel)
        myWriteVc.setDelegate { [weak self] in
            let url = ToryWebViewURL(myWriteDetail: $0)
            let viewmodel = CommonWebViewModel()
            let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewmodel)

            self?.pushViewController(viewController: commonWebViewController)
        }
        let myCommentViewmodel = MyCommentViewModel()
        let myCommentVc = MyCommentViewController(viewModel: myCommentViewmodel)
        myCommentVc.setDelegate { [weak self] in
            let url = ToryWebViewURL(myCommentDetail: $0)
            let viewmodel = CommonWebViewModel()
            let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewmodel)

            self?.pushViewController(viewController: commonWebViewController)
        }
        return [myWriteVc, myCommentVc]
    }
}
