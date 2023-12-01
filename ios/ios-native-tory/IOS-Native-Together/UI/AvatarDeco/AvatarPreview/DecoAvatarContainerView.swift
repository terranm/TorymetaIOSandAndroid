//
//  DecoAvatarContainerView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/27.
//

import UIKit
import SnapKit
import RxSwift

final class DecoAvatarContainerView: UIView {

    private let disposeBag = DisposeBag()
    private let viewModel: AvatarDecoViewModel
    private lazy var avatarPreview = AvatarPreview(viewModel.avatarPreviewViewModel)
    private lazy var decoControlView = DecoControlView(viewModel)
    private lazy var decoPalletteView = DecoPalletteView(viewModel)

    init(frame: CGRect = .zero, _ viewModel: AvatarDecoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubviews(avatarPreview, decoPalletteView, decoControlView)
        bringSubviewToFront(decoPalletteView)

        avatarPreview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        decoPalletteView.snp.makeConstraints {
            $0.verticalEdges.left.equalToSuperview().inset(16)
            $0.width.equalTo(44)
        }

        decoControlView.snp.makeConstraints {
            $0.verticalEdges.right.equalToSuperview()
        }
    }

    private func bind() {
        viewModel.avatarPreviewViewModel.presentMetaExist?
            .emit { [weak self] _ in
                self?.unityLayout()
            }
            .disposed(by: disposeBag)
    }

    private func unityLayout() {
        viewModel.avatarPreviewViewModel.reloadUnity()
        window?.rootViewController?.setNeedsStatusBarAppearanceUpdate()

        // SwitchScene
        let swtichSceneInfo = SwitchSceneInfo().getDecoData()
        viewModel.avatarPreviewViewModel.switchScene(swtichSceneInfo)

        // 아바타 초기정보 유니티로 전달
        let initAvatarAttribute = InitAvatarAttribute(userName: repository.member.value.name,
                                                      memberId: repository.member.value.memberId,
                                                      avatarState: repository.myAvatarAttr.value)
        viewModel.avatarPreviewViewModel.setAvatarInfo(initAvatarAttribute)
    }
}
