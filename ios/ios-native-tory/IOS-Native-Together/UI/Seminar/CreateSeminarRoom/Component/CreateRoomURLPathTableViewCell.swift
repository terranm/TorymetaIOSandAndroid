//
//  CreateRoomOtherSettingTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa
import EasyTipView

final class CreateRoomURLPathTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView()

    let titleLabel = WilldUILabel.create(font: .bold14,
                                         text: localizable.createRoomURLMovieURL(),
                                         color: .togetherBlack)

    let titleDecorateLabel = WilldUILabel.create(font: .regular12,
                                                 text: localizable.createRoomURLOptional(),
                                                 color: UIColor("#0066FF"))
    private(set) lazy var urlTextFeild = WilldUITextField(.init(placeholder: localizable.createRoomURLInsertURL()))
//    let urlTextFeild = WilldUITextField.create(fontType: .regular14,
//                                               placeholder: localizable.createRoomURLInsertURL(),
//                                               textColor: .togetherBlack,
//                                               keyboardType: .default,
//                                               textAlignment: .left,
//                                               clearButtonMode: .whileEditing)

    private var timer: Timer?
    private var timeRemaining = 0.0
    private let tipAncherView = WilldUIView()

    lazy var urlBackView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray3.cgColor

        $0.addSubview(urlTextFeild)
        urlTextFeild.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        showMp4WarningTipView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(_ urlPath: String?) {
        urlTextFeild.text = urlPath
    }

    func layout() {
        contentView.addSubviews(backView, titleLabel, titleDecorateLabel, urlBackView, tipAncherView)
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

        urlBackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(28)
        }

        tipAncherView.snp.makeConstraints {
            $0.top.equalTo(urlBackView)
            $0.bottom.equalTo(urlBackView).inset(12)
            $0.leading.equalTo(urlBackView).inset(16)
        }
    }

    func showMp4WarningTipView() {
        var preference = EasyTipView.Preferences()
        let fontDto = FontValue.getFont(with: .regular12)
        guard let font = UIFont(name: fontDto.fontName, size: fontDto.fontSize) else { return }
        preference.drawing.font = font
        preference.positioning.maxWidth = 256
        preference.drawing.backgroundColor = UIColor("#666666")
        preference.drawing.cornerRadius = 4

        preference.drawing.arrowPosition = .top
        preference.drawing.arrowHeight = 8
        preference.drawing.arrowWidth = 12

        timer = Timer.scheduledTimer(withTimeInterval: timeRemaining, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            self.timeRemaining -= self.timeRemaining

            if self.timeRemaining == 0 {
                let tipView = EasyTipView(text: localizable.createRoomURLInsertURLDesc(), preferences: preference)
                tipView.show(forView: tipAncherView, withinSuperview: contentView)

                timer?.invalidate()
                timer = nil
            }
        }
    }
}
