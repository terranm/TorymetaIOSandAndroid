//
//  SeminarDescriptionTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/08.
//

import UIKit

final class SeminarDescriptionTableViewCell: BaseCollectionViewCell {

    let imgView = WilldUIImageView().then {
        $0.image = R.image.seminar_main_description()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        contentView.addSubview(imgView)

        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
