//
//  WDCustomMarker.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/17.
//

import UIKit
import NMapsMap
import Kingfisher

final class WDCustomMarkerView: UIView {

    lazy var profileImgView = WilldUIImageView(frame: .init(x: 0, y: 0, width: 44, height: 44)).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 11
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.togetherPurple.cgColor
    }

    lazy var decorateView = WilldUIView(frame: .init(x: 44 / 2 -  10 / 2, y: 44 + 7, width: 10, height: 10)).then {
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 5
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     0 -> MY
     1 -> Friend
     */
    func setProfileImageColor(_ color: UIColor) {
        profileImgView.layer.borderColor = color.cgColor
        decorateView.backgroundColor = color
    }

    func layout() {
        addSubviews(profileImgView, decorateView)
    }
}
