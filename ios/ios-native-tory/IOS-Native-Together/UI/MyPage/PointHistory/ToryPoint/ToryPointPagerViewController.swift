//
//  ToryPointTransactionHistoryViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

final class ToryPointPagerViewController: RefactoringBasePagerViewController<ToryPointPagerViewModel> {
    override var navigationTitle: String { localizable.toryPointChargeHistory() }
    private let chargeNavigationButton = UIImageView()
    private let toryPointInfoLabel = UILabel()
    private let whatIsToryImageView = UIImageView()
    private let toryPointBorderView = UIView()
    private let toryPointLabel = UILabel()

    override func attribute() {
        super.attribute()
        chargeNavigationButton.image = R.image.mypage_charge2()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: chargeNavigationButton)

        toryPointInfoLabel.font = R.font.notoSansRegular(size: 16)
        toryPointInfoLabel.text = localizable.toryPointBalance()

        whatIsToryImageView.image = R.image.mypage_whais()

        toryPointBorderView.backgroundColor = .togetherWhite
        toryPointBorderView.layer.cornerRadius = 10
        toryPointBorderView.layer.borderWidth = 1
        toryPointBorderView.layer.borderColor = UIColor.togetherPurple.cgColor

        toryPointLabel.font = R.font.notoSansRegular(size: 16)
        toryPointLabel.textColor = .togetherPurple

        self.buttonBarView = pagerButtonBarView
        self.containerView = containerScrollView

        settings.style.buttonBarBackgroundColor = .togetherWhite
        settings.style.buttonBarItemBackgroundColor = .togetherWhite
        settings.style.selectedBarBackgroundColor = UIColor.togetherPurple
        settings.style.selectedBarHeight = 2
        let fontDto = FontValue.getFont(with: .regular16)
        settings.style.buttonBarItemFont = UIFont(name: fontDto.fontName,
                                                  size: fontDto.fontSize) ?? .systemFont(ofSize: 16)
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
        chargeNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        view.addSubviews(toryPointInfoLabel, whatIsToryImageView,
                         toryPointBorderView, toryPointLabel)

        toryPointInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
        }

        whatIsToryImageView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.centerY.equalTo(toryPointLabel)
            $0.leading.equalTo(toryPointInfoLabel.snp.trailing)

        }

        toryPointBorderView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.centerY.equalTo(toryPointInfoLabel)
            $0.leading.equalTo(whatIsToryImageView.snp.trailing)
            $0.trailing.equalToSuperview().inset(16)
        }

        toryPointLabel.snp.makeConstraints {
            $0.centerY.equalTo(toryPointBorderView)
            $0.trailing.equalTo(toryPointBorderView).inset(18)
        }

        pagerButtonBarView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(toryPointBorderView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(pagerButtonBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }

    override func bind(_ viewModel: ToryPointPagerViewModel) {
        super.bind(viewModel)

        viewModel.toryPoint?
            .drive(toryPointLabel.rx.text)
            .disposed(by: disposeBag)

        chargeNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let pointChargeViewModel = PointChargeViewModel()
                let pointChargeViewController = PointChargeViewController(viewModel: pointChargeViewModel)

                self?.pushViewController(viewController: pointChargeViewController)
            })
            .disposed(by: disposeBag)

        whatIsToryImageView.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                let viewModel = WhatIsPointViewModel(pointStatus: .tory)
                let whatIsPointModal = WhatIsPointViewController(viewModel: viewModel)

                self?.presentPanmodal(panModel: whatIsPointModal, backgroundColor: .togetherPurple)
            })
            .disposed(by: disposeBag)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let chargingViewModel = ToryChargingHistoryViewModel()
        let chargingViewController = ToryChargingHistoryViewController(viewModel: chargingViewModel)

        let transactionViewModel = ToryTransactionHistoryViewModel()
        let transactionViewController = ToryTransactionHistoryViewController(viewModel: transactionViewModel)

        return [chargingViewController, transactionViewController]
    }
}
