//
//  BannerSlideItemCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/13.
//

import UIKit
import RxSwift
import RxCocoa

final class BottomBannerSlideItemCollectionViewCell: UICollectionViewCell {
    private var disposeBag = DisposeBag()
    let thumbnailImageView = UIImageView()

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

    func bind(data: BannerEventAttribute, viewModel: BottomSlideBannerViewModel) {
        setUI(data)
        contentView.rx.baseTapGesture()
            .map { data }
            .bind(to: viewModel.contentsButtonTap)
            .disposed(by: disposeBag)
    }

    private func setUI(_ data: BannerEventAttribute) {
        thumbnailImageView.kf.setImage(with: URL(string: data.bannerImageURL))
    }

    private func attribute() {
        thumbnailImageView.contentMode = .scaleAspectFill
    }

    private func layout() {
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
