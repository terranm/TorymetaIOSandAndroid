//
//  ImagePickerCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/03.
//

import UIKit
import RxSwift
import RxCocoa

final class ImagePickerCollectionViewCell: UICollectionViewCell {

    var disposeBag = DisposeBag()

    let pickerImageView = WilldUIImageView().then {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray3.cgColor
    }
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
    func configure(url: URL?) {
        pickerImageView.kf.setImage(with: url)
    }

    private func layout() {
        contentView.addSubview(pickerImageView)

        pickerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
