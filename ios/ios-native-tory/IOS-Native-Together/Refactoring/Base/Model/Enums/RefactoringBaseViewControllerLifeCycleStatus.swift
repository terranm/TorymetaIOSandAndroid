//
//  RefactoringBaseViewControllerLifeCycleStatus.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation

enum RefactoringBaseViewControllerLifeCycleStatus {
    case notInit
    case mInit
    case viewDidLoad
    case viewWillLayoutSubviews
    case viewDidLayoutSubviews
    case viewWillAppear
    case viewDidAppear
    case viewWillDisAppear
    case viewDidDisAppear
    case mDeinit
}
