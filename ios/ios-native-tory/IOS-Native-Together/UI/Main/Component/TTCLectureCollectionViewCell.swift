//
//  TTCLectureCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/21.
//

import UIKit
import RxSwift

final class TTCLectureCollectionViewCell: BaseCollectionViewCell {

    private(set) var disposeBag = DisposeBag()
    private let backgroundImageView = UIImageView(image: R.image.onlineLecture())
    let enterTTCLectureButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

    private func attribute() {
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.backgroundColor = UIColor("#3115A7")
        backgroundImageView.contentMode = .scaleAspectFit
        enterTTCLectureButton.adjustsImageWhenHighlighted = false
    }

    private func layout() {
        contentView.addSubviews(backgroundImageView, enterTTCLectureButton)

        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        enterTTCLectureButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
