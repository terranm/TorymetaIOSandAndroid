//
//  RefactoringBasePageViewController.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation
import RxSwift
import XLPagerTabStrip

class RefactoringBasePagerViewController<ViewModel: RefactoringBaseViewModel>: ButtonBarPagerTabStripViewController,
                                                                               RefactoringBaseViewControllerProtocol {
    typealias ViewModel = ViewModel

    let disposeBag = DisposeBag()
    var viewModel: ViewModel

    var navigationTitle: String { "" }

    var analyticsId: String { "" }

    let pagerButtonBarView = ButtonBarView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let containerScrollView = UIScrollView()

    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, viewModel: ViewModel) {
        self.viewModel = viewModel
        print("🍎 ViewModel init: \(viewModel.className)")
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.mInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(_ viewModel: ViewModel) {}

    func attribute() {
        self.containerView = containerScrollView
        self.buttonBarView = pagerButtonBarView
    }

    func layout() {
        view.addSubviews(pagerButtonBarView, containerScrollView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mViewDidLoad()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.mViewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mViewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mViewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mViewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mViewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mViewDidDisappear(animated)
    }
    deinit {
        self.mDeinit()
    }
}
