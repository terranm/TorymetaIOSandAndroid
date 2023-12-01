//
//  DecoControlView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/28.
//

import UIKit
import RxSwift
import RxCocoa

final class DecoControlView: UIView {

    typealias DecoEventType = AvatarDecoViewModel.DecoEventType
    private let disposeBag = DisposeBag()
    private let viewModel: AvatarDecoViewModel
    private let unity = UnityManager.shared
    private let rotationButton = UIButton()
    private let restoreButton = UIButton()
    private let mileageLabel = MileageLabel()
    private let saveButton = UIButton()

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
        rotationButton.setImage(R.image.rotation_button(), for: .normal)
        rotationButton.adjustsImageWhenHighlighted = false
        restoreButton.setImage(R.image.restore_button(), for: .normal)
        restoreButton.adjustsImageWhenHighlighted = false
        saveButton.setTitle("저장", for: .normal)
        saveButton.setTitleColor(UIColor("#6C5CE7"), for: .normal)
        saveButton.setBackgroundColor(UIColor("#FFFFFF"), for: .normal)
        saveButton.titleLabel?.font = UIFont(name: AppConfigure.textBold, size: 14)
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        saveButton.adjustsImageWhenHighlighted = false
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 8
        mileageLabel.text = "0"
    }

    private func layout() {
        addSubviews(rotationButton, restoreButton, mileageLabel, saveButton)

        rotationButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }

        restoreButton.snp.makeConstraints {
            $0.bottom.equalTo(mileageLabel.snp.top).offset(-20)
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }

        mileageLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
            $0.width.greaterThanOrEqualTo(30)
            $0.height.equalTo(32)
        }

        saveButton.snp.makeConstraints {
            $0.left.equalTo(mileageLabel.snp.right).offset(8)
            $0.right.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }
    }

    private func bind() {
        rotationButton.rx
            .controlEvent(.touchUpInside)
            .bind { [weak self] _ in
                self?.viewModel.decoEventRelay.accept(.rotate)
            }
            .disposed(by: disposeBag)

        restoreButton.rx
            .controlEvent(.touchUpInside)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.showRestoreAlert()
            }
            .disposed(by: disposeBag)

        mileageLabel.rx
            .tapGesture()
            .when(.recognized)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.viewModel.didSelectPurchase()
            }
            .disposed(by: disposeBag)

        viewModel.currentPurchaseStatus
            .bind { [weak self] purchaseStatus in
                switch purchaseStatus {
                case .available:
                    self?.showPurchaseItemAlert()
                case .insufficient:
                    self?.showPurchaseCoinAlert()
                }
            }
            .disposed(by: disposeBag)

        saveButton.rx
            .controlEvent(.touchUpInside)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.showPutOnAlert()
            }
            .disposed(by: disposeBag)

        viewModel.needPurchaseItemsRelay
            .bind { [weak self] items in
                self?.mileageLabel.debugBounds(items.isEmpty ? .clear : .red)
                self?.mileageLabel.text = self?.viewModel.totalPrice
            }
            .disposed(by: disposeBag)
    }

    // MARK: - 아이템 결재
    private func showPurchaseItemAlert() {
        guard let font = UIFont(name: AppConfigure.textRegular, size: 12) else { return }
        let attributedString = NSMutableAttributedString()
            .attributed(localizable.decoPurchase(), font: font, color: .blue)
            .attachImage(R.image.mileage_badge.name)
            .attributed(" \(viewModel.totalPrice)", font: font, color: .green)
        showAlert(attributedString) { [weak self] in
            $0.dismiss(animated: true) {
                self?.viewModel.didSelectPurcahseItem { purchaseSucceed in
                    if purchaseSucceed {    // 아이템 구매 성공
                        self?.showPutOnAlert()
                    } else {    // 아이템 구매 실패
                        self?.showAlert(message: localizable.decoPurchaseMileageFailure(),
                                        isSingleOption: true) { $0.dismiss(animated: true) }
                    }
                }
            }
        }
    }

    // MARK: - 코인 결재
    private func showPurchaseCoinAlert() {
        guard let font = UIFont(name: AppConfigure.textRegular, size: 12) else { return }
        let attributedString = NSMutableAttributedString()
            .attributed(localizable.decoPurchaseInsufficient(), font: font, color: .blue)
            .attachImage(R.image.mileage_badge.name)
            .attributed(" \(viewModel.totalPrice)", font: font, color: .green)
            .attributed(localizable.decoPurchaseExtra(), font: font, color: .blue)
        showAlert(attributedString) { [weak self] in
            $0.dismiss(animated: true) {
                self?.viewModel.didSelectPurchaseCoin { purchaseSucceed in
                    if purchaseSucceed { // 코인 결제 성공
                        self?.viewModel.currentPurchaseStatus.accept(.available)
                    } else {    // 코인 결제 실패
                        self?.showAlert(message: localizable.decoPurchaseFailure(),
                                        isSingleOption: true) { $0.dismiss(animated: true) }
                    }
                }
            }
        }
    }

    // MARK: - 착용(저장)
    private func showPutOnAlert() {
        showAlert(message: localizable.decoSave()) { [weak self] in
            $0.dismiss(animated: true)
            self?.viewModel.decoEventRelay.accept(.save)
        }
    }

    // MARK: - 복구
    private func showRestoreAlert() {
        showAlert(message: localizable.decoSettingCancel()) { [weak self] in
            self?.viewModel.decoEventRelay.accept(.restore)
            $0.dismiss(animated: true)
        }
    }

    // MARK: - Alert
    private func showAlert(message: String? = nil,
                           _ attributedString: NSMutableAttributedString? = nil,
                           isSingleOption: Bool = false, _ completion: @escaping (CommonModal) -> Void) {
        var alert = CommonModal.Builder()
        if let message {
            alert = alert.setMessage(message)
        }
        if let attributedString {
            alert = alert.setAttributedMessage(attributedString)
        }
        if !isSingleOption {
            alert = alert.setNagativeButton(localizable.decoCancel()) { $0.dismiss(animated: true) }
        }
        alert = alert.setPositiveButton(localizable.decoConfirm(), completion)
        alert.build().show()
    }
}
