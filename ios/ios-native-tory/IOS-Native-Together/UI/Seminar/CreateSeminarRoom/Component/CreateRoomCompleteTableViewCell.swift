//
//  CreateRoomCompleteTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import UIKit
import RxSwift
import RxCocoa

// class CreateRoomCompleteTableViewCell: BaseTableViewCell {
//    var disposeBag = DisposeBag()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        layout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        disposeBag = DisposeBag()
//    }
//
//
//    func configure(isPosibleComplete: Bool) {
//        completeButton.backgroundColor = isPosibleComplete ? UIColor.togetherPurple: UIColor.togetherGray3
//    }
//    
//    func layout() {
//        [
//            completeButton
//        ].forEach {
//            contentView.addSubview($0)
//        }
//
//        completeButton.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().inset(88)
//        }
//    }
// }
