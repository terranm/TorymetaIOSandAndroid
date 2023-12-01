//
//  BottomSlideBannerViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/13.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal
import SwiftDate

final class BottomSlideBannerViewController: RefactoringBaseViewController<BottomSlideBannerViewModel> {
    private lazy var collectionView = BottmonBannerSlideView(viewModel: viewModel)
    private lazy var optionView = BottomBannerSlideOptionView(viewModel: viewModel)
    private var eventButtonTapDelegate: (BottomSlideBannerEntranceStatus) -> Void = { _ in }
    private let bottomeFiller = UIView()

    override func bind(_ viewModel: BottomSlideBannerViewModel) {
        super.bind(viewModel)

        view.rx.baseTapGesture()
            .bind(to: rx.dismiss())
            .disposed(by: disposeBag)

        viewModel.getContensButtonTapEvent()
            .emit(onNext: { [weak self] data in
                self?.dismiss(animated: true) {
                    guard let self = self else { return }
                    self.eventButtonTapDelegate(data)
                }
            })
            .disposed(by: disposeBag)

        viewModel.getTodayDoneButtonTapEvent()
            .emit(onNext: { [weak self] in
                self?.userDefaultManager.save(value: true, key: WDUserDefaultManager.Key.isEventBannerNotShow)

                let dateformmater = DateFormatter()
                dateformmater.dateFormat = "yyyy-MM-dd"
                let newDate = Date() + 1.days
                let newDateString = dateformmater.string(from: newDate)
                self?.userDefaultManager.save(value: newDateString, key: WDUserDefaultManager.Key.eventBannerCheckDate)
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.getCloseButtonTapEvent()
            .emit(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

    }

    func setEventButtonTapDelegate(_ delegate: @escaping (BottomSlideBannerEntranceStatus) -> Void) {
        self.eventButtonTapDelegate = delegate
    }

    override func attribute() {
        view.backgroundColor = .clear
        bottomeFiller.backgroundColor = UIColor("#FFFFFF")
    }

    override func layout() {
        view.addSubviews(collectionView, optionView, bottomeFiller)
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(optionView.snp.top)
            $0.height.equalTo(286)
        }

        optionView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(42)
        }

        bottomeFiller.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MainViewController.bannerShowFlag = true
    }
}

extension BottomSlideBannerViewController: PanModalPresentable {
    var springDamping: CGFloat { 1.0 }

    var transitionDuration: Double { 0.4}

    var showDragIndicator: Bool {
        return false
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    var anchorModalToLongForm: Bool {
        return false
    }
}
