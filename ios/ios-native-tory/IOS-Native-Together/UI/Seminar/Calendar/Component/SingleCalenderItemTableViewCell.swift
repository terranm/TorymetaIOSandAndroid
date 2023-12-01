//
//  SingleCalenderItemTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import UIKit
import SwiftDate
import RxSwift
import RxCocoa

final class SingleCalenderItemTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let titleLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherBlack).then {
        $0.numberOfLines = 1
    }
    let teacherLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherBlack)
    let dateLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherGray2)
    let rightImgView = WilldUIImageView.create(size: 44,
                                               assetsName: R.image.seminar_Calendar_item_right.name,
                                               type: .plain)
    let indicatorView = WilldUIView().then {
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 3
        $0.widthAnchor.constraint(equalToConstant: 6).isActive = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(_ data: LiveSeminarListResultDto.Item) {
        let currentDate = Date()
        let format = "yyyy-MM-dd"
        /*
         오늘
         */
        if currentDate.dateToString(format: format) == data.startDate?.dateToString(format: format) {
            indicatorView.backgroundColor = .togetherPurple
        /*
         전날
         */
        }
        if (currentDate - 1.days).dateToString(format: format) == data.startDate?.dateToString(format: format) {
            indicatorView.backgroundColor = UIColor("#D9D9D9")
        /*
         다음날
         */
        }
        if (currentDate + 1.days).dateToString(format: format) == data.startDate?.dateToString(format: format) {
            indicatorView.backgroundColor = UIColor("#C7C0FC")
        }
        titleLabel.text = data.title
        teacherLabel.text = data.teacherName

        dateLabel.text = data.dateStr
    }

    func layout() {
        contentView.addSubviews(titleLabel, teacherLabel, dateLabel, rightImgView, indicatorView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(34)
            $0.trailing.equalTo(rightImgView.snp.leading).offset(-16)
        }

        teacherLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(teacherLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(30)
        }

        rightImgView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(6)
        }

        indicatorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.bottom.equalTo(dateLabel)
        }
    }
}
