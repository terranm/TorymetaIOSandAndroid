//
//  NFTCollectionCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/08.
//

import UIKit
import RxSwift
import RxCocoa

final class NftItemCollectionViewCell: UICollectionViewCell {

    struct Inject {
        let ownerNft: OwnerNftResultDto
        let parentViewModel: FriendStateViewModel
    }
    private var disposeBag = DisposeBag()

    private let nftImageView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }

    private let nftBorderView = WilldUIView().then {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.togetherPurple.cgColor
        $0.layer.cornerRadius = 8
    }

    private let nftDescriptionImageView = WilldUIImageView.create(size: 32, assetsName: "", type: .plain)

    var inject: Inject? {
        didSet {
            guard let inject = inject else { return }
            self.configure(data: inject.ownerNft)
            self.bind(parentViewModel: inject.parentViewModel)
        }
    }

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

    private func bind(parentViewModel: FriendStateViewModel) {
        contentView.rx.baseTapGesture()
            .map { [weak self] in
                return self?.inject?.ownerNft
            }
            .bind(to: parentViewModel.nftItemButtonTap)
            .disposed(by: disposeBag)
    }

    private func configure(data: OwnerNftResultDto) {
        nftImageView.kf.setImage(with: URL(string: data.imageURL))
        switch data.nftState {
        case.NONE:
            nftBorderView.isHidden = true
        case.SALE:
            nftDescriptionImageView.image = R.image.campus_sale()
            nftBorderView.isHidden = false
        case.AUCTION:
            nftDescriptionImageView.image = R.image.campus_auction()
            nftBorderView.isHidden = false
        }
    }

    private func layout() {
        contentView.addSubviews(nftImageView, nftBorderView, nftDescriptionImageView)

        nftImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        nftBorderView.snp.makeConstraints {
            $0.edges.equalTo(nftImageView)
        }
        nftDescriptionImageView.snp.makeConstraints {
            $0.bottom.trailing.equalTo(nftImageView).inset(4)
        }
    }
}
