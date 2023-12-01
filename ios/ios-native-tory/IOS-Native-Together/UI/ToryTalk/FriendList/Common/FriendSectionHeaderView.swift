//
//  FriendSectionHeaderView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/31.
//

import UIKit
import RxSwift
import RxCocoa

final class FriendSectionHeaderView: UITableViewHeaderFooterView {
    struct InjectData {
        let type: FriendType?
        let viewwModel: FriendListViewModel?
    }
    private var disposeBag = DisposeBag()
    private let titleLabel = WilldUILabel.create(font: .regular14,
                                                 text: "",
                                                 color: .togetherBlack)
    private let decorateImageView = WilldUIImageView.create(size: 44,
                                                            assetsName: R.image.common_right_arrow.name,
                                                            type: .plain)
    private var type: FriendType?
    var injectData: InjectData? {
        didSet {
            configure(type: injectData?.type)
            guard let viewModel = injectData?.viewwModel else {
                decorateImageView.isHidden = true
                return
            }
            bind(viewModel)
        }
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func bind(_ viewModel: FriendListViewModel) {
        decorateImageView.rx.baseTapGesture()
            .map { [weak self] in self?.type }
            .bind(to: viewModel.sectionHeaderButtonTap)
            .disposed(by: disposeBag)
    }
    private func configure(type: FriendType?) {
        self.type = type
        let result = FriendContext.getTypeName(type: type)
        titleLabel.text = result
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    private func layout() {
        contentView.addSubviews(titleLabel, decorateImageView)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(decorateImageView)
            $0.leading.equalToSuperview().inset(16)
        }
        decorateImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(-5)
            $0.trailing.equalToSuperview()
        }
    }
}
