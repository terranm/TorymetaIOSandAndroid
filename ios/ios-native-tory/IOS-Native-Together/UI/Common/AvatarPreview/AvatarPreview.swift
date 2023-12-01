//
//  AvatarPreview.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/08.
//

import UIKit
import SnapKit
import RxSwift
import UnityFramework

final class AvatarPreview: UIImageView {
    private let disposeBag = DisposeBag()
    private let viewModel: AvatarPreviewViewModel
    private let ativityIndicator = UIActivityIndicatorView()

    init(image: UIImage? = R.image.newMain_blur(), _ viewModel: AvatarPreviewViewModel) {
        self.viewModel = viewModel
        super.init(image: image)
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    deinit {
//        unity.unityDidUnload()
//    }
//
//    private func attribute() {
//        unity.registUnityToNative(self)
//    }

    private func layout() {
        clipsToBounds = true
        let indicatorBGView = UIImageView(image: R.image.newMain_blur())
        indicatorBGView.contentMode = .scaleAspectFill
        ativityIndicator.addSubview(indicatorBGView)
        ativityIndicator.sendSubviewToBack(indicatorBGView)
        indicatorBGView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addSubviews(ativityIndicator)
        ativityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bind() {
        viewModel.avatarRegisterRelay
            .bind { [weak self] _ in
                guard let self else { return }
                self.ativityIndicator.startAnimating()
//                self.unity.registUnityToNative(self)
            }
            .disposed(by: disposeBag)

//        viewModel.presentMetaExist // 부모 VC의 viewDidAppear에서 accept
//            .emit { [weak self] _ in
//                self?.unityLayout()
//            }
//            .disposed(by: disposeBag)

        viewModel.unityStatusRelay
            .bind { [weak self] unityStatus in
                if case let .start(unityView) = unityStatus {
                    self?.addUnityView(unityView)
                }
            }
            .disposed(by: disposeBag)
    }

    private func addUnityView(_ unityView: UIView?) {
        if let unityView {
//            unityView.layer.zPosition = -1
            addSubview(unityView)
            unityView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            ativityIndicator.stopAnimating()
            ativityIndicator.alpha = 0
//        }
    }
}
