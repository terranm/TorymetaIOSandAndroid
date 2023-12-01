//
//  BaseViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation
import RxSwift
import RxCocoa

class RefactoringBaseViewModel: NSObject {
    let disposeBag = DisposeBag()

    let lifeCycleStatus = BehaviorRelay<RefactoringBaseViewControllerLifeCycleStatus>(value: .notInit)

    deinit {
        print("🍎 ViewModel deinit: \(className)")
    }
}
