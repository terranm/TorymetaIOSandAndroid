//
//  MainAvatarContainerView.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainAvatarContainerView: UIView {

    let height: CGFloat = 316
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel

    private lazy var addNewAvatarView = AddNewAvatarView(viewModel)
    private lazy var avatarPreview = AvatarPreview(viewModel.avatarPreviewViewModel)
    private lazy var avatarControlView = AvatarControlView(viewModel)

    init(frame: CGRect = .zero, _ viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        layout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubviews(addNewAvatarView, avatarPreview, avatarControlView)

        addNewAvatarView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }

        avatarPreview.snp.makeConstraints {
            $0.edges.equalTo(addNewAvatarView)
        }

        avatarControlView.snp.makeConstraints {
            $0.edges.equalTo(addNewAvatarView)
        }
    }

    private func bind() {
        repository.hasAvaterAttr
            .bind { [weak self] hasAvaterAttr in
//                let hasAvaterAttr = false
                self?.addNewAvatarView.isHidden = hasAvaterAttr
                self?.avatarPreview.isHidden = !hasAvaterAttr
                self?.avatarControlView.isHidden = !hasAvaterAttr
            }
            .disposed(by: disposeBag)

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
        let swtichSceneInfo = SwitchSceneInfo().getAvatarViewData()
        viewModel.avatarPreviewViewModel.switchScene(swtichSceneInfo)

        // 아바타 초기정보 유니티로 전달
        let initAvatarAttribute = InitAvatarAttribute(userName: repository.member.value.name,
                                                      memberId: repository.member.value.memberId,
                                                      avatarState: repository.myAvatarAttr.value)
        viewModel.avatarPreviewViewModel.setAvatarInfo(initAvatarAttribute)
    }
}
