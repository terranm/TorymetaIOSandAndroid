//
//  NewBoardSelectCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa

final class NewBoardSelectCollectionViewCell: BaseCollectionViewCell {
    var disposeBag = DisposeBag()

    let imgView = WilldUIImageView.create(
        size: 70,
        assetsName: "",
        type: .plain
    )

    let nameLabel = WDLabel.create(
        font: .regular16,
        text: "",
        color: R.color.togetherBlack()
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configre(_ data: BoardSelectDto) {
        imgView.image = UIImage(named: data.assetName)
        nameLabel.text = data.name
    }

    private func layout() {
        contentView.addSubviews(imgView, nameLabel)

        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2)
            $0.leading.trailing.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(10)
            $0.centerX.equalTo(imgView)
        }
    }
}
