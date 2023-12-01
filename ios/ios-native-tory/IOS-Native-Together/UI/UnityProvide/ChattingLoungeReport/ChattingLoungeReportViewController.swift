//
//  ChattingLoungeReportViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/16.
//

import UIKit
import RxSwift
import RxCocoa

final class ChattingLoungeReportViewController: RefactoringBaseViewController<ChattingLoungeReportViewModel> {
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIImageView()
    private let descriptionLabel = UILabel()
    private let optionInfoLabel = UILabel()
    private lazy var optionSelectView = ChattingLoungeReportOptionSelectView(parentViewModel: viewModel)
    private let reportButton = UIView()
    private let reportButtonLabel = UILabel()

    override func bind(_ viewModel: ChattingLoungeReportViewModel) {
        super.bind(viewModel)
        Observable.merge(backgroundView.rx.baseTapGesture(), closeButton.rx.baseTapGesture())
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.reportNonActive()
            .map { $0 ? UIColor("#D9D9D9") : UIColor("#FD6E6E") }
            .bind(to: reportButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        reportButton.rx.baseTapGesture()
            .bind(to: viewModel.reportButtonTap)
            .disposed(by: disposeBag)

        viewModel.reportButtonTapWithComplete()
            .emit(onNext: { [weak self] _ in
                self?.dismiss(animated: true) {
                    CommonToast.Builder()
                        .setMessage(localizable.chattingLoungeReportReportCompleteMessage())
                        .setMessageFont(.bold14)
                        .setMessageColor(.togetherWhite)
                        .setBackgroundImage(R.image.chatting_lounge_common_toast_background())
                        .build()
                        .showToastWithCenterAndCustomWidth(width: 342)
                }
            })
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()

        backgroundView.backgroundColor = viewModel.isBackgrounClorClear ? .clear : .black.withAlphaComponent(0.7)

        containerView.backgroundColor = UIColor("#FFFFFF")
        containerView.layer.cornerRadius = 16

        titleLabel.text = localizable.chattingLoungeReportTitle()
        titleLabel.configureFont(.bold20)

        closeButton.image = R.image.chatting_lounge_common_exit()

        descriptionLabel.text = localizable.chattingLoungeReportDescription()
        descriptionLabel.configureFont(.regular16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2

        optionInfoLabel.text = localizable.chattingLoungeReportOptionInfo()
        optionInfoLabel.configureFont(.bold16)

        reportButtonLabel.text = localizable.chattingLoungeReportReportButtontText()
        reportButtonLabel.configureFont(.bold16)
        reportButtonLabel.textColor = UIColor("#FFFFFF")

        reportButton.backgroundColor = UIColor("#D9D9D9")
        reportButton.layer.cornerRadius = 12
    }

    override func layout() {
        super.layout()
        view.addSubviews(backgroundView, containerView, titleLabel, closeButton, descriptionLabel,
                         optionInfoLabel, optionSelectView, reportButton, reportButtonLabel)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints {
            $0.width.equalTo(428)
            $0.height.equalTo(280)
            $0.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(24)
            $0.centerX.equalTo(containerView)
        }

        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(containerView).inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(containerView)
        }

        optionInfoLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(containerView)
        }

        optionSelectView.snp.makeConstraints {
            $0.top.equalTo(optionInfoLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(containerView).inset(20)
        }

        reportButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(optionSelectView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(containerView).inset(78)
        }

        reportButtonLabel.snp.makeConstraints {
            $0.center.equalTo(reportButton)
        }
    }
}
