//
//  EventIndicatorSupplementView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/31.
//

import UIKit

final class EventIndicatorSupplementView: UICollectionReusableView {

    let pageControl = UIPageControl().then {
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .togetherWhite.withAlphaComponent(0.2)
        $0.currentPageIndicatorTintColor = .togetherWhite
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(pageControl)

        pageControl.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
