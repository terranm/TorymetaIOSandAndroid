//
//  CreateRoomScheduleTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftDate

final class CreateRoomScheduleTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView()

    let titleLabel = WilldUILabel.create(font: .bold14,
                                         text: localizable.createRoomScheduleOtherSettings(),
                                         color: .togetherBlack)

    let titleDecorationLabel = WilldUILabel.create(font: .regular12,
                                                   text: localizable.seminarRoomSelectRequired(),
                                                   color: .togetherRed)

    let topUnderlineView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        $0.backgroundColor = .togetherGray3
    }

    let startDateInfoLabel = WilldUILabel.create(font: .regular16,
                                                 text: localizable.createRoomScheduleStartSeminar(),
                                                 color: .togetherBlack)

    let startDateLabel = WilldUILabel.create(font: .regular16,
                                             text: "-",
                                             color: .togetherBlack)

    lazy var startDateButton = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 106).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
        $0.layer.borderWidth = 1

        $0.addSubview(startDateLabel)
        startDateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    let startTimeLabel = WilldUILabel.create(font: .regular16,
                                             text: "-",
                                             color: .togetherBlack)

    lazy var startTimeButton = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 94).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
        $0.layer.borderWidth = 1

        $0.addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    let midUnderLineView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        $0.backgroundColor = .togetherGray3
    }

    let endDateInfoLabel = WilldUILabel.create(font: .regular16,
                                               text: localizable.createRoomScheduleEndSeminar(),
                                               color: .togetherBlack)

    let endDateLabel = WilldUILabel.create(font: .regular16,
                                           text: "-",
                                           color: .togetherGray3)

    let endTimeLabel = WilldUILabel.create(font: .regular16,
                                           text: "-",
                                           color: .togetherBlack)

    lazy var endTimeButton = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 94).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 32).isActive = true

        $0.layer.cornerRadius = 4
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
        $0.layer.borderWidth = 1

        $0.addSubview(endTimeLabel)
        endTimeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    let bottomUnderlineView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        $0.backgroundColor = .togetherGray3

    }

    let warningInfoLebel = WilldUILabel.create(font: .regular12,
                                               text: localizable.createRoomSchedule1daySetting(),
                                               color: .togetherGray2)

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

    func configure(startDate: Date?, endDate: Date?) {
        self.configure(startDate: startDate)
        self.configure(endDate: endDate)
    }

    func configure(startDate: Date?) {
        let split = startDate?.dateToString(format: "yyyy.MM.dd-a hh:mm").split(separator: "-") ?? []
        if !split.isEmpty {
            startDateLabel.text = String(split[0])
            startTimeLabel.text = String(split[1])
            endDateLabel.text = String(split[0])
        }
    }

    func configure(endDate: Date?) {
        let split = endDate?.dateToString(format: "yyyy.MM.dd-a hh:mm").split(separator: "-") ?? []

        if !split.isEmpty {
            endDateLabel.text = String(split[0])
            endTimeLabel.text = String(split[1])
        }
    }

    func layout() {
        contentView.addSubviews(backView, titleLabel, titleDecorationLabel,
                                topUnderlineView, startDateInfoLabel, startDateButton, startTimeButton,
                                midUnderLineView, endDateInfoLabel, endDateLabel, endTimeButton,
                                bottomUnderlineView, warningInfoLebel)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        titleDecorationLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.centerY.equalTo(titleLabel)
        }

        topUnderlineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }

        startDateInfoLabel.snp.makeConstraints {
            $0.top.equalTo(topUnderlineView.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }

        startDateButton.snp.makeConstraints {
            $0.trailing.equalTo(startTimeButton.snp.leading).offset(-10)
            $0.centerY.equalTo(startTimeButton)
        }

        startTimeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(startDateInfoLabel)
        }

        midUnderLineView.snp.makeConstraints {
            $0.top.equalTo(startDateInfoLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }

        endDateInfoLabel.snp.makeConstraints {
            $0.top.equalTo(midUnderLineView.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
        }

        endDateLabel.snp.makeConstraints {
            $0.centerX.equalTo(startDateButton)
            $0.centerY.equalTo(endTimeButton)
        }

        endTimeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(endDateInfoLabel)
        }

        bottomUnderlineView.snp.makeConstraints {
            $0.top.equalTo(endDateInfoLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
        }

        warningInfoLebel.snp.makeConstraints {
            $0.top.equalTo(bottomUnderlineView.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(34)
        }
    }
}
