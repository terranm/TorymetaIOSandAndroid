//
//  CommonBlurView.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/05.
//

import UIKit
import RxSwift
import RxCocoa

final class CommonBlurView: UIView, IntroViewProtocol {
    private var disposeBag: DisposeBag? = DisposeBag()
    private var commonLoadingView: CommonLoadingView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        blockTouch()

        isHidden = false
        guard let disposeBag = disposeBag else { return }
        Observable<Int>.interval(.milliseconds(1000), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                if $0 == 0 {
                    self?.commonLoadingView = CommonLoadingView(milliseconds: 0)
                    self?.commonLoadingView?.show()
                }
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Dismiss 0.3초 Detail 추가
    func dismiss() {
        guard let disposeBag = disposeBag else { return }
        Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                if $0 == 0 {
                    self?.allowTouch()

                    self?.disposeBag = nil
                    self?.commonLoadingView?.dismiss()
                    UIView.animate(withDuration: 0.3, animations: { [weak self] in
                        self?.alpha = 0
                    }, completion: { [weak self] _ in
                        self?.isHidden = true
                    })
                }
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        isHidden = true
        backgroundColor = .togetherWhite
    }

    private func layout() {
        let depthViewController = depthViewController
        let superView = depthViewController?.view
        guard let superView = superView else { return }
        superView.addSubview(self)
        snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    private func blockTouch() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    private func allowTouch() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
