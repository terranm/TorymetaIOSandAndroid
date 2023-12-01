//
//  SeminarSearchView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/18.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class SeminarSearchView: UIView {

    let disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherPurple.cgColor
        $0.layer.cornerRadius = 22
    }

    let textLabel = WilldUILabel.create(font: .regular16,
                                        text: localizable.seminarSearchInsertKeyword(),
                                        color: UIColor("#C7C0FC"))

    let searchImgView = WilldUIImageView.create(size: 44,
                                                assetsName: R.image.seminar_Search.name,
                                                type: .plain)

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 44)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        addSubviews(backView, textLabel, searchImgView)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        textLabel.snp.makeConstraints {
            $0.centerY.equalTo(backView)
            $0.leading.trailing.equalTo(backView).inset(20)
        }

        searchImgView.snp.makeConstraints {
            $0.trailing.equalTo(backView).inset(10)
            $0.centerY.equalTo(backView)
        }
    }
}
