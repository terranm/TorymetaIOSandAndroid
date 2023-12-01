//
//  CreateRoomFixTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/12.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateRoomFixTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView()

    let titleLabel = WilldUILabel.create(font: .bold14,
                                         text: localizable.createRoomFixTeacherName(),
                                         color: .togetherBlack)

    let fixLabel = WilldUILabel.create(font: .regular14,
                                       text: "",
                                       color: .togetherGray1)

    lazy var fixBackView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.backgroundColor = UIColor("#F8F8FA")
        $0.layer.cornerRadius = 8
        $0.addSubview(fixLabel)
        fixLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
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

    func layout() {
        contentView.addSubviews(backView, titleLabel, fixBackView)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        fixBackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
