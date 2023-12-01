//
//  DecoCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by Chad on 2023/07/30.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxRelay

final class DecoCollectionViewCell: UICollectionViewCell {
    private let disposeBag = DisposeBag()
    var isActivated: Bool = false {
        didSet {
            setActivate()
        }
    }
    var currentItemRelay = PublishRelay<AvatarModeling>()
    private let itemImage = UIImageView()
    private let priceLabel = MileageLabel()
    private let paidItemImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        itemImage.clipsToBounds = true
        itemImage.layer.cornerRadius = 8
        itemImage.layer.borderWidth = 2
        itemImage.layer.borderColor = UIColor.clear.cgColor
        paidItemImageView.image = R.image.avatarCheckBox()
    }

    private func layout() {
        contentView.addSubviews(itemImage, priceLabel, paidItemImageView)

        itemImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(4)
            $0.height.equalTo(contentView.snp.width).inset(4)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(itemImage.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
        }

        paidItemImageView.snp.makeConstraints {
            $0.top.equalTo(itemImage.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(16)
        }
    }

    private func bind() {
        currentItemRelay.bind { [weak self] avatarModeling in
            self?.itemImage.kf.setImage(with: URL(string: avatarModeling.imgURL))
            self?.priceLabel.text = avatarModeling.price.decimalPointed
            self?.priceLabel.isHidden = avatarModeling.isOwned
            self?.paidItemImageView.isHidden = !avatarModeling.isOwned
        }
        .disposed(by: disposeBag)
    }

    private func setActivate() {
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self else { return }
            self.itemImage.layer.borderColor =  self.isActivated ? UIColor("#6C5CE7").cgColor : UIColor.clear.cgColor
        }
    }
}
