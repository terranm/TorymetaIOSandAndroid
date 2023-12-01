//
//  FriendSearchView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/01.
//

import UIKit
import RxSwift
import RxCocoa

final class FriendSearchView: UIView {
    private var disposeBag = DisposeBag()
    private let searchBackView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor("#9E9E9E").cgColor
    }

    private let searchLabel = WilldUILabel.create(font: .regular16,
                                                  text: "친구 프로필명 또는 휴대폰번호를 입력하세요",
                                                  color: .togetherGray3)
    var parentViewModel: FriendListViewModel? {
        didSet {
            guard let parentViewModel = parentViewModel else { return }
            bind(parentViewModel)
        }
    }

    override var intrinsicContentSize: CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 44
        return CGSize(width: width, height: height)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        self.frame = CGRect(origin: .zero, size: intrinsicContentSize)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(_ viewModel: FriendListViewModel) {
        searchBackView.rx.baseTapGesture()
            .bind(to: viewModel.searchButtonTap)
            .disposed(by: disposeBag)
    }

    private func layout() {
        addSubviews(searchBackView, searchLabel)
        searchBackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        searchLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(searchBackView).inset(20)
        }
    }
}
