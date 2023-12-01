//
//  PointInfoView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa

final class PointInfoView: UIView {

    let disposeBag = DisposeBag()

    var type: Int = -1

    let parentView = WilldUIView().then {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .togetherPurple
    }

    let titleLabel = WDLabel.create(font: .bold16, text: localizable.pointInfoHistory(), color: .togetherWhite)
    let rightArrorImgView = WilldUIImageView.create(size: 24, assetsName: R.image.mypage_right_arrow.name, type: .plain)
    let pointNameLabel = WDLabel.create(font: .regular12, text: "", color: .togetherWhite)
    let whatIsImgView = WilldUIImageView.create(size: 44, assetsName: R.image.mypage_whais_white.name, type: .plain)
    let pointLabel = WDLabel.create(font: .bold16, text: "", color: .togetherWhite)

    /*
     0 -> toryPoint
     1 -> Mileage
     */
    convenience init(type: Int) {
        self.init(frame: .zero)
        self.type = type
        bind()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind() {

        Observable.just(type)
            .map {
                switch $0 {
                case 0: return localizable.pointInfoTotalTory()
                case 1: return localizable.pointInfoTotalMileage()
                default: return ""
                }
            }
            .bind(to: pointNameLabel.rx.text)
            .disposed(by: disposeBag)

        repository.point
            .map { [weak self] in
                guard let self = self else { return 0 }
                switch self.type {
                case 0: return $0.point
                case 1: return $0.mileage
                default: return 0
                }
            }
            .map {
                WDHelper.numberToNumberSeparator($0)
            }
            .bind(to: pointLabel.rx.text)
            .disposed(by: disposeBag)

    }

    private func layout() {
        addSubviews(parentView, titleLabel, rightArrorImgView, pointNameLabel, whatIsImgView, pointLabel)

        parentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(parentView).inset(12)
        }

        rightArrorImgView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(parentView).inset(10)
        }

        pointNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalTo(titleLabel)
        }

        whatIsImgView.snp.makeConstraints {
            $0.trailing.equalTo(parentView)
            $0.centerY.equalTo(pointNameLabel)
        }

        pointLabel.snp.makeConstraints {
            $0.top.equalTo(pointNameLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}
