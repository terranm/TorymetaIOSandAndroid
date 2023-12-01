//
//  ChattingLoungeChattingEntranceViewController.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/06/29.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ChattingLoungeChattingEntranceViewController:
    RefactoringBaseViewController<ChattingLoungeChattingEntranceViewModel> {
    enum RoomPublicState: Int {
        case open, close
    }
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let dismissButton = UIButton()
    private let tabOpenRoomButton = UIButton()
    private let containerBorderView = UIView()

    private lazy var titleView = ChattingLoungeChattingEntranceTitleView(parentViewModel: viewModel)
    private lazy var publicOptionView = ChattingLoungeChattingEntrancePublicOptionView(parentViewModel: viewModel)
    private lazy var passwordInputView = ChattingLoungeChattingEntrancePasswordInputView(parentViewModel: viewModel)

    private let confirmButton = UIButton()
    private let confirmButtonLabel = UILabel()

    private var completeDelegate: (ChattingRoomOpenInfo) -> Void = { _ in }

    override func attribute() {
        super.attribute()

        backgroundView.backgroundColor = .black.withAlphaComponent(0.7)

        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .white

        tabOpenRoomButton.setBackgroundColor(UIColor("#6C5CE7"), for: .normal)
        let tabOpenFontDto = FontValue.getFont(with: .bold14)
        tabOpenRoomButton.titleLabel?.font = UIFont(name: tabOpenFontDto.fontName, size: tabOpenFontDto.fontSize)
        tabOpenRoomButton.setTitle(localizable.chattingLoungeChattingEntranceTitle(), for: .normal)
        tabOpenRoomButton.clipsToBounds = true
        tabOpenRoomButton.layer.cornerRadius = 6
        tabOpenRoomButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        dismissButton.setImage(R.image.common_close(), for: .normal)

        containerBorderView.clipsToBounds = true
        containerBorderView.layer.borderWidth = 1
        containerBorderView.layer.borderColor = UIColor("#D9D9D9").cgColor
        containerBorderView.layer.cornerRadius = 10
        containerBorderView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        confirmButton.layer.cornerRadius = 16
        confirmButtonLabel.text = localizable.chattingLoungeChattingEntranceCreateButtonText()
        confirmButtonLabel.textColor = .togetherWhite
        confirmButtonLabel.configureFont(.bold14)
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView, containerView)
        containerView.addSubviews(tabOpenRoomButton, dismissButton, containerBorderView,
                                  confirmButton, confirmButtonLabel)
        containerBorderView.addSubviews(titleView, publicOptionView, passwordInputView)

        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 440, height: 248))
            $0.center.equalToSuperview()
        }
        dismissButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 44, height: 44))
            $0.top.right.equalTo(containerView).inset(8)
        }
        tabOpenRoomButton.snp.makeConstraints {
            $0.top.left.equalTo(containerView).inset(16)
            $0.size.equalTo(CGSize(width: 100, height: 32))
        }

        containerBorderView.snp.makeConstraints {
            $0.top.equalTo(tabOpenRoomButton.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(containerView).inset(16)
        }
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(15)
        }
        publicOptionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.left.right.equalTo(titleView)
        }

        passwordInputView.snp.makeConstraints {
            $0.top.equalTo(publicOptionView.snp.bottom).offset(-4)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(containerBorderView.snp.bottom).inset(8)
            $0.centerX.equalTo(containerBorderView.snp.centerX)
            $0.size.equalTo(CGSize(width: 132, height: 32))
        }

        confirmButtonLabel.snp.makeConstraints {
            $0.center.equalTo(confirmButton)
        }
    }

    override func bind(_ viewModel: ChattingLoungeChattingEntranceViewModel) {
        super.bind(viewModel)

        view.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.endEditing())
            .disposed(by: disposeBag)

        viewModel.isSecret
            .bind(onNext: { [weak self] in
                self?.publicOptionView.warningLabel.isHidden = true
                self?.passwordInputView.initStatus()
                self?.passwordInputView.isHidden = !$0
            })
            .disposed(by: disposeBag)

        viewModel.confirmActive()
            .map { $0 ? .togetherPurple : .togetherGray3}
            .bind(to: confirmButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        confirmButton.rx.baseTapGesture()
            .bind(to: viewModel.confirmButtonTap)
            .disposed(by: disposeBag)

        viewModel.confirmButtonTapWithUnityBridge()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case .passwordInCorrect:
                    self.publicOptionView.warningLabel.isHidden = false
                case .success:
                    let title = viewModel.title.value
                    let isSecret = viewModel.isSecret.value
                    let password = viewModel.secretPassword.value

                    let data = ChattingRoomOpenInfo(roomName: title, password: password, isPrivate: isSecret)
                    self.dismiss(animated: true) {
                        self.completeDelegate(data)
                    }
                }
            })
            .disposed(by: disposeBag)

        Observable.merge(backgroundView.rx.baseTapGesture(), dismissButton.rx.baseTapGesture())
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)
    }

    func setCompleteDelegate(_ delegate: @escaping (ChattingRoomOpenInfo) -> Void) {
        self.completeDelegate = delegate
    }
}
