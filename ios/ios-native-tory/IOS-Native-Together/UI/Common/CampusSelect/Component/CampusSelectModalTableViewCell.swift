//
//  MyCampusSelectBottomTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import UIKit
import RxSwift
import RxCocoa

final class CampusSelectModalTableViewCell: WilldUITableViewCell {

    var disposeBag = DisposeBag()

    private let campusNameLabel = WilldUILabel.create(font: .regular16, text: "", color: .togetherBlack)
    private let underLineView = WilldUIView.createUnderLineView(height: 1, color: .togetherGray3)

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

    func configure(data: UniversityListResultDto.Item) {
        campusNameLabel.text = data.universityName
    }

    private func layout() {
        contentView.addSubviews(campusNameLabel, underLineView)

        campusNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        underLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(campusNameLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(1)
        }
    }
}
