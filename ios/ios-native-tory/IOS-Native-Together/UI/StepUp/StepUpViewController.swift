//
//  StepUpViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/08.
//

import UIKit
import RxSwift
import RxCocoa

final class StepUpViewController: RefactoringBaseViewController<StepUpViewModel> {

    override var navigationTitle: String { localizable.stepUpNavTitle() }
    override var analyticsId: String { AnalyticsManager.m2e }

    private let closeButton = UIImageView()
    private let underlineView = UIView()
    private let payTableView = UITableView()

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userDefaultManager.isStepUpBannerShow == "true" {
            showBannerView()
        } else {
            checkMotionPermission()
        }
    }

    override func attribute() {
        closeButton.image = R.image.default_banner_exit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)

        underlineView.backgroundColor = .togetherGray3

        payTableView.register(StepPayTableViewCell.self,
                              forCellReuseIdentifier: String(describing: StepPayTableViewCell.self))
        payTableView.separatorStyle = .none
        payTableView.backgroundColor = .togetherWhite
    }

    override func layout() {
        super.layout()

        closeButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }

        view.addSubviews(underlineView, payTableView)

        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

        payTableView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func bind(_ viewModel: StepUpViewModel) {
        super.bind(viewModel)

        let headerView = StepHeaderTableViewCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
        headerView.bind(viewModel)
        payTableView.tableHeaderView = headerView

        repository.isForground
            .filter { $0 }
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable.just(StepUpPageDto()) }
                return self.repository.getStepUpCondition()
            }
            .bind(to: viewModel.stepUpCondition)
            .disposed(by: disposeBag)

        repository.isForground
            .filter { $0 }
            .map { _ in
                viewModel.checkInOutUistate.value
            }
            .bind(to: viewModel.checkInOutUistate)
            .disposed(by: disposeBag)

        closeButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.payList
            .drive(payTableView.rx.items) { [weak self] tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: StepPayTableViewCell.self),
                    for: indexPath) as? StepPayTableViewCell else { return UITableViewCell() }
                cell.configure(data, viewModel)

                cell.mileagePayButton.rx.tapGesture()
                    .when(.recognized)
                    .filter { _ in !data.isPayment }
                    .bind { _ in
                        if viewModel.stepCounting.value < data.stepCount {
                            self?.showIncompleteModal(viewModel)
                        } else {
                            self?.showCompleteModal(viewModel, row: row, data: data)
                        }
                    }
                    .disposed(by: cell.diseposeBag)
                return cell
            }
            .disposed(by: disposeBag)
    }

    private func showIncompleteModal(_ viewModel: StepUpViewModel) {
        let checkInStatus = viewModel.checkInOutUistate.value
        let image: UIImage? = checkInStatus == .checkIn ? R.image.step_purple(): R.image.step_yellow()
        let message = localizable.stepUpIncompleteSteps()
        showMileageModal("", image: image, message: message, buttonTitle: localizable.stepUpAlertOptConfirm())
    }

    private func showCompleteModal(_ viewModel: StepUpViewModel, row: Int, data: StepUpPageDto.PaymentItem) {
        let checkInStatus = viewModel.checkInOutUistate.value
        // 포인트 지급하기 api 요청하기
        viewModel.paymentButtonTap.accept(data)
        // 초기화 해주기....
        switch checkInStatus {
        case.checkIn:
            var newItem = viewModel.checkInList.value
            newItem[row].isPayment = true
            viewModel.checkInList.accept(newItem)
        case.checkOut:
            var newItem = viewModel.checkOutList.value
            newItem[row].isPayment = true
            viewModel.checkOutList.accept(newItem)
        }

        // modal
        let image: UIImage? = checkInStatus == .checkIn ? R.image.step_purple() : R.image.step_yellow()
        let message = localizable.stepUpServeMileageDesc(data.paymentMileage)
//        "걸음 수 보상으로\n\(data.paymentMileage)M를 획득하였습니다."
        showMileageModal(localizable.stepUpServeMileage(), image: image, message: message,
                         buttonTitle: localizable.stepUpAlertOptConfirm())
    }

    private func showMileageModal(_ title: String, image: UIImage?, message: String, buttonTitle: String) {
        CommonModal.Builder()
            .setTitle(title)
            .setImage(image, width: 55, height: 46)
            .setMessage(message)
            .setPositiveButton(buttonTitle) {
                $0.dismiss(animated: true)
            }
            .build()
            .show()
    }

    private func showBannerView() {
        let banner = StepUpBannerViewController(viewModel: RefactoringBaseViewModel())
        banner.modalTransitionStyle = .crossDissolve
        banner.modalPresentationStyle = .overFullScreen
        banner.view.backgroundColor = .clear
        banner.setDelegate { [weak self] in
            self?.checkMotionPermission()
        }
        present(banner, animated: true)
    }

    private func checkMotionPermission() {
        if !(permissionManager.checkMotionPermission() == .granted &&
             permissionManager.checkLocationPermission() == .granted) {
            CommonModal.Builder()
                .setTitle(localizable.stepUpAppSettings())
                .setMessage(localizable.stepUpConfirmFitness())
                .setNagativeButton(localizable.stepUpAlertOptConfirm()) {
                    $0.dismiss(animated: true)
                }
                .setPositiveButton(localizable.stepUpAlertOptSetting()) { [weak self] in
                    $0.dismiss(animated: true)
                    self?.showIOSSetting()
                }
                .build()
                .show()
        }
    }
}
