//
//  CampusRightIndicatorView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/12.
//

import UIKit
import RxSwift
import RxCocoa

final class CampusRightIndicatorView: UIView {

    let disposeBag = DisposeBag()

    let backgroundView = WilldUIView().then {
        $0.backgroundColor = .togetherWhite.withAlphaComponent(0.6)
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor("#C7C0FC").cgColor
        $0.layer.cornerRadius = 22
    }

    let myLocationButton = WilldUIImageView.create(
        size: 44,
        assetsName: R.image.campusInfo_right_my_location.name,
        type: .plain
    )

    let plusButton = WilldUIImageView.create(
        size: 44,
        assetsName: R.image.campusInfo_right_plus.name,
        type: .plain
    )

    let minusButton = WilldUIImageView.create(
        size: 44,
        assetsName: R.image.campusInfo_right_minus.name,
        type: .plain
    )

    let onOffButton = WilldUIImageView.create(
        size: 44,
        assetsName: "",
        type: .plain
    )

    let markerButton = WilldUIImageView.create(
        size: 44,
        assetsName: R.image.campusInfo_right_marker_on.name,
        type: .plain
    )

    let campusButton = WilldUIImageView.create(
        size: 44,
        assetsName: R.image.campusInfo_right_campus.name,
        type: .plain
    )

    let emptyButton = UIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private var itemSelectedDelegate: (Int) -> Void = { _ in }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        myLocationButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.itemSelectedDelegate(0)
            })
            .disposed(by: disposeBag)

        plusButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.itemSelectedDelegate(1)
            })
            .disposed(by: disposeBag)

        minusButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.itemSelectedDelegate(2)
            })
            .disposed(by: disposeBag)

        onOffButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.itemSelectedDelegate(3)
            })
            .disposed(by: disposeBag)

        markerButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.itemSelectedDelegate(4)
            })
            .disposed(by: disposeBag)

        campusButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.itemSelectedDelegate(5)
            })
            .disposed(by: disposeBag)

        repository.member
            .map {
                $0.isLocationExpose
            }
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.changeOnOff(isOn: $0)
            })
            .disposed(by: disposeBag)
    }

    func setItemSelectedDelegate(_ delegate: @escaping (Int) -> Void) {
        self.itemSelectedDelegate = delegate
    }

    func changeMarker(isMarkerHide: Bool) {
        markerButton.image = isMarkerHide ? R.image.campusInfo_right_marker_off() : R.image.campusInfo_right_marker_on()
    }

    func changeOnOff(isOn: Bool) {
        onOffButton.image = isOn ? R.image.campusInfo_right_on() : R.image.campusInfo_right_off()
    }

    func showAndHide(isColapse: Bool) {
        [plusButton, minusButton, onOffButton, markerButton, campusButton, emptyButton].forEach { view in
            if isColapse {
                view.alpha = 0
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    view.alpha = 1
                })
            }
        }
    }

    private func layout() {
        addSubviews(backgroundView, myLocationButton, plusButton, minusButton,
                    onOffButton, markerButton, campusButton, emptyButton)

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        myLocationButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }

        plusButton.snp.makeConstraints {
            $0.top.equalTo(myLocationButton.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        minusButton.snp.makeConstraints {
            $0.top.equalTo(plusButton.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        onOffButton.snp.makeConstraints {
            $0.top.equalTo(minusButton.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        markerButton.snp.makeConstraints {
            $0.top.equalTo(onOffButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }

        campusButton.snp.makeConstraints {
            $0.top.equalTo(markerButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
