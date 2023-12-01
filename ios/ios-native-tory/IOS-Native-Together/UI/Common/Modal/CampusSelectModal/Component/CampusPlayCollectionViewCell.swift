//
//  CampusSelectPlayCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import UIKit
import RxSwift
import RxCocoa

final class CampusPlayCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
        $0.layer.cornerRadius = 10
    }

    let campusIconImageView = WilldUIImageView.create(
        size: 32,
        assetsName: "",
        type: .plain
    )

    let campusName = WilldUILabel.create(font: .regular12, text: "", color: .togetherBlack).then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

//    lazy var stackView = UIStackView(arrangedSubviews: [campusIconImageView, campusName]).then {
//        $0.axis = .vertical
//        $0.spacing = 9
//    }

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

    func configure(data: UniversityListResultDto.Item) {
        campusIconImageView.kf.setImage(with: URL(string: data.imgUrl))
        campusName.text = data.universityName

        if data.isSelect {
            backView.layer.borderColor = UIColor.togetherPurple.cgColor
        } else {
            backView.layer.borderColor = UIColor.togetherGray3.cgColor
        }
    }

    private func layout() {
        contentView.addSubviews(backView, campusIconImageView, campusName)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        campusIconImageView.snp.makeConstraints {
            if UIDevice.current.userInterfaceIdiom == .pad {
                $0.centerY.equalTo(backView)
                $0.centerX.equalTo(backView)
            } else {
                $0.top.equalTo(backView).inset(10)
                $0.centerX.equalTo(backView)
            }
        }

        campusName.snp.makeConstraints {
            $0.top.equalTo(campusIconImageView.snp.bottom).offset(11)
            $0.leading.trailing.equalTo(backView).inset(8)
        }
    }
}
