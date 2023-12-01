//
//  DecoPalletteView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: Pallette
final class DecoPalletteView: UIView {

    private let disposeBag = DisposeBag()
    private let viewModel: AvatarDecoViewModel
    private let palletteScroll = UIScrollView()
    private let palletteToggleButton = UIButton()
    private var expandPalletteConstraint: Constraint?
    private let stackView = UIStackView()
    private var colorButtons = [AvatarDecoColorButton]()

    init(frame: CGRect = .zero, _ viewModel: AvatarDecoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        attribute()
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func attribute() {
        clipsToBounds = true
        layer.cornerRadius = 22
        palletteScroll.clipsToBounds = true
        palletteScroll.layer.cornerRadius = layer.cornerRadius
        palletteScroll.backgroundColor = UIColor("#FFFFFF")
        palletteScroll.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 44, right: 0)
        palletteScroll.showsVerticalScrollIndicator = false
        stackView.axis = .vertical
        stackView.spacing = 8
        palletteToggleButton.setImage(R.image.pallette_button(), for: .normal)
        palletteToggleButton.adjustsImageWhenHighlighted = false
    }

    private func layout() {
        addSubviews(palletteScroll, palletteToggleButton)
        palletteScroll.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(snp.bottom)
            $0.size.equalTo(snp.size)
            expandPalletteConstraint = $0.top.equalToSuperview().constraint
        }
        expandPalletteConstraint?.isActive = false

        palletteScroll.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }

        palletteToggleButton.snp.makeConstraints {
            $0.centerX.bottom.equalToSuperview()
            $0.size.equalTo(44)
        }
    }

    private func bind() {
        palletteToggleButton.rx
            .controlEvent(.touchUpInside)
            .bind { [weak self] in
                self?.togglePallette()
            }
            .disposed(by: disposeBag)

        viewModel.colorsRelay
            .bind { [weak self] colors in
                self?.setColorButtons(colors)
            }
            .disposed(by: disposeBag)
    }

    private func togglePallette() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.expandPalletteConstraint?.isActive = self.palletteScroll.frame.origin.y > 0
            self.layoutIfNeeded()
        }
    }

    private func setColorButtons(_ colors: [AvatarColor]) {
        // Attribute
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.alpha = colors.isEmpty ? 0 : 1
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.palletteScroll.contentOffset = .zero
            self?.expandPalletteConstraint?.isActive = false
        }

        guard !colors.isEmpty else { return }

        colorButtons = colors.map {
            let colorButton = AvatarDecoColorButton($0.id, $0.colorCode)
            let selectedColorCode = viewModel.currentCategoryType == .face ?
            viewModel.currentAvatarInfo?.skinColorCode : viewModel.currentAvatarInfo?.hairColorCode
            colorButton.isSelected = selectedColorCode == $0.colorCode
            return colorButton
        }
        // Layout
        stackView.removeAllArragedSubviews()
        colorButtons.forEach { colorButton in
            stackView.addArrangedSubview(colorButton)
            colorButton.snp.makeConstraints {
                $0.size.equalTo(32)
            }
        }
        // Bind
        colorButtons.forEach { colorButton in
            colorButton.rx
                .controlEvent(.touchUpInside)
                .bind { [weak self] in
                    guard let color = colors.first(where: { $0.id == colorButton.tag }) else { return }
                    self?.viewModel.decoEventRelay.accept(.pallette(color: color))
                    self?.colorButtons.forEach { $0.isSelected = $0 == colorButton } // 선택된 버튼만 isSelect true
                }
                .disposed(by: disposeBag)
        }
    }
}

// MARK: - Color Button
final class AvatarDecoColorButton: UIButton {

    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 1 : 0
        }
    }

    convenience init(_ tag: Int, _ colorCode: String) {
        self.init(frame: .zero)
        attribute(tag, colorCode)
    }

    private func attribute(_ tag: Int, _ colorCode: String) {
        self.tag = tag
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.borderColor = UIColor("#6C5CE7").cgColor
        setBackgroundColor(UIColor(colorCode), for: .normal)
    }
}
