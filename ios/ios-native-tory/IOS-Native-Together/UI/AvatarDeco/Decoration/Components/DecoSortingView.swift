//
//  DecoSortingView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/27.
//

import UIKit
import RxSwift
import RxCocoa

final class DecoSortingView: UIView {

    private let disposeBag = DisposeBag()
    private let viewModel: AvatarDecoViewModel
    private let filterButton = UIButton()
    private let sortingButton = UIButton()

    init(frame: CGRect = .zero, _ viewModel: AvatarDecoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        // MARK: 현버전에서는 필터기능 제외 (최건혁.Aug.2.23)
        filterButton.isHidden = true
        filterButton.adjustsImageWhenHighlighted = false
        filterButton.setImage(R.image.mileage_filter(), for: .normal)
        sortingButton.adjustsImageWhenHighlighted = false
        sortingButton.setImage(R.image.sort_button(), for: .normal)
    }

    private func layout() {
        addSubviews(filterButton, sortingButton)
        filterButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.right.equalTo(sortingButton.snp.left).offset(-4)
            $0.size.equalTo(32)
        }

        sortingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }
    }

    private func bind() {
//        filterButton.rx
//            .controlEvent(.touchUpInside)
//            .bind { [weak self] _ in
//                self?.viewModel.listOptionRelay.accept(.didSelectMileageFilter)
//            }
//            .disposed(by: disposeBag)

        sortingButton.rx
            .controlEvent(.touchUpInside)
            .bind { [weak self] _ in
                self?.viewModel.listOptionRelay.accept(.showSortingList)
            }
            .disposed(by: disposeBag)
    }
}
