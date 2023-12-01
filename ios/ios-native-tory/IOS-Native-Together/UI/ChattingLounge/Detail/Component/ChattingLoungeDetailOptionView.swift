//
//  ChattingLoungeDetailOptionView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeDetailOptionView: UIView {
    private let disposeBag = DisposeBag()
    private let parentViewModel: ChattingLoungeDetailViewModel

    private let allSelectView = SelectView(name: localizable.chattingLoungeDetailOptionAll())
    private let openSelectView = SelectView(name: localizable.chattingLoungeDetailOptionPubic())
    private let secretSelectView = SelectView(name: localizable.chattingLoungeDetailOptionPrivate())

    init(frame: CGRect = .zero, parentViewModel: ChattingLoungeDetailViewModel) {
        self.parentViewModel = parentViewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(parentViewModel)
        snp.makeConstraints {
            let width: CGFloat = UIScreen.main.bounds.width
            let height: CGFloat = 34
            $0.size.equalTo(CGSize(width: width, height: height))
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {}

    private func layout() {
        addSubviews(allSelectView, openSelectView, secretSelectView)
        allSelectView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        openSelectView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(allSelectView.snp.trailing).offset(6)
        }

        secretSelectView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(openSelectView.snp.trailing).offset(6)
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }

    private func allButtonOff() {
        [allSelectView, openSelectView, secretSelectView].forEach {
            $0.buttonOff()
        }
    }

    private func bind(_ viewModel: ChattingLoungeDetailViewModel) {
        viewModel.option
            .bind(onNext: { [weak self] in
                self?.allButtonOff()
                switch $0 {
                case .all:
                    self?.allSelectView.buttonOn()
                case .open:
                    self?.openSelectView.buttonOn()
                case .secret:
                    self?.secretSelectView.buttonOn()
                }
            })
            .disposed(by: disposeBag)

        allSelectView.rx.baseTapGesture()
            .map { ChattingLoungeDetailOptionStatus.all }
            .bind(to: viewModel.option)
            .disposed(by: disposeBag)

        openSelectView.rx.baseTapGesture()
            .map { ChattingLoungeDetailOptionStatus.open }
            .bind(to: viewModel.option)
            .disposed(by: disposeBag)

        secretSelectView.rx.baseTapGesture()
            .map { ChattingLoungeDetailOptionStatus.secret }
            .bind(to: viewModel.option)
            .disposed(by: disposeBag)
    }

    final class SelectView: UIView {
        private let backgroundView = UIView()
        private let nameLabel = UILabel()

        init(frame: CGRect = .zero, name: String) {
            self.nameLabel.text = name
            super.init(frame: frame)
            attribute()
            layout()
            initUI()
            snp.makeConstraints {
                let width = nameLabel.intrinsicContentSize.width + 36
                let height: CGFloat = 34
                $0.size.equalTo(CGSize(width: width, height: height))
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func attribute() {
            backgroundView.layer.cornerRadius = 17
            backgroundView.layer.borderWidth = 1

            nameLabel.configureFont(.regular14)
        }

        private func layout() {
            addSubviews(backgroundView, nameLabel)
            backgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            nameLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }

        func buttonOn() {
            backgroundView.layer.borderColor = UIColor.togetherPurple.cgColor
            nameLabel.textColor = .togetherPurple
        }

        func buttonOff() {
            backgroundView.layer.borderColor = UIColor.togetherGray3.cgColor
            nameLabel.textColor = .togetherGray3
        }

        private func initUI() {
            buttonOff()
        }
    }
}
