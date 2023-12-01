//
//  CreateRoomOtherSettingTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/06.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateRoomOtherSettingTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView()

    let onOffLabel = WilldUILabel.create(font: .regular14,
                                         text: localizable.createRoomOtherOnOff(),
                                         color: .togetherBlack)

    let onOffDecorateLabel = WilldUILabel.create(font: .regular12,
                                                 text: localizable.createRoomURLOptional(),
                                                 color: UIColor("#0066FF"))

    let onOffSwitch = UISwitch().then {
        $0.setOn(false, animated: false)
        $0.onTintColor = .togetherPurple
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

    func configure(_ isOn: Bool, animation: Bool = false) {
        onOffSwitch.setOn(isOn, animated: animation)
    }

    func layout() {
        contentView.addSubviews(backView, onOffLabel, onOffDecorateLabel, onOffSwitch)

        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        onOffLabel.snp.makeConstraints {
            $0.centerY.equalTo(onOffSwitch)
            $0.leading.equalToSuperview()
        }

        onOffDecorateLabel.snp.makeConstraints {
            $0.centerY.equalTo(onOffLabel)
            $0.leading.equalTo(onOffLabel.snp.trailing)
        }

        onOffSwitch.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
}
