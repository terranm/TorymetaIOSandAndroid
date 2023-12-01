//
//  OnboardingContentView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/06/29.
//

import UIKit
import SnapKit

final class OnboardingContentView: UIView {
    private let bordTitleLabel = WilldUILabel.create(font: .bold24, color: .clear, numberOfLines: 0)
    private let titleLabel = WilldUILabel.create(font: .bold24, color: .togetherBlack, numberOfLines: 0).then {
        $0.textAlignment = .center
    }
    private let descriptionLabel = WilldUILabel.create(font: .regular16, color: .togetherGray2).then {
        $0.textAlignment = .center
    }
    private let imageView = UIImageView()
    private let onboardingDto: OnboardingDto

    init(frame: CGRect = .zero, onboardingDto: OnboardingDto) {
        self.onboardingDto = onboardingDto
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        bordTitleLabel.text = onboardingDto.bordTitle
        bordTitleLabel.textColor = UIColor(onboardingDto.bordTitleColor)
        titleLabel.text = onboardingDto.title
        descriptionLabel.isHidden = onboardingDto.description.isEmpty
        descriptionLabel.text = onboardingDto.description
        imageView.image = UIImage(named: onboardingDto.imageName)
        imageView.contentMode = onboardingDto.contentMode

        addSubviews(bordTitleLabel, titleLabel, descriptionLabel, imageView)
        bordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).inset(14)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bordTitleLabel.snp.bottom)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(self)
            $0.bottom.equalTo(snp.bottom).offset(-40)
            $0.height.greaterThanOrEqualTo(0).priority(.low)
        }
    }
}
