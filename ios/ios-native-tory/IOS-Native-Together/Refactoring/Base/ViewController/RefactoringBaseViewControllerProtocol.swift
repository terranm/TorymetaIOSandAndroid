//
//  RefactoringBaseViewControllerProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation
import XLPagerTabStrip

protocol RefactoringBaseViewControllerProtocol: UIViewController, AnalyticsProtocol {
    associatedtype ViewModel: RefactoringBaseViewModel
    var navigationTitle: String { get }
    var viewModel: ViewModel { get set }
    func bind(_ viewModel: ViewModel)
    func attribute()
    func layout()
}

extension RefactoringBaseViewControllerProtocol {
    func mInit() {
        attribute()
        viewModel.lifeCycleStatus.accept(.mInit)
        print("🍎 init: \(className)")
    }

    func mViewDidLoad() {
        acceptJudgeViewController(value: self)

        layout()
        bind(viewModel)
        viewModel.lifeCycleStatus.accept(.viewDidLoad)
        print("🍎 viewDidLoad: \(className)")
    }
    func mViewWillAppear(_ animated: Bool) {
        acceptJudgeViewController(value: self)
        // 조건을 추가해야 한다.: 이전 ViewController가 베너라면! 동작하지 않도록
        registerAnalitics()

        setNavigationTitle()

        viewModel.lifeCycleStatus.accept(.viewWillAppear)
        print("🍎 viewWillAppear: \(className)")
    }
    func mViewDidAppear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewDidAppear)
        print("🍎 viewDidAppear: \(className)")
    }
    func mViewWillLayoutSubviews() {
        viewModel.lifeCycleStatus.accept(.viewWillLayoutSubviews)
        print("🍎 viewWillLayoutSubviews: \(className)")
    }
    func mViewDidLayoutSubviews() {
        viewModel.lifeCycleStatus.accept(.viewDidLayoutSubviews)
        print("🍎 viewDidLayoutSubviews: \(className)")
    }
    func mViewWillDisappear(_ animated: Bool) {
        acceptJudgeViewController(value: nil)
        viewModel.lifeCycleStatus.accept(.viewWillDisAppear)
        print("🍎 viewWillDisappear: \(className)")
    }
    func mViewDidDisappear(_ animated: Bool) {
        viewModel.lifeCycleStatus.accept(.viewDidDisAppear)
        print("🍎 viewDidDisappear: \(className)")
    }
    func mDeinit() {
        viewModel.lifeCycleStatus.accept(.mDeinit)
        print("🍎 ViewController deinit: \(className)")
    }
}

extension RefactoringBaseViewControllerProtocol {
    func acceptJudgeViewController(value: UIViewController?) {
        // XLPager의 자식이 아닌 다른 ViewController에서는 depthViewController를 업데이트 시켜준다.
        guard !(self is CommonBottomModal) else { return }
        guard !(self is CommonModal) else { return }
        guard !(self is UIViewController & IndicatorInfoProvider) else { return }
        appContext?.judgeViewController.accept(value)
        print("🧊 accept depthViewController: \(String(describing: value.self))")
    }

    func registerAnalitics() {
        let memberID = repository.member.value.memberId
        if !analyticsId.isEmpty && AppConfigure.isProductRelease && memberID != 0 {
            AnalyticsManager.setAnalytics(analyticsId,
                                          ["type": AnalyticsManager.osName,
                                           "member_id": repository.member.value.memberId])
            print("Analytics Member Id Exit: \(analyticsId)")
        }

        if !analyticsId.isEmpty && AppConfigure.isProductRelease && memberID == 0 {
            AnalyticsManager.setAnalytics(analyticsId,
                                          ["type": AnalyticsManager.osName])
            print("Analytics Member Id Not Exit: \(analyticsId)")
        }
    }

    func setNavigationTitle() {
        if !navigationTitle.isEmpty {
            navigationItem.title = navigationTitle
        }
    }
}
