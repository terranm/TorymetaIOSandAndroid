//
//  BannerSlideOptionView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/13.
//

import UIKit
import RxSwift
import RxCocoa

final class BottomBannerSlideOptionView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: BottomSlideBannerViewModel
    private let todayDoneButton = UILabel()
    private let closeButton = UILabel()

    override var intrinsicContentSize: CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 42
        return CGSize(width: width, height: height)
    }

    init(frame: CGRect = .zero, viewModel: BottomSlideBannerViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(viewModel)
        self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(_ viewModel: BottomSlideBannerViewModel) {
        todayDoneButton.rx.baseTapGesture()
            .bind(to: viewModel.todayDoneButtonTap)
            .disposed(by: disposeBag)

        closeButton.rx.baseTapGesture()
            .bind(to: viewModel.closeButtonTap)
            .disposed(by: disposeBag)
    }

    private func attribute() {
        backgroundColor = .white

        todayDoneButton.text = "오늘은 그만 보기"
        todayDoneButton.font = R.font.notoSansRegular(size: 14)
        todayDoneButton.textColor = UIColor("#666666")

        closeButton.text = "닫기"
        closeButton.textAlignment = .center
        closeButton.font = R.font.notoSansBold(size: 14)
        closeButton.textColor = UIColor("#666666")
    }

    private func layout() {
        addSubviews(todayDoneButton, closeButton)
        todayDoneButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        closeButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
            $0.width.greaterThanOrEqualTo(44)
        }
    }
}
