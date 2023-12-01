//
//  AppDelegate.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/09/30.
//

import UIKit
import FirebaseMessaging
import NMapsMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let appContext = AppContext()

    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.portrait
    private(set) var appLaunchOpts: [UIApplication.LaunchOptionsKey: Any]?
    private let repository = WDRepository.shared
    private let pushNotificationManager = PushNotificationManager()

    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }

    // TODO: dynamic link 처리하기..
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
//            let webpageURL = userActivity.webpageURL!
            // Handle webpageURL
            return true
        }
        return false
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushNotificationManager.setAPNSToken(deviceToken)
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UILabel.appearance().numberOfLines = 0
        UIImageView.appearance().contentMode = .scaleAspectFill

        BottomTabBarManager.initBottomTabBar()
        NavigationManager.initNavigation()
        // Ready naver map
        NMFAuthManager.shared().clientId = AppConfigure.naverMapID
        // Ready FCM
        pushNotificationManager.setupFCM(self, application)

        appLaunchOpts = launchOptions
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // MARK: 알림이 오면 여기로 빠진다.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // MARK: Forground, Background 상태에서 알림을 터치 했을때는 여기로 빠진다. PUSH 알림에 대한 처리는 너무 중요하다
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        pushNotificationManager.deeplinkHandler(response)
        completionHandler()
    }
}
