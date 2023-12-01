//
//  DecoContainerView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/27.
//

import UIKit
import SnapKit
import RxSwift

final class DecoContainerView: UIView {

    private let viewModel: AvatarDecoViewModel
    private lazy var decoCategoryTabView = DecoCategoryTabView(viewModel)
    private lazy var decoSortingView = DecoSortingView(viewModel)
    private lazy var decoItemsScrollView = DecoItemsScrollView(viewModel)

    init(frame: CGRect = .zero, _ viewModel: AvatarDecoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        let borderView = UIView()
        borderView.backgroundColor = UIColor("#E6E6E6")

        addSubviews(borderView, decoCategoryTabView, decoSortingView, decoItemsScrollView)
        borderView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(decoCategoryTabView)
            $0.height.equalTo(1)
        }

        decoCategoryTabView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }

        decoSortingView.snp.makeConstraints {
            $0.top.equalTo(decoCategoryTabView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }

        decoItemsScrollView.snp.makeConstraints {
            $0.top.equalTo(decoSortingView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
