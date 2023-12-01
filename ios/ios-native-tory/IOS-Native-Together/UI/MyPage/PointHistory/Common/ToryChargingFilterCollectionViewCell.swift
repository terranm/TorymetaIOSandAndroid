//
//  ToryChargingFilterCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ToryChargingFilterCollectionViewCell: UICollectionViewCell {

    var diseposeBag = DisposeBag()

    let backView = WilldUIView.createBorderView(borderColor: .clear, heightType: .small, cornerRoundType: .medium)

    let filterLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherBlack)

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        diseposeBag = DisposeBag()
    }

    func configure(data: PointFilterDto) {
        if data.isSelect {
            backView.configureBackgroundColor(color: .togetherPurple)
            backView.configureBorder(width: 0, color: .clear)
            filterLabel.textColor = .togetherWhite
        } else {
            backView.configureBackgroundColor(color: .togetherWhite)
            backView.configureBorder(width: 1, color: .togetherPurple)
            filterLabel.textColor = .togetherBlack
        }
        filterLabel.text = data.filterName
    }

    private func layout() {
        contentView.addSubviews(backView, filterLabel)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        filterLabel.snp.makeConstraints {
            $0.center.equalTo(backView)
        }
    }
}
