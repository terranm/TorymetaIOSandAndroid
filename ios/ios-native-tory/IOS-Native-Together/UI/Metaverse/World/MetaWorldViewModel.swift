//
//  MetaWorldViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/22.
//

import Foundation
import RxSwift
import RxCocoa

final class MetaWorldViewModel: RefactoringBaseViewModel {

    let metaworldSceneStatus: BehaviorRelay<MetaWorldSceneStatus>
    init(metaworldSceneStatus: MetaWorldSceneStatus) {
        self.metaworldSceneStatus = BehaviorRelay(value: metaworldSceneStatus)
        super.init()
    }
}
