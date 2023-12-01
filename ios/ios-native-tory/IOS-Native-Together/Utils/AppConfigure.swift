//
//  AppConfigure.swift
//  Together-IOS-Native
//
//  Created by 도학태 on 2022/09/19.
//

import Foundation
import DeviceKit

struct AppConfigure {
    static let osName = "IOS"
#if DEBUG
    static let isProductRelease = false
#else
    static let isProductRelease = true
#endif
    static let serverVersion = "v1"

    static let osVersion = UIDevice.current.systemVersion
    static let bannerType = "v2"
    static let deviceName = "\(Device.current)"
    static let currentAppVersion = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String) ?? ""

    static let naverMapID = "94b7drz84s"
    static let appleAppstoreID = 6444507303

    static let textBold = "NotoSans-SemiBold"
    static let textRegular = "NotoSans-Regular"

    static let local = "ko_KR"

    /*
     방향에 대한 설정
     */
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask,
                                andRotateTo rotateOrientation: UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
