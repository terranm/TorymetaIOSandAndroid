//
//  AvatarCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/16.
//

import UIKit
import RxSwift
import RxCocoa

final class AvatarCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    let imgView = WilldUIImageView().then {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray_3.cgColor
        $0.layer.cornerRadius = 8
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

    func configure(_ data: AvatarListResultDto.Item) {
        if data.isSelect {
            imgView.layer.borderWidth = 2
            imgView.layer.borderColor = UIColor.togetherPurple.cgColor
        } else {
            imgView.layer.borderWidth = 1
            imgView.layer.borderColor = UIColor.togetherGray_3.cgColor
        }

        let imgUrl = ImgUrl().getAvaratImg(groupCode: data.groupCode, id: data.id)

        imgView.kf.setImage(with: imgUrl)
    }

    func layout() {
        contentView.addSubview(imgView)

        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
