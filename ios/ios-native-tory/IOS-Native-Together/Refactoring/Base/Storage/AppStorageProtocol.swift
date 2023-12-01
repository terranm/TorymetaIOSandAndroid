//
//  AppStorageProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit
import XLPagerTabStrip

protocol AppStorageProtocol {}
extension UIView: AppStorageProtocol {}
extension UIViewController: AppStorageProtocol {}
extension RefactoringBaseViewModel: AppStorageProtocol {}

extension AppStorageProtocol {
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }

    var appContext: AppContext? {
        appDelegate?.appContext
    }

    var sceneDelegate: SceneDelegate? {
        UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }

    var window: UIWindow? {
        get {
            sceneDelegate?.window
        }
        set {
            sceneDelegate?.window = newValue
        }
    }

    var rootViewController: UIViewController? {
        get {
            window?.rootViewController
        }
        set {
            window?.rootViewController = newValue
        }
    }

    var topMostViewController: UIViewController? {
        var topMostViewController = self.rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        while let parentViewController = topMostViewController?.parent {
            if parentViewController is UINavigationController {
                topMostViewController = parentViewController
            }

            if let presentedViewController = parentViewController.presentedViewController,
                        presentedViewController != topMostViewController {
                topMostViewController = presentedViewController
            }
        }

        return topMostViewController
    }

    var depthViewController: UIViewController? {
        var depthViewController = self.topMostViewController
        // TabBar
        if let tabBarController = depthViewController as? UITabBarController {
            depthViewController = tabBarController.selectedViewController
        }
        // Navigation
        if let navigationController = depthViewController as? UINavigationController {
            depthViewController = navigationController.visibleViewController
        }
        // XLPager
        if let pagerTapViewController = depthViewController as? ButtonBarPagerTabStripViewController {
            let currentIndex = pagerTapViewController.currentIndex
            depthViewController = pagerTapViewController.viewControllers[currentIndex]
        }
        return depthViewController
    }

    /*
     추후 AppContext의 judgeViewController를 통해서 depthViewController를 판단해야 된다.
     */
//    var depthViewController: UIViewController? {
//        var depthViewController = appContext?.judgeViewController.value
//        //UIViewController, TabBar는 큰 컨테이너 개념이기 때문에 Pass
//
//        //XLPager 작은 container 개념으로 본다
//        if let pagerViewController = depthViewController as? ButtonBarPagerTabStripViewController {
//            depthViewController = pagerViewController
//        }
//
//        return depthViewController
//    }
}
