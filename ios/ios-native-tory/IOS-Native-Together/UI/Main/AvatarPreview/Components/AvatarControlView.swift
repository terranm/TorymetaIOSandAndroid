//
//  AvatarControlView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/11.
//

import UIKit
import SnapKit
import RxSwift

final class AvatarControlView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    private let pointImgView = UIImageView()
    private let pointLabel = UILabel()
    private let pointBackView = UIView()
    private let nickNameLabel = UILabel()
    private let changeNameButton = UIImageView()
    private let avatarChangeButton = UIImageView()

    init(frame: CGRect = .zero, _ viewModel: MainViewModel) {
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
        pointImgView.image = R.image.newmain_point()

        pointLabel.font = R.font.notoSansRegular(size: 12)
        pointLabel.text = "-"
        pointLabel.textColor = .togetherBlack
        pointLabel.numberOfLines = 1
        pointLabel.text = WDHelper.numberToNumberSeparator(repository.point.value.point)

        pointBackView.backgroundColor = .togetherWhite
        pointBackView.layer.cornerRadius = 12
        pointBackView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        nickNameLabel.font = R.font.notoSansSemiBold(size: 14)
        nickNameLabel.textColor = .togetherWhite

        changeNameButton.image = R.image.newMain_Name_change()
        avatarChangeButton.image = R.image.newMain_Avatar_change()

    }

    private func layout() {
        let width = 16 + 4 + pointLabel.intrinsicContentSize.width - 24
        pointBackView.frame = CGRect(origin: .zero, size: .init(width: width, height: 24))

        addSubviews(pointBackView, pointImgView, pointLabel, nickNameLabel, changeNameButton, avatarChangeButton)

        pointBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(12)
        }
        pointImgView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(pointBackView).inset(4)
            $0.centerY.equalTo(pointBackView)
        }
        pointLabel.snp.makeConstraints {
            $0.leading.equalTo(pointImgView.snp.trailing).offset(4)
            $0.centerY.equalTo(pointBackView)
            $0.trailing.equalTo(pointBackView).inset(8)
        }

        nickNameLabel.snp.makeConstraints {
            $0.trailing.equalTo(changeNameButton.snp.leading)
            $0.centerY.equalTo(changeNameButton)
        }
        changeNameButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.trailing.equalToSuperview()
        }

        avatarChangeButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.left.bottom.equalToSuperview().inset(18)
        }
    }

    private func bind() {
        repository.member
            .map { $0.profileName }
            .bind(to: nickNameLabel.rx.text)
            .disposed(by: disposeBag)

        avatarChangeButton.rx.baseTapGesture()
            .bind { [weak self] _ in
                self?.viewModel.avatarPreviewEventRelay.accept(.avatarDeco)
            }
            .disposed(by: disposeBag)

        changeNameButton.rx.baseTapGesture()
            .bind { [weak self] in
                self?.viewModel.avatarPreviewEventRelay.accept(.changeName)
            }
            .disposed(by: disposeBag)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        subviews.contains(where: {
            !$0.isHidden && $0.isUserInteractionEnabled && $0.point(inside: self.convert(point, to: $0), with: event)
        })
    }
}
