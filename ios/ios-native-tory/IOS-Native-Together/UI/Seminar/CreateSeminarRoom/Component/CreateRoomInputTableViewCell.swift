//
//  CreateRoomInputTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateRoomInputTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView()

    let titleLabel = WilldUILabel.create(font: .bold14, text: "-", color: .togetherBlack)

    let titleDecorateLabel = WilldUILabel.create(font: .regular12,
                                                 text: localizable.seminarRoomSelectRequired(),
                                                 color: .togetherRed)

    private(set) lazy var textFeild = WilldUITextField(.init(placeholder: localizable.createRoomInputInsertTitle()))
//    let textFeild = WilldUITextField.create(fontType: .regular14,
//                                            placeholder: localizable.createRoomInputInsertTitle(),
//                                            textColor: .togetherBlack,
//                                            keyboardType: .default,
//                                            textAlignment: .left,
//                                            clearButtonMode: .whileEditing)

    let underlineView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
        $0.backgroundColor = .togetherGray3
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

    func configure(title: String,
                   plachold: String,
                   text: String,
                   decorationStr: String = localizable.seminarRoomSelectRequired(),
                   decorationColor: UIColor = .togetherRed) {
        titleLabel.text = title
        textFeild.placeholder = plachold
        textFeild.text = text

        titleDecorateLabel.text = decorationStr
        titleDecorateLabel.textColor = decorationColor
    }

    func layout() {
        contentView.addSubviews(backView, titleLabel, titleDecorateLabel, textFeild, underlineView)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        titleDecorateLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
        }

        textFeild.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }

        underlineView.snp.makeConstraints {
            $0.top.equalTo(textFeild.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(textFeild)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
