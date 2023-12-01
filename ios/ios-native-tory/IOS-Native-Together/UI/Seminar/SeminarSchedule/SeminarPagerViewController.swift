//
//  SeminarSchduleViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

final class SeminarPagerViewController: RefactoringBasePagerViewController<SeminarPagerViewModel> {
    override var navigationTitle: String { localizable.seminarPagerTitle() }

    private let loungeButtonView = ToryLoungeButtonView()
    private let loungeManager = LoungeManager()

    override func attribute() {
        super.attribute()

        settings.style.buttonBarBackgroundColor = .togetherWhite
        settings.style.buttonBarItemBackgroundColor = .togetherWhite
        settings.style.selectedBarBackgroundColor = .togetherPurple
        settings.style.selectedBarHeight = 2

        let fontDto = FontValue.getFont(with: .bold14)
        settings.style.buttonBarItemFont = UIFont(name: fontDto.fontName,
                                                  size: fontDto.fontSize) ?? .systemFont(ofSize: 20)
        // swiftlint:disable closure_parameter_position
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,
                                           newCell: ButtonBarViewCell?,
                                           _: CGFloat,
                                           changeCurrentIndex: Bool,
                                           _: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            let old = FontValue.getFont(with: .regular14)
            oldCell?.label.textColor = .togetherBlack
            oldCell?.label.font = UIFont(name: old.fontName, size: old.fontSize)

            let new = FontValue.getFont(with: .bold14)
            newCell?.label.textColor = .togetherPurple
            newCell?.label.font = UIFont(name: new.fontName, size: new.fontSize)
        }
    }

    override func layout() {
        super.layout()

        view.addSubview(loungeButtonView)
        pagerButtonBarView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        containerScrollView.snp.makeConstraints {
            $0.top.equalTo(pagerButtonBarView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        loungeButtonView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func bind(_ viewModel: SeminarPagerViewModel) {
        super.bind(viewModel)
        loungeButtonView.loungeButton.rx.baseTapGesture()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Void>.empty() }
                return self.loungeManager.presentEntranceLounge(viewController: self)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let applyViewModel = ApplySeminarViewModel()
        let applyVc = ApplySeminarViewController(viewModel: applyViewModel)

        let createViewModel = CreateSeminarViewModel()
        let createVc = CreateSeminarViewController(viewModel: createViewModel)
        return [applyVc, createVc]
    }
}
