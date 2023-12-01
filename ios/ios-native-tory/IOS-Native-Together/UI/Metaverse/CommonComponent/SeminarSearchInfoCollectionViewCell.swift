//
//  SeminarSearchInfoCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/22.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit

struct SeminarSearchInfoDto {

    let title: String
    let teacher: String

    let tag: String
    let tagColor: String

    let description: String

    let schedule: String

    let count: Int
}

final class SeminarScheduleInfoCollectionViewCell: BaseCollectionViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.backgroundColor     = .togetherWhite
        $0.layer.shadowColor   = UIColor.togetherBlack.cgColor
        $0.layer.masksToBounds = false
        $0.layer.shadowOffset  = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius  = 12
        $0.layer.shadowOpacity = 0.1
        $0.layer.cornerRadius  = 12
    }

    let titleLabel = WilldUILabel.create(font: .regular14, text: "", color: .togetherBlack)
    let teacherLabel = WilldUILabel.create(font: .regular14, text: "", color: .togetherGray1)
    let descriptionLabel = WilldUILabel.create(font: .regular14, text: "", color: .togetherGray1)
    let tagLabel = WilldUILabel.create(font: .regular12, text: "", color: .togetherGray2)
    let scheduleLabel = WilldUILabel.create(font: .regular12, text: "", color: .togetherGray2)
    let countImgView = WilldUIImageView.create(size: 24, assetsName: R.image.seminar_number.name, type: .plain).then {
        $0.image = $0.image?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .togetherGray2
    }

    let countLabel = WilldUILabel.create(font: .regular12, text: "", color: .togetherGray2)

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

    func configure(_ data: SeminarSearchInfoDto) {
        titleLabel.text = data.title
        teacherLabel.text = "[\(data.teacher)]"

        tagLabel.text = data.tag
        tagLabel.textColor = UIColor(data.tagColor)

        descriptionLabel.text = data.description

        scheduleLabel.text = data.schedule
        countLabel.text = "\(data.count)"
    }

    func layout() {
        contentView.addSubviews(backView, titleLabel, teacherLabel, descriptionLabel, tagLabel,
                                scheduleLabel, countImgView, countLabel)

        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backView).inset(16)
            $0.leading.equalTo(backView).inset(16)
        }

        teacherLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
        }

        tagLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(backView).inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }

        scheduleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.equalTo(titleLabel)
        }

        countLabel.snp.makeConstraints {
            $0.trailing.equalTo(tagLabel)
            $0.centerY.equalTo(scheduleLabel)
        }

        countImgView.snp.makeConstraints {
            $0.centerY.equalTo(countLabel)
            $0.trailing.equalTo(countLabel.snp.leading).offset(-4)
        }
    }
}
