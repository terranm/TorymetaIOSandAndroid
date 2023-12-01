//
//  DecoItemsScrollView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/31.
//

import UIKit
import SnapKit
import RxSwift

final class DecoItemsScrollView: UIScrollView {

    typealias DecoCategoryType = AvatarDecoViewModel.DecoCategoryType
    private let disposeBag = DisposeBag()
    private let viewModel: AvatarDecoViewModel
    private let categories = DecoCategoryType.allCases
    private var collectionViews = [DecoCollectionView]()
    private var lastPage = 0

    init(frame: CGRect = .zero, _ viewModel: AvatarDecoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard contentSize == .zero else { return }
        contentSize = CGSize(width: bounds.width * CGFloat(categories.count), height: bounds.height)
        layout()
    }

    private func attribute() {
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        collectionViews = categories.map { categoryType in
            let decoCollectionViewModel = DecoCollectionViewModel(categoryType, viewModel)
            return DecoCollectionView(viewModel: decoCollectionViewModel)
        }
    }

    private func layout() {
        collectionViews.enumerated().forEach { index, collectionView in
            addSubview(collectionView)
            collectionView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.left.equalToSuperview().offset(bounds.width * CGFloat(index))
                $0.size.equalTo(CGSize(width: bounds.width, height: bounds.height))
            }
        }
    }

    private func bind() {
        rx.didEndDecelerating
            .bind { [weak self] _ in
                guard let self else { return }
                let currentPage = Int(round(self.contentOffset.x / self.bounds.width))
                guard self.lastPage != currentPage else { return }
                guard let category = DecoCategoryType.allCases[safe: currentPage] else { return }
                self.viewModel.decoEventRelay.accept(.tab(category: category))
                self.toggleColorPallette(currentPage)
            }
            .disposed(by: disposeBag)

        viewModel.decoEventRelay
            .bind { [weak self] eventType in
                guard let self,
                      case let .tab(category) = eventType,
                      let currentPage = DecoCategoryType.allCases.firstIndex(of: category) else { return }
                self.setContentOffset(CGPoint(x: self.bounds.width * CGFloat(currentPage), y: 0), animated: true)
                self.toggleColorPallette(currentPage)
            }
            .disposed(by: disposeBag)
    }

    private func toggleColorPallette(_ currentPage: Int) {
        guard let avatarColors = collectionViews[safe: currentPage]?.viewModel.avatarColors else { return }
        viewModel.colorsRelay.accept(avatarColors)
        lastPage = currentPage
    }
}
