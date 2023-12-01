//
//  CommonLoadingView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/03.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonLoadingView: IntroViewProtocol, AppStorageProtocol {
    private var disposeBag: DisposeBag? = DisposeBag()
    private var loadingView: UIActivityIndicatorView? = UIActivityIndicatorView()
    private let milliseconds: Int

    init(window: UIWindow?, milliseconds: Int = 600) {
        self.milliseconds = milliseconds
        attribute()
        layout(window: window)

    }

    init(milliseconds: Int = 600) {
        self.milliseconds = milliseconds
        attribute()
        layout()
    }

    func show() {
        blockTouch()

        loadingView?.isHidden = true
        guard let disposeBag = disposeBag else { return }
        Observable<Int>.interval(.milliseconds(milliseconds), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if $0 == 0 {
                    self.loadingView?.isHidden = false
                    self.disposeBag = nil
                }
            })
            .disposed(by: disposeBag)
    }

    func dismiss() {
        allowTouch()

        disposeBag = nil
        loadingView?.isHidden = true
        loadingView?.stopAnimating()
        loadingView?.removeFromSuperview()
        loadingView = nil
    }

    private func attribute() {
        loadingView?.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        loadingView?.hidesWhenStopped = true
        loadingView?.style = .large
        loadingView?.color = .togetherGray1
        loadingView?.startAnimating()
    }

    private func layout(window: UIWindow?) {
        guard let window = window,
              let loadingView = loadingView else { return }
        window.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func layout() {
        let superView = topMostViewController?.view
        guard let loadingView = loadingView,
              let superView = superView else { return }
        superView.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func blockTouch() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    private func allowTouch() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
