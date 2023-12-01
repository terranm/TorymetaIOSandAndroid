//
//  AddNewAvatarView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/08.
//

import UIKit
import SnapKit
import RxSwift

final class AddNewAvatarView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let makeAvatarButton = UIButton()

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
        titleLabel.font = R.font.notoSansSemiBold(size: 24)
        titleLabel.text = localizable.welcomeToryMetaMessage()
        titleLabel.textColor = .togetherBlack

        descriptionLabel.font = R.font.notoSansRegular(size: 12)
        descriptionLabel.text = localizable.makeAvatoryMessage()
        descriptionLabel.textColor = .togetherBlack

        makeAvatarButton.layer.borderWidth = 1
        makeAvatarButton.layer.borderColor = UIColor.togetherPurple.cgColor
        makeAvatarButton.layer.cornerRadius = 16
        makeAvatarButton.setImage(R.image.newMain_Avatar_Select_btn(), for: .normal)
        makeAvatarButton.adjustsImageWhenHighlighted = false
    }

    private func layout() {
        addSubviews(titleLabel, descriptionLabel, makeAvatarButton)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        makeAvatarButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(160)
        }
    }

    private func bind() {
        makeAvatarButton.rx
            .controlEvent(.touchUpInside)
            .bind { [weak self] _ in
                self?.viewModel.avatarPreviewEventRelay.accept(.avatarDeco)
            }
            .disposed(by: disposeBag)
    }
}
