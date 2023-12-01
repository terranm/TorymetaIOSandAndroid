//
//  RequestPermissionViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/17.
//

import UIKit
import RxSwift
import RxCocoa

final class RequestPermissionViewController: RefactoringBaseViewController<RequestPermissionViewModel> {
    private let headerLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tableView = UITableView()
    private let completeButton = UIView()
    private let completeButtonLabel = UILabel()

    override func attribute() {
        super.attribute()
        headerLabel.font = R.font.notoSansSemiBold(size: 24)
        headerLabel.text = localizable.requestPermissionTitle()
        headerLabel.textColor = .togetherBlack

        descriptionLabel.font = R.font.notoSansRegular(size: 16)
        descriptionLabel.text = localizable.requestPermissionDescription()
        descriptionLabel.textColor = .togetherGray2

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 88, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .togetherWhite
        tableView.register(ReqPermissionFooterTableViewCell.self,
                           forCellReuseIdentifier: ReqPermissionFooterTableViewCell.identifier)
        tableView.register(ReqPermissionTableViewCell.self,
                           forCellReuseIdentifier: ReqPermissionTableViewCell.identifier)

        completeButton.backgroundColor = .togetherPurple
        completeButton.layer.cornerRadius = 28

        completeButtonLabel.font = R.font.notoSansSemiBold(size: 20)
        completeButtonLabel.text = localizable.requestPermissionCompleteButtonText()
        completeButtonLabel.textColor = .togetherWhite
    }

    override func layout() {
        super.layout()

        view.addSubviews(headerLabel, descriptionLabel, tableView, completeButton, completeButtonLabel)

        headerLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(completeButton.snp.top)
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

    override func bind(_ viewModel: RequestPermissionViewModel) {
        super.bind(viewModel)
        viewModel.items
            .drive(tableView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)

                if row != 6 {
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: String(describing: ReqPermissionTableViewCell.self),
                                             for: indexPath) as? ReqPermissionTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.configure(data)
                    return cell
                } else {
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: String(describing: ReqPermissionFooterTableViewCell.self),
                                             for: indexPath) as? ReqPermissionFooterTableViewCell else {
                        return UITableViewCell()
                    }
                    return cell
                }
            }
            .disposed(by: disposeBag)

        completeButton.rx.baseTapGesture()
            .bind(onNext: { [weak self] in
                guard let self  = self else { return }
                let permissionManager = WDPermissionManager.shared
                permissionManager.reqMotionPermission { _ in
                }

                permissionManager.reqLocationPermission {
                }

                permissionManager.reqAdressPermission { _ in
                    let avatarReViewViewModel = AvatarPreviewViewModel()
                    let newMainViewModel = MainViewModel(avatarReViewViewModel)
                    let newMainViewController = MainViewController(viewModel: newMainViewModel)
                    self.changeRootViewController(viewController: newMainViewController)
                }
            })
            .disposed(by: disposeBag)

    }
}
