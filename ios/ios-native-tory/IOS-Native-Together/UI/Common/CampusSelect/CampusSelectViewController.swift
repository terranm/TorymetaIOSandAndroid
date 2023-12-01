//
//  MyCampusSelectDetailViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import PanModal

// MARK: 메모리 누수
final class CampusSelectViewController: RefactoringBaseViewController<CampusSelectViewModel> {
    override var navigationTitle: String { localizable.campusSelectNavigationTitle() }
    private let exitNavigationButton = UIImageView()
    private let headerLabel = UILabel()
    private let selectInfoLabel = UILabel()
    private let campusNameLabel = UILabel()
    private let underLinView = UIView()
    private let completeButton = UIView()
    private let completeButtonLabel = UILabel()

    override func attribute() {
        super.attribute()
        exitNavigationButton.image = R.image.default_banner_exit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitNavigationButton)

        headerLabel.font = R.font.notoSansRegular(size: 20)
        headerLabel.text = localizable.campusSelectTitle()
        headerLabel.textColor = .togetherBlack

        selectInfoLabel.font = R.font.notoSansRegular(size: 14)
        selectInfoLabel.text = localizable.campusSelectSelectInfo()
        selectInfoLabel.textColor = .togetherBlack

        campusNameLabel.font = R.font.notoSansRegular(size: 20)
        campusNameLabel.text = localizable.campusSelectCampusName()
        campusNameLabel.textColor = .togetherGray2
        campusNameLabel.textAlignment = .left

        underLinView.backgroundColor = .togetherGray3

        completeButton.layer.cornerRadius = 28
        completeButtonLabel.font = R.font.notoSansSemiBold(size: 20)
        completeButtonLabel.text = localizable.campusSelectCompleteButtonText()
        completeButtonLabel.textColor = .togetherWhite
    }

    override func layout() {
        super.layout()

        view.addSubviews(exitNavigationButton, headerLabel, selectInfoLabel, campusNameLabel, underLinView,
                         completeButton, completeButtonLabel)

        exitNavigationButton.snp.makeConstraints {
            $0.size.equalTo(44)
        }

        headerLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.leading.equalToSuperview().inset(16)
        }

        selectInfoLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(16)
        }

        campusNameLabel.snp.makeConstraints {
            $0.top.equalTo(selectInfoLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        underLinView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalTo(campusNameLabel).offset(12)
            $0.leading.trailing.equalTo(campusNameLabel)
        }

        completeButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        completeButtonLabel.snp.makeConstraints {
            $0.center.equalTo(completeButton)
        }
    }

    override func bind(_ viewModel: CampusSelectViewModel) {
        super.bind(viewModel)
        exitNavigationButton.rx.tapGesture()
            .when(.recognized)
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.presntCampusName
            .drive(campusNameLabel.rx.text)
            .disposed(by: disposeBag)

        campusNameLabel.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.showCampusSelectModal(viewModel)
            })
            .disposed(by: disposeBag)

        viewModel.university
            .map {
                $0.universityCode == "" ? UIColor.togetherGray3 : UIColor.togetherPurple
            }
            .bind(to: completeButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        completeButton.rx.tapGesture()
            .when(.recognized)
            .filter { _ in
                viewModel.university.value.universityCode != ""
            }
            .bind(to: viewModel.completeButtonTap)
            .disposed(by: disposeBag)

        viewModel.presentModifyPage
            .drive(onNext: { [weak self]  in
                if case .confirm = $0.type {
                    self?.showSchoolVeficationWebView($0.university ?? .init(), isMofify: false)
                } else if case .change = $0.type {
                    self?.showSchoolVeficationWebView($0.university ?? .init(), isMofify: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CampusSelectViewController {
    private func showSchoolVeficationWebView(_ universityItem: UniversityListResultDto.Item, isMofify: Bool) {
        let url = ToryWebViewURL(path: ToryWebViewURLType.selectUniversity.path,
                                 getParams: ["universityCode": "\(universityItem.universityCode)",
                                             "domain": "\(universityItem.emailDomain)",
                                             "isModify": "\(true)"])
        let viewmodel = CommonWebViewModel()
        let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewmodel)
        pushViewController(viewController: commonWebViewController, title: "")
    }

    private func showCampusSelectModal(_ viewModel: CampusSelectViewModel) {
        let campusSelectModal = CampusSelectModal(viewModel: RefactoringBaseViewModel())
        campusSelectModal.setDelegate {
            viewModel.university.accept($0)
        }
        presentPanmodal(panModel: campusSelectModal, backgroundColor: .togetherWhite)
    }
}
