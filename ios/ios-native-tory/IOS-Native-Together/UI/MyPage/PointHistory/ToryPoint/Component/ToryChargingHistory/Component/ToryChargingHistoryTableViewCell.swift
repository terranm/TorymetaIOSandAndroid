//
//  ToryChargingHistoryTableView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import UIKit

final class ToryChargingHistoryTableViewCell: WilldUITableViewCell {

    let dateLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherGray2)

    let toryHistoryLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherPurple)

    let underLineView = WilldUIView.createUnderLineView(height: 1, color: .togetherGray3)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ data: PointChargingHistoryListResultDto.Item) {
        dateLabel.text = data.date
        toryHistoryLabel.text = data.chargeType

        toryHistoryLabel.textColor = .togetherBlue

        toryHistoryLabel.text = "+\(data.chargeType) \(data.quantity)"
    }

    private func layout() {
        contentView.addSubviews(dateLabel, toryHistoryLabel, underLineView)

        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        toryHistoryLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview()
        }

        underLineView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(22)
        }
    }
}
