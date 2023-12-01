//
//  SingletonAppStorageProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit

protocol SingletonStorageProtocol {}
extension UIView: SingletonStorageProtocol {}
extension UIViewController: SingletonStorageProtocol {}
extension RefactoringBaseViewModel: SingletonStorageProtocol {}
extension SingletonStorageProtocol {
    var repository: WDRepository {
        return WDRepository.shared
    }

    var userDefaultManager: WDUserDefaultManager {
        return WDUserDefaultManager.shared
    }

    var helper: WDHelper {
        return WDHelper.shared
    }

    var permissionManager: WDPermissionManager {
        return WDPermissionManager.shared
    }

    var unity: UnityManager {
        return UnityManager.shared
    }
}
