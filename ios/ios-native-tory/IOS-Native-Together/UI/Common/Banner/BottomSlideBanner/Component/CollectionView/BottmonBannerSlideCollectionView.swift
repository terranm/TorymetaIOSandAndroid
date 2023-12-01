//
//  BannerSlideCollectionView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/13.
//

import UIKit
import RxSwift
import RxCocoa

final class BottmonBannerSlideView: UIView {
    private let disposeBag = DisposeBag()
    private let viewModel: BottomSlideBannerViewModel
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let pageControll = UIPageControl()

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 284

        return CGSize(width: width, height: height)
    }

    init(frame: CGRect = .zero, viewModel: BottomSlideBannerViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        mLayout()
        bind(viewModel)
        self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(_ viewModel: BottomSlideBannerViewModel) {
        viewModel.getList()
            .drive(collectionView.rx.items) { collectioView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectioView.dequeueReusableCell(
                    withReuseIdentifier: String(describing: BottomBannerSlideItemCollectionViewCell.self),
                    for: indexPath) as? BottomBannerSlideItemCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.bind(data: data, viewModel: viewModel)
                return cell
            }
            .disposed(by: disposeBag)

        viewModel.getListCount()
            .drive(pageControll.rx.numberOfPages)
            .disposed(by: disposeBag)

        viewModel.getListCount()
            .map { $0 <= 1 }
            .drive(pageControll.rx.isHidden)
            .disposed(by: disposeBag)

        collectionView.rx.didScroll
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if self.frame.size.width != 0 {
                    let value = (self.collectionView.contentOffset.x / self.collectionView.frame.width)
                    self.pageControll.currentPage = Int(round(value))
                }
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let width = UIScreen.main.bounds.width
        let height: CGFloat = width * 0.76 // 이미지 비율
        layout.itemSize = .init(width: width, height: height)

        collectionView.layer.cornerRadius = 16
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(BottomBannerSlideItemCollectionViewCell.self,
                 forCellWithReuseIdentifier: String(describing: BottomBannerSlideItemCollectionViewCell.self))

        pageControll.pageIndicatorTintColor = .black.withAlphaComponent(0.3)
        pageControll.currentPageIndicatorTintColor = .black.withAlphaComponent(0.5)
    }

    private func mLayout() {
        addSubviews(collectionView, pageControll)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pageControll.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(snp.bottom).inset(15)
        }
    }
}
