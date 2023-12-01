//
//  ParticipateDescriptionTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import Foundation
import RxSwift
import RxCocoa

final class ParticipateDescriptionTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()
    let imgView = WilldUIImageView.create(size: 24, assetsName: "", type: .plain)
    let titleLabel = WilldUILabel.create(font: .bold14, text: "-", color: .togetherBlack)
    let subTitleLabel = WilldUILabel.create(font: .regular12, text: "-", color: .togetherBlack)
    let descriptionLabel = WilldUILabel.create(font: .regular14, text: "-", color: .togetherBlack)

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

    func configure(_ data: ParticiPateSeminarDto) {
        imgView.image = UIImage(named: data.imgName)
        titleLabel.text = data.title

        subTitleLabel.isHidden = data.subTitle.isEmpty
        if !data.subTitle.isEmpty {
            subTitleLabel.text = "(\(data.subTitle))"
        }

        descriptionLabel.text = data.description
    }

    func layout() {
        contentView.addSubviews(imgView, titleLabel, subTitleLabel, descriptionLabel)

        imgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(11)
            $0.centerY.equalTo(imgView)
        }

        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.centerY.equalTo(titleLabel)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(42)
            $0.bottom.equalToSuperview().inset(28)
        }
    }
}
