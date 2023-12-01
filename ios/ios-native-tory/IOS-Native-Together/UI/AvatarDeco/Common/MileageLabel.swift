//
//  MileageLabel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/08/02.
//

import UIKit
import SnapKit

final class MileageLabel: UILabel {

    private let padding = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 8)
    private(set) var showBorder: Bool

    init(frame: CGRect = .zero, showBorder: Bool = false) {
        self.showBorder = showBorder
        super.init(frame: frame)
        attribute()
        layout()

        // FIXME: td-64 금액표시 임시 제거
        self.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

    private func attribute() {
        backgroundColor = UIColor("#FFFFFF")
        textColor = UIColor("#666666")
        font = UIFont(name: AppConfigure.textRegular, size: 12)
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = showBorder ? 1 : 0
        layer.borderColor = UIColor("#D9D9D9").cgColor
    }

    private func layout() {
        let mileageBadge = UIImageView(image: R.image.mileage_badge())
        addSubview(mileageBadge)
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(30)
            $0.height.equalTo(32)
        }
        mileageBadge.snp.makeConstraints {
            $0.centerY.equalTo(snp.centerY)
            $0.left.equalTo(snp.left).offset(8)
        }
    }
}
