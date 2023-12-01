//
//  ChattingLoungeSelectOptionView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeSelectOptionView: UIView {
    private let disposeBag = DisposeBag()
    private let parentViewModel: ChattingLoungeChattingListViewModel

    private let allSelectView = SelectView()
    private let participateSelectView = SelectView()
    private let openSelectView = SelectView()
    private let secretSelectView = SelectView()

    override var intrinsicContentSize: CGSize {
        let width = UIScreen.main.bounds.width
        let heigth: CGFloat = 32
        return CGSize(width: width, height: heigth)
    }

    init(frame: CGRect = .zero, parentViewModel: ChattingLoungeChattingListViewModel) {
        self.parentViewModel = parentViewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind(parentViewModel)
        self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        allSelectView.setText(name: localizable.chattingLoungeChattingListSelectOptionAll())
        participateSelectView.setText(name: localizable.chattingLoungeChattingListSelectOptionParticipate())
        openSelectView.setText(name: localizable.chattingLoungeChattingListSelectOptionOpen())
        secretSelectView.setText(name: localizable.chattingLoungeChattingListSelectOptionSecret())
    }

    private func layout() {
        addSubviews(allSelectView, participateSelectView, openSelectView, secretSelectView)

        allSelectView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        participateSelectView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(allSelectView.snp.trailing)
        }
        openSelectView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(participateSelectView.snp.trailing)
        }
        secretSelectView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(openSelectView.snp.trailing)
        }
    }

    private func bind(_ viewModel: ChattingLoungeChattingListViewModel) {
        viewModel.optionSelect
            .bind(onNext: { [weak self] in
                self?.selectViewButtonTap(state: $0)
            })
            .disposed(by: disposeBag)

        allSelectView.rx.baseTapGesture()
            .map { ChattingLoungeChattingListStatus.all }
            .bind(onNext: {
                viewModel.optionSelect.accept($0)
            })
            .disposed(by: disposeBag)

        participateSelectView.rx.baseTapGesture()
            .map { ChattingLoungeChattingListStatus.participate }
            .bind(onNext: {
                viewModel.optionSelect.accept($0)
            })
            .disposed(by: disposeBag)

        openSelectView.rx.baseTapGesture()
            .map { ChattingLoungeChattingListStatus.open }
            .bind(onNext: {
                viewModel.optionSelect.accept($0)
            })
            .disposed(by: disposeBag)

        secretSelectView.rx.baseTapGesture()
            .map { ChattingLoungeChattingListStatus.secret }
            .bind(onNext: {
                viewModel.optionSelect.accept($0)
            })
            .disposed(by: disposeBag)
    }

    private func allOff() {
        [allSelectView, participateSelectView, openSelectView, secretSelectView].forEach {
            $0.checkBoxOff()
        }
    }

    private func selectViewButtonTap(state: ChattingLoungeChattingListStatus) {
        self.allOff()
        switch state {
        case .all:
            allSelectView.checkBoxOn()
        case .participate:
            participateSelectView.checkBoxOn()
        case .secret:
            secretSelectView.checkBoxOn()
        case .open:
            openSelectView.checkBoxOn()
        }
    }

    final class SelectView: UIView {
        private let checkBoxButton = UIImageView()
        private let nameLable = UILabel()

        override var intrinsicContentSize: CGSize {
            let width: CGFloat = 32 + nameLable.intrinsicContentSize.width
            let height: CGFloat = 32
            return CGSize(width: width, height: height)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            layout()
            initUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setText(name: String) {
            nameLable.text = name
            snp.makeConstraints {
                $0.size.equalTo(intrinsicContentSize)
            }
        }

        func checkBoxOn() {
            checkBoxButton.image = R.image.chatting_lounge_chatting_list_select_on()
            nameLable.textColor = UIColor("#6C5CE7")
        }

        func checkBoxOff() {
            checkBoxButton.image = R.image.chatting_lounge_chatting_list_select_off()
            nameLable.textColor = UIColor("#D9D9D9")
        }

        private func initUI() {
            checkBoxButton.image = R.image.chatting_lounge_chatting_list_select_off()
            nameLable.configureFont(.regular12)
            nameLable.text = "fweefwefwfwe"
            nameLable.textColor = UIColor("#D9D9D9")
        }

        private func layout() {
            addSubviews(checkBoxButton, nameLable)
            checkBoxButton.snp.makeConstraints {
                $0.size.equalTo(32)
                $0.top.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
            }
            nameLable.snp.makeConstraints {
                $0.centerY.equalTo(checkBoxButton)
                $0.leading.equalTo(checkBoxButton.snp.trailing)
            }
        }
    }
}
