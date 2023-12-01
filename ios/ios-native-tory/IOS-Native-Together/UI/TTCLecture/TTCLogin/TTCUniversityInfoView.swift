//
//  TTCUniversityInfoView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import UIKit
import SnapKit
import Kingfisher

final class TTCUniversityInfoView: UIView {

    private let viewModel: TTCLoginViewModel
    private let universityLogo = UIImageView()
    private let universityInfoLabel = UILabel()
    private let container = UIView()

    init(frame: CGRect = .zero, _ viewModel: TTCLoginViewModel) {
        self.viewModel = viewModel
        super .init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        clipsToBounds = true
        backgroundColor = UIColor("#F8F8FA")
        guard let universityInfo = viewModel.universityInfo,
        let titleFont = R.font.notoSansSemiBold.callAsFunction(size: 14),
        let majorFont = R.font.notoSansRegular.callAsFunction(size: 10) else { return }
        var universityInfoMutableString = NSMutableAttributedString()
        universityInfoMutableString = universityInfoMutableString
            .attributed(universityInfo.name, font: titleFont, color: UIColor("#000000"))
        if !universityInfo.major.isEmpty {
            universityInfoMutableString = universityInfoMutableString
                .attributed("\n\(universityInfo.major)", font: majorFont, color: UIColor("#000000"))
        }
        universityInfoLabel.attributedText = universityInfoMutableString
        universityInfoLabel.numberOfLines = 2

        universityLogo.kf.setImage(with: viewModel.universityInfo?.imageURL)
    }

    private func layout() {
        addSubview(container)
        container.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        container.addSubviews(universityLogo, universityInfoLabel)

        universityLogo.snp.makeConstraints {
            $0.verticalEdges.left.equalToSuperview()
            $0.size.equalTo(32)
        }

        universityInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(universityLogo.snp.centerY)
            $0.left.equalTo(universityLogo.snp.right).offset(10)
            $0.right.equalToSuperview()
        }
    }
}
