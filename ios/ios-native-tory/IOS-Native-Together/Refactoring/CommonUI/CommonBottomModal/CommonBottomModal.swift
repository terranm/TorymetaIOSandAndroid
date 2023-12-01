//
//  WilldBottomModal.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/26.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal

final class CommonBottomModal: RefactoringBaseViewController<RefactoringBaseViewModel>,
                                RefactoringBasePanModalPresentable {

    private var actions: [CommonBottomModalAction] = []
    private let actionStackView = UIStackView()
    private let cancelButton = UILabel()

    override func attribute() {
        super.attribute()
        view.backgroundColor = .clear

        actionStackView.axis = .vertical
        actionStackView.spacing = 5

        actionDefaultButtonAttribute(label: cancelButton)
        cancelButton.textColor = .togetherWhite
    }

    override func layout() {
        super.layout()
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }

    }

    override func bind(_ viewModel: RefactoringBaseViewModel) {
        super.bind(viewModel)
        Observable.merge(cancelButton.rx.tapGesture().when(.recognized), view.rx.tapGesture().when(.recognized))
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)
    }
}

extension CommonBottomModal {
    func show() {
        if topMostViewController !== self {
            view.backgroundColor = .clear
            topMostViewController?.presentPanModal(self)
        }
    }

    private func actionDefaultButtonAttribute(label: UILabel) {
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
    }

    struct ConfigureInfo {
        let actions: [CommonBottomModalAction]
        let actionFont: TogetherFontType
        let actionBackgroundColor: UIColor
        let cancelMessage: String
        let cancelFont: TogetherFontType
        let cancelBackgroundColor: UIColor
    }
    private func configure(_ configureInfo: ConfigureInfo) {
        let actionViews = configureInfo.actions
            .map { [weak self] in
                guard let self = self else { return UILabel() }
                let actionView = UILabel()
                self.actionDefaultButtonAttribute(label: actionView)
                actionView.text = $0.title
                let fontDto = FontValue.getFont(with: configureInfo.actionFont)
                actionView.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
                actionView.textColor = $0.titleColor
                actionView.backgroundColor = configureInfo.actionBackgroundColor
                actionView.snp.makeConstraints {
                    $0.height.equalTo(56)
                }
                return actionView
            }
        guard let firstActionViews = actionViews[safe: 0] else { return }

        cancelButton.text = configureInfo.cancelMessage
        cancelButton.backgroundColor = configureInfo.cancelBackgroundColor
        actionViews.forEach {
            actionStackView.addArrangedSubview($0)
        }
        actionStackView.addArrangedSubview(cancelButton)

        view.addSubview(actionStackView)

        actionStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(38)
            $0.top.equalTo(firstActionViews)
        }

        /*
         bind
         */
        actionViews
            .enumerated()
            .forEach { index, actionView in
                actionView.rx.tapGesture()
                .when(.recognized)
                .bind(onNext: { [weak self] _ in
                    self?.dismiss(animated: true) { [weak self] in
                        guard let self = self,
                              let safeAction = configureInfo.actions[safe: index] else { return }
                        safeAction.action(self)
                    }
                })
                .disposed(by: disposeBag)
        }
    }
}

extension CommonBottomModal {
    final class Builder {
        private var actions: [CommonBottomModalAction] = []

        private var actionFont: TogetherFontType = .regular20
        private var actionBackground: UIColor = .togetherWhite

        private var cancelMessage: String = localizable.bottomModalCancel()
        private var cancelFont: TogetherFontType = .regular20
        private var cancelBackgroundColor: UIColor = .togetherPurple

        func setActions(_ actions: [CommonBottomModalAction]) -> Self {
            self.actions = actions
            return self
        }

        func setActionFont(_ font: TogetherFontType) -> Self {
            self.actionFont = font
            return self
        }

        func setActionBackgroundColor(_ color: UIColor) -> Self {
            self.actionBackground = color
            return self
        }

        func setCancelMessage(_ message: String) -> Self {
            self.cancelMessage = message
            return self
        }

        func setCancelFont(_ font: TogetherFontType) -> Self {
            self.cancelFont = font
            return self
        }

        func cancelBackgroundColor(_ color: UIColor) -> Self {
            self.cancelBackgroundColor = color
            return self
        }

        func build() -> CommonBottomModal {
            CommonBottomModal(viewModel: RefactoringBaseViewModel()).then {
                $0.configure(ConfigureInfo(actions: actions,
                                           actionFont: actionFont,
                                           actionBackgroundColor: actionBackground,
                                           cancelMessage: cancelMessage,
                                           cancelFont: cancelFont,
                                           cancelBackgroundColor: cancelBackgroundColor))
            }
        }
    }
}
