//
//  PushNotificationManager.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/07/19.
//

import UIKit
import RxSwift
import RxRelay
import Firebase
import FirebaseMessaging

final class PushNotificationManager: NSObject {

    struct NotiInfo {
        var notiType: String
        var tableID: String?

        init(_ actionURL: String) {
            let split = actionURL.split(separator: ":")
            self.notiType = String(split.first ?? "")

            if let tableID = split.last {
                self.tableID = String(tableID)
            }
        }
    }

    static var globalNavigationRelay: BehaviorRelay<UINavigationController?>?
        = BehaviorRelay<UINavigationController?>(value: nil)

    private let disposeBag = DisposeBag()
    private(set) var notiInfo: NotiInfo?
    private var globalNavigation: UINavigationController? {
        PushNotificationManager.globalNavigationRelay?.value
    }
    private var currentRootViewController: UIViewController? {
        globalNavigation?.viewControllers.last
    }

    override init() {
        super.init()
        bind()
    }

    private func bind() {
        PushNotificationManager.globalNavigationRelay?
            .bind { [weak self] navigationController in
                self?.didMoveViewController(navigationController?.viewControllers.last)
            }
            .disposed(by: disposeBag)
    }

    // MARK: 푸시 수신했을때 현재 위치에 따라 필요한 행동을 취한다
    func deeplinkHandler(_ response: UNNotificationResponse) {
        guard let actionURL = response.notification.request.content.userInfo["action_url"] as? String else { return }
        notiInfo = NotiInfo(actionURL)

        // MARK: 메타월드 노출 상태
        if let metaWorldViewController = WDHelper.getRootViewController()?
            .depthViewController as? MetaWorldViewController {
            // chatlounge 알림 수신한 경우
            if case "chatlounge" = notiInfo?.notiType {
                metaWorldViewController.joinByPush(notiInfo?.tableID)
                notiInfo = nil
                return
            } else {
//                metaWorldViewController.unity.unityDidUnload()
                metaWorldViewController.disconnectServer()
            }
        }

        // MARK: 메타월드 비노출, 메인이 있는 상태에서 chatlounge 이외의 알림 수신한 경우
//        print("🌮 -\(currentRootViewController.self)")
        switch currentRootViewController {
        case is MainViewController: // 메인이 존재하고 메타월드는 접근하지 않았을 때
            popViewControllers { [weak self] in // 메인으로 되돌린 후
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.presentDeepLinkViewController() // 메타월드를 표시한다
                }
            }

        case is AvatarDecoViewController:
            popViewControllers { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.presentDeepLinkViewController() // 메타월드를 표시한다
                }
            }

        default:
            break
        }
    }
    private func popViewControllers(_ completion: @escaping () -> Void) {
        globalNavigation?.dismiss(animated: true) { [weak self] in
            self?.globalNavigation?.popToRootViewController(animated: false)
            completion()
        }
    }

    // MARK: - 글로벌 네비가 변경되었을 때 필요한 행동을 취한다 (inactive 상태에서 알림 수신시)
    private func didMoveViewController(_ justPushedViewController: UIViewController?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self else { return }
            guard justPushedViewController != nil, self.notiInfo != nil else { return }
            if case is MainViewController = self.currentRootViewController {
                popViewControllers {
                    self.presentDeepLinkViewController()
                }
            }
        }
    }
    // noti 정보 분기
    private func presentDeepLinkViewController() {
        switch notiInfo?.notiType {
        case "friend":
            AppConfigure.lockOrientation(.portrait)
            presentFriendsList()

        case "chatlounge":
            presentChatLounge(notiInfo?.tableID)

        default:
            break
        }
        notiInfo = nil
    }
}

// MARK: - Navigation
extension PushNotificationManager {
    // MARK: 친구목록 present
    private func presentFriendsList() {
        let friendListViewModel = FriendListViewModel()
        let friendListViewController = FriendListViewController(viewModel: friendListViewModel)
        PushNotificationManager.globalNavigationRelay?.value?
            .presentNavigationViewController(viewController: friendListViewController)
    }

    // MARK: 메타월드 present
    private func presentChatLounge(_ tableID: String?) {
        guard let tableID else { return }
        currentRootViewController?.repository.getNewSeminarLoungeVideoURL().bind { url in
            let status = MetaWorldSceneStatus.chattingLounge(tableID: tableID, loungeVideoURL: url)
            let metaWorldViewModel = MetaWorldViewModel(metaworldSceneStatus: status)
            let destinationViewController = MetaWorldViewController(viewModel: metaWorldViewModel)

            PushNotificationManager.globalNavigationRelay?.value?
                .presentViewController(viewController: destinationViewController,
                                       modalTransitionStyle: .crossDissolve,
                                       modalPresentationStyle: .fullScreen)
        }
        .disposed(by: disposeBag)
    }
}

// MARK: - Push Notification Setups
extension PushNotificationManager: MessagingDelegate {
    func setupFCM(_ delegate: AppDelegate, _ application: UIApplication) {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        let center = UNUserNotificationCenter.current()
        center.delegate = delegate
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { _, _ in
            // 1. APNs에 device token 등록 요청
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }

    func setAPNSToken(_ deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // note: API를 통해토큰 전달시 Messaging.messaging()를 통해 토큰을 전송하므로 별도의 처리는 진행하지 않음
    }
}
