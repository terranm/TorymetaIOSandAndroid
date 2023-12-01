//
//  ToryLoungeButtonView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/05.
//

import UIKit

final class ToryLoungeButtonView: UIView {
    private let loungeImgView = WilldUIImageView.create(size: 44,
                                                        assetsName: R.image.newMain_Meta.name,
                                                        type: .plain)

    private let loungeLabel = WilldUILabel.create(font: .bold24,
                                                  text: "TORY  LOUNGE",
                                                  color: .togetherWhite)

    private lazy var loungeStackView = UIStackView(arrangedSubviews: [loungeImgView, loungeLabel]).then {
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.spacing = 12
    }

    /*
     실질적인 버튼 탭
     */
    lazy var loungeButton = WilldUIImageView().then {
        $0.image = R.image.newMain_Meta_background()
        $0.heightAnchor.constraint(equalToConstant: 56).isActive = true
        $0.layer.cornerRadius = 16

        $0.addSubview(loungeStackView)
        loungeStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private let loungeBlurView = WilldUIView()

    override var intrinsicContentSize: CGSize {
        let buttonSize: CGFloat = 56
        let width: CGFloat = UIScreen.main.bounds.width - 32

        let bottomSafeGuide = window?.safeAreaInsets.bottom ?? 0.0
        let height: CGFloat = buttonSize + bottomSafeGuide + 16
        return CGSize(width: width, height: height)
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let gradient = loungeBlurView.layer.sublayers?.first {
            gradient.frame = loungeBlurView.bounds
        } else {
            let gradient = CAGradientLayer()
            gradient.frame = loungeBlurView.bounds
            gradient.colors = [UIColor("#FFFFFF").withAlphaComponent(0).cgColor, UIColor("#FFFFFF").cgColor]
            gradient.locations = [0, 1]
            loungeBlurView.layer.addSublayer(gradient)
        }
    }

    private func layout() {
        addSubviews(loungeBlurView, loungeButton)

        loungeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        loungeBlurView.snp.makeConstraints {
            $0.top.equalTo(loungeButton)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
