//
//  SeminarSearchSelectCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

struct SeminarSelectDto {
    var isSelect: Bool
    let title: String
}

final class SeminarScheduleSelectCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    let selectImgView = WilldUIImageView.create(size: 44, assetsName: "", type: .plain)
    let titleLabel = WilldUILabel.create(font: .regular14, text: "", color: .togetherBlack)

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

    func configure(_ data: SeminarSelectDto) {
        selectImgView.image =  data.isSelect ? R.image.seminar_search_select_on(): R.image.seminar_search_select_off()
        titleLabel.text = data.title
    }

    func layout() {
        contentView.addSubviews(selectImgView, titleLabel)

        selectImgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(selectImgView)
            $0.leading.equalTo(selectImgView.snp.trailing)
        }
    }
}
