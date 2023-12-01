//
//  SearchTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/09.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class SeminarSearchTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let backView = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherPurple.cgColor
        $0.layer.cornerRadius = 22
    }

    private(set) lazy var textField = WilldUITextField(.init(fontType: .regular16,
                                                             placeholder: localizable.seminarSearchInsertKeyword(),
                                                             placeholderColor: UIColor("#C7C0FC"),
                                                             returnKeyType: .search))
//    let textField = WilldUITextField.create(fontType: .regular16,
//                                            placeholder: localizable.seminarSearchInsertKeyword(),
//                                            textColor: .togetherBlack,
//                                            keyboardType: .default,
//                                            textAlignment: .left,
//                                            clearButtonMode: .whileEditing,
//                                            placeholderColor: UIColor("#C7C0FC")).then {
//        $0.returnKeyType = UIReturnKeyType.search
//    }

    let searchImgView = WilldUIImageView.create(size: 44,
                                                assetsName: R.image.seminar_Search.name,
                                                type: .plain)

    override var intrinsicContentSize: CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 44
        return CGSize(width: width, height: height + 30)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        bind()
        self.frame = CGRect(origin: .zero, size: intrinsicContentSize)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func bind() {
        textField.rx.text
            .map { $0?.count ?? 0 > 0 }
            .bind(to: searchImgView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func layout() {
        contentView.addSubviews(backView, textField, searchImgView)
        backView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }

        textField.snp.makeConstraints {
            $0.centerY.equalTo(backView)
            $0.leading.trailing.equalTo(backView).inset(20)
        }

        searchImgView.snp.makeConstraints {
            $0.trailing.equalTo(backView).inset(10)
            $0.centerY.equalTo(backView)
        }
    }
}
