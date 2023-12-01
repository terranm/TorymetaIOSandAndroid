//
//  SceneDelegate.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/09/30.
//

import UIKit
import SwiftDate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let repository = WDRepository.shared
    private let rootViewModel = SplashViewModel()
    /*
     앱이 KILL 됐고 다시 앱에 진입할때는 여기로 빠진다.
     */
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)

        let rootViewController = SplashViewController(viewModel: rootViewModel)

        if connectionOptions.notificationResponse != nil {
            /*
             PUSH로 진일할때
             */
            let userInfo = connectionOptions.notificationResponse?.notification.request.content.userInfo
            _ = userInfo?["content"]
            _ = userInfo?["title"]
            let actionUrl = userInfo?["action_url"] as? String ?? ""

            WDRepository.pushActionUrl = actionUrl
        } else {
            /*
             PUSH로 진입하지 않고 사용자의 탭으로 진입할때
             */
        }

        rootViewController.view.backgroundColor = .togetherWhite
//        rootViewController.bind(rootViewModel)

        /*
         [:*** Unity Release:]
         */
        UnityManager.shared.setHostMainWindow(window)

        PushNotificationManager.globalNavigationRelay?
            .accept(UINavigationController(rootViewController: rootViewController))
        window?.rootViewController = PushNotificationManager.globalNavigationRelay?.value
        window?.makeKeyAndVisible()
        print(localizable.transactionHistoryExpDate("string test"))
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("😃")
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        let userDefault = WDUserDefaultManager.shared

        userDefault.initStepUp()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: Date())
        if userDefault.eventBannerCheckDate == dateStr {
            userDefault.save(value: false, key: WDUserDefaultManager.Key.isEventBannerNotShow)
        }
        repository.isForground.accept(true)
//        print("😃 Forground")
        #if DEBUG
        print("🍔 \(WDUserDefaultManager.shared.token)")
        #endif
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
//        print("😃 Background")
        repository.isForground.accept(false)
        window?.endEditing(true)
    }
}
