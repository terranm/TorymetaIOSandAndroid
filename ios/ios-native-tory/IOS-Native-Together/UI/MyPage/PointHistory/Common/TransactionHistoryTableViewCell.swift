//
//  ToryTransactionHistoryTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/08.
//

import UIKit
import SnapKit

final class TransactionHistoryTableViewCell: WilldUITableViewCell {

    let dateLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherGray2)
    let timeLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherGray2)
    let titleLabel = WilldUILabel.create(font: .regular20, text: "", color: .togetherBlack)
    let idLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherGray2)
    let pointLabel = WilldUILabel.create(font: .regular20, text: "", color: .clear)
    let expireLabel = WilldUILabel.create(font: .regular14, text: "", color: .togetherGray2)
    let underLineView = WilldUIView.createUnderLineView(height: 1, color: .togetherGray3)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ data: PointTransactionListResultDto.Item) {
        dateLabel.text = data.useDate
        timeLabel.text = data.useHourAndMin

        titleLabel.text = data.history
        idLabel.text = "(\(data.txId))"

        switch data.transactionType {
        case.deposit:
            pointLabel.textColor = .togetherBlue
            pointLabel.text = localizable.transactionHistoryInduct(data.quantity)
        case.withdraw:
            pointLabel.textColor = .togetherRed
            pointLabel.text = localizable.transactionHistoryDeduct(data.quantity)
        }

        if data.expireDate != "" {
            expireLabel.text = localizable.transactionHistoryExpDate(data.expireDate)
        }
    }

    private func layout() {
        contentView.addSubviews(dateLabel, timeLabel, titleLabel, idLabel, pointLabel, expireLabel, underLineView)

        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(14)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        idLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }

        pointLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(36)
            $0.trailing.equalToSuperview()
        }

        expireLabel.snp.makeConstraints {
            $0.top.equalTo(pointLabel.snp.bottom).offset(4)
            $0.trailing.equalToSuperview()
        }

        underLineView.snp.makeConstraints {
            $0.top.equalTo(expireLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
