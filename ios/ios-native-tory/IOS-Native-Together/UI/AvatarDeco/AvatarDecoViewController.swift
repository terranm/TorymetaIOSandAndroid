//
//  AvatarDecoViewController.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AvatarDecoViewController: RefactoringBaseViewController<AvatarDecoViewModel> {
    private let mileageLabel = MileageLabel(showBorder: true)
    private lazy var decoAvatarContainerView = DecoAvatarContainerView(viewModel)
    private lazy var decoContainerView = DecoContainerView(viewModel)
    private lazy var sortingListTableViewController = DecoSortingListViewController(viewModel: viewModel)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        viewModel.avatarPreviewViewModel.avatarRegisterRelay.accept(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.avatarPreviewViewModel.metaExsit.accept(())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func attribute() {
        super.attribute()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mileageLabel)
    }

    override func layout() {
        super.layout()

        view.addSubviews(decoAvatarContainerView, decoContainerView)
        decoAvatarContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(320)
        }

        decoContainerView.snp.makeConstraints {
            $0.top.equalTo(decoAvatarContainerView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view)
        }
    }

    override func bind(_ viewModel: AvatarDecoViewModel) {
        super.bind(viewModel)

        viewModel.mileageRelay
            .bind { [weak self] point in
                self?.mileageLabel.text = (point.mileage).decimalPointed
            }
            .disposed(by: disposeBag)

        viewModel.listOptionRelay
            .bind { [weak self] listOption in
                guard case .showSortingList = listOption else { return }
                guard let self else { return }
                self.presentPanmodal(panModel: self.sortingListTableViewController, backgroundColor: .togetherWhite)
            }
            .disposed(by: disposeBag)

        viewModel.decoEventRelay
            .bind(onNext: { [weak self] decoEventType in
                guard case .save = decoEventType else { return }
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
