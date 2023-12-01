//
//  SeminarMainFilterCollectionViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa

final class SeminarMainFilterView: UIView {

    let disposeBag = DisposeBag()

    private let allButtonLabel = WilldUILabel.create(font: .regular14,
                                                     text: localizable.seminarMainFilterAll(),
                                                     color: .togetherGray3)
    private lazy var allButton = WilldUIView().then {
        $0.addSubviews(allButtonLabel)
        allButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        $0.snp.makeConstraints {
            $0.leading.trailing.equalTo(allButtonLabel).inset(-18)
            $0.top.bottom.equalTo(allButtonLabel).inset(-7)
        }
        $0.layer.cornerRadius = 17
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray2.cgColor
    }

    private let startButtonLabel = WilldUILabel.create(font: .regular14,
                                                       text: localizable.seminarMainFilterInProgress(),
                                                       color: .togetherGray3)

    private lazy var startButton = WilldUIView().then {
        $0.addSubviews(startButtonLabel)
        startButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        $0.snp.makeConstraints {
            $0.leading.trailing.equalTo(startButtonLabel).inset(-18)
            $0.top.bottom.equalTo(startButtonLabel).inset(-7)
        }
        $0.layer.cornerRadius = 17
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray2.cgColor
    }

    private let beforeButtonLabel = WilldUILabel.create(font: .regular14,
                                                        text: localizable.seminarMainFilterBeforeProgress(),
                                                        color: .togetherGray3)

    private lazy var beforeButton = WilldUIView().then {
        $0.addSubviews(beforeButtonLabel)
        beforeButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        $0.snp.makeConstraints {
            $0.leading.trailing.equalTo(beforeButtonLabel).inset(-18)
            $0.top.bottom.equalTo(beforeButtonLabel).inset(-7)
        }
        $0.layer.cornerRadius = 17
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray2.cgColor
    }

    private let endButtonLabel = WilldUILabel.create(font: .regular14,
                                                     text: localizable.seminarMainFilterFinish(),
                                                     color: .togetherGray3)

    private lazy var endButton = WilldUIView().then {
        $0.addSubviews(endButtonLabel)
        endButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        $0.snp.makeConstraints {
            $0.leading.trailing.equalTo(endButtonLabel).inset(-18)
            $0.top.bottom.equalTo(endButtonLabel).inset(-7)
        }
        $0.layer.cornerRadius = 17
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.togetherGray2.cgColor
    }

    private var buttonTapDelegate: (Int) -> Void = { _ in }

    override var intrinsicContentSize: CGSize {
        let width = UIScreen.main.bounds.width
        let height = allButtonLabel.intrinsicContentSize.height
        return CGSize(width: width, height: height)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setButtonTapDelegate(_ delegate: @escaping (Int) -> Void) {
        buttonTapDelegate = delegate
    }

    private func bind() {
        allButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.presentButtonTap(filter: 0)
                self.buttonTapDelegate(0)
            })
            .disposed(by: disposeBag)
        startButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.presentButtonTap(filter: 1)
                self.buttonTapDelegate(1)
            })
            .disposed(by: disposeBag)
        beforeButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.presentButtonTap(filter: 2)
                self.buttonTapDelegate(2)
            })
            .disposed(by: disposeBag)
        endButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.presentButtonTap(filter: 3)
                self.buttonTapDelegate(3)
            })
            .disposed(by: disposeBag)
    }

    func presentButtonTap(filter: Int) {
        initButtonUI()
        switch filter {
        case 0:
            allButton.layer.borderColor = UIColor.togetherPurple.cgColor
            allButtonLabel.textColor = .togetherPurple
            allButtonLabel.configureFont(fontType: .bold14)
        case 1:
            startButton.layer.borderColor = UIColor.togetherPurple.cgColor
            startButtonLabel.textColor = .togetherPurple
            startButtonLabel.configureFont(fontType: .bold14)
        case 2:
            beforeButton.layer.borderColor = UIColor.togetherPurple.cgColor
            beforeButtonLabel.textColor = .togetherPurple
            beforeButtonLabel.configureFont(fontType: .bold14)
        case 3:
            endButton.layer.borderColor = UIColor.togetherPurple.cgColor
            endButtonLabel.textColor = .togetherPurple
            endButtonLabel.configureFont(fontType: .bold14)
        default:
            break
        }
    }

    private func initButtonUI() {
        [allButton, startButton, beforeButton, endButton].forEach {
            $0.layer.borderColor = UIColor.togetherGray3.cgColor
        }

        [allButtonLabel, startButtonLabel, beforeButtonLabel, endButtonLabel].forEach {
            $0.textColor = .togetherGray3
            $0.configureFont(fontType: .regular14)
        }
    }

    private func layout() {
        addSubviews(allButton, startButton, beforeButton, endButton)

        allButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        startButton.snp.makeConstraints {
            $0.leading.equalTo(allButton.snp.trailing).offset(6)
            $0.centerY.equalTo(allButton)
        }
        beforeButton.snp.makeConstraints {
            $0.leading.equalTo(startButton.snp.trailing).offset(6)
            $0.centerY.equalTo(allButton)
        }
        endButton.snp.makeConstraints {
            $0.leading.equalTo(beforeButton.snp.trailing).offset(6)
            $0.centerY.equalTo(allButton)
        }
    }
}
