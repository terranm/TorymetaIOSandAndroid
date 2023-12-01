//
//  InfoCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/09.
//

import UIKit
import RxSwift

final class InfoCollectionViewCell: BaseCollectionViewCell {

    private var disposeBag = DisposeBag()

    private let backView = WilldUIView().then {
        $0.backgroundColor     = .togetherWhite
        $0.layer.shadowColor   = UIColor.black.cgColor
        $0.layer.masksToBounds = false
        $0.layer.shadowOffset  = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius  = 12
        $0.layer.shadowOpacity = 0.1
        $0.layer.cornerRadius  = 12
    }

    private let titleLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherBlack)
    private let dateLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherGray2)

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

    func configure(_ data: GeneralNoticeListResultDto.Item) {
        titleLabel.text = data.bbsTitle

        let split = data.regDate.split(separator: " ")
        if !split.isEmpty {
            let year = split[0]
            dateLabel.text = String(year)
        }
    }

    private func layout() {
        contentView.addSubviews(backView, titleLabel, dateLabel)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(backView).inset(16)
            $0.centerY.equalTo(backView)
        }

        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(backView).inset(16)
            $0.centerY.equalTo(titleLabel)
        }
    }
}
