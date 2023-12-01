//
//  LoungeManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/26.
//

import Foundation
import RxSwift
import RxCocoa

final class LoungeManager {

    let repository = WDRepository.shared
    func presentEntranceLounge(viewController: UIViewController?, isFestival: Bool = false) -> Observable<Void> {
        Observable.just(())
            .flatMap { [weak self] in
                guard let self = self else { return Observable<String>.empty() }
                return self.repository.getNewSeminarLoungeVideoURL()
            }
            .flatMapLatest { [weak self, weak viewController] in
                guard let self = self else { return Observable<Void>.empty() }
                let isAvatarExit = self.repository.hasAvaterAttr.value
                if isAvatarExit {
                    var status = MetaWorldSceneStatus.lobby(loungeVideoURL: $0)
                    if isFestival {
//                        let switchSceneInfo = SwitchSceneInfo().getFestivalData(url: $0)
//                        UnityManager.shared.callToUnityFunction(.switchFestival, switchSceneInfo)
                        status = MetaWorldSceneStatus.festival(loungeVideoURL: $0)
                    }
                    let metaWorldViewModel = MetaWorldViewModel(metaworldSceneStatus: status)
                    let metaWorldViewController = MetaWorldViewController(viewModel: metaWorldViewModel)
                    viewController?.presentViewController(viewController: metaWorldViewController,
                                                          modalTransitionStyle: .crossDissolve,
                                                          modalPresentationStyle: .fullScreen)
                }
                if !isAvatarExit {
                    CommonModal.Builder()
                        .setMessage(localizable.loungeManagerSelectAvatar())
                            .setPositiveButton(localizable.loungeManagerConfirm()) {
                            $0.dismiss(animated: true)
                        }
                        .build()
                        .show()
                }
                return Observable<Void>.just(())
            }
    }
}
