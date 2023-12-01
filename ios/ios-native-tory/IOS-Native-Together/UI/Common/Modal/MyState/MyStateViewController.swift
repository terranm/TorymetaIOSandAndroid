//
//  MyStateViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/27.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal

final class MyStateViewController: RefactoringBaseViewController<MyStateViewModel>, RefactoringBasePanModalPresentable {
    var presentViewHeight: CGFloat { 186 }
    var shortFormHeight: PanModalHeight { .contentHeight(presentViewHeight) }
    var longFormHeight: PanModalHeight { .contentHeight(presentViewHeight) }
    private let profileImageView = UIImageView()
    private let nickNameLabel = UILabel()
    private let universityLabel = UILabel()
    private let myIndicatorImageView = UIImageView()
    private let locationPermissionImageView = UIImageView()
    private let underLine = UIView()

    override func attribute() {
        super.attribute()
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 52

        nickNameLabel.font = R.font.notoSansRegular(size: 20)
        nickNameLabel.textColor = .togetherBlack

        universityLabel.font = R.font.notoSansRegular(size: 14)
        universityLabel.textColor = .togetherBlack

        myIndicatorImageView.image = R.image.campus_myIndicator()
        myIndicatorImageView.contentMode = .scaleAspectFill

        underLine.backgroundColor = .togetherGray3
    }

    override func layout() {
        super.layout()
        view.addSubviews(profileImageView, nickNameLabel, universityLabel, myIndicatorImageView,
                         locationPermissionImageView, underLine)

        profileImageView.snp.makeConstraints {
            $0.size.equalTo(104)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.leading.equalToSuperview().inset(16)
        }

        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }

        universityLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nickNameLabel)
        }

        myIndicatorImageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.trailing.bottom.equalTo(profileImageView)
        }

        locationPermissionImageView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(16)
        }

        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(profileImageView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    override func bind(_ viewModel: MyStateViewModel) {
        super.bind(viewModel)

        locationPermissionImageView.rx.baseTapGesture()
            .bind(to: viewModel.locationButtonTap)
            .disposed(by: disposeBag)

        viewModel.profileImage()
            .drive(profileImageView.rx.imageURL)
            .disposed(by: disposeBag)

        viewModel.nickName()
            .drive(nickNameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.universityName()
            .drive(universityLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.locationImage()
            .map { UIImage(named: $0) }
            .drive(locationPermissionImageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.locationButtonTapWithToast()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                CommonToast.Builder()
                    .setMessage($0)
                    .build()
                    .show(self.presentViewHeight)
            })
            .disposed(by: disposeBag)
    }
}
