//
//  AvatarPreviewViewModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/11.
//

import Foundation
import RxSwift
import RxCocoa

final class AvatarPreviewViewModel: RefactoringBaseViewModel {
    let metaExsit = PublishRelay<Void>()
    var presentMetaExist: Signal<Bool>?
    private(set) var avatarRegisterRelay = PublishRelay<Void>()

    enum UnityStatus {
        case start(unityView: UIView?)
        case requireMember
        case awake
        case onDestroy
    }
    private(set) var unityStatusRelay = PublishRelay<UnityStatus>()

    override init() {
        super.init()
        registUnityToNative()
        bind()
    }

    deinit {
        unity.unityDidUnload()
    }

    private func bind() {
        avatarRegisterRelay
            .bind { [weak self] _ in
                self?.registUnityToNative()
            }
            .disposed(by: disposeBag)

        presentMetaExist = metaExsit
            .flatMap { [weak self] _ in
                guard let self = self else { return Observable<Bool>.empty() }
                /*
                 생성 필요
                 */
                let result = self.unity.isInitialized
                return Observable.just(result)
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    private func registUnityToNative() {
        unity.registUnityToNative(self)
    }

    func reloadUnity() {
        if repository.hasAvaterAttr.value {
            unity.unityDidUnload()
        }
        unity.launchUnity()
    }

    func switchScene(_ switchSceneInfo: SwitchSceneInfo) {
        unity.callToUnityFunction(.switchAvatar, switchSceneInfo)
    }

    func setAvatarInfo(_ initAvatarAttribute: InitAvatarAttribute) {
        unity.callToUnityFunction(.initAvatarItems, initAvatarAttribute)
    }
}

extension AvatarPreviewViewModel: NativeCallsProtocol {
    func showHostMainWindow(_ color: String!) {}

    func sendMessage(toMobileApp message: String!) {
        print("Send To Unity Message: \(message ?? "")")

        let convertData = unity.getUnityData(jsonStr: message)
        switch convertData.functionName {
        case "Start":
//            addUnityView()
            unityStatusRelay.accept(.start(unityView: unity.unityView))
        case "RequireMember":
            unity.callToUnityFunction(.passMember, repository.member.value)
        case "Awake", "OnDestroy":
            break
        default:
            print("NOT INVALIDE BRIDGE CALL")
        }
    }
}
