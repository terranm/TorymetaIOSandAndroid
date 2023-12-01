//
//  UIViewController+extension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/10.
//

import Foundation
import PanModal

// MARK: - 화면 전환에 대한 로직....
extension UIViewController {

    func pushViewController(viewController: UIViewController,
                            title: String = "",
                            backgroundColor: UIColor = .togetherWhite) {
        viewController.view.backgroundColor = backgroundColor
        viewController.hidesBottomBarWhenPushed = true
        viewController.title = title
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func presentViewController(viewController: UIViewController,
                               modalTransitionStyle: UIModalTransitionStyle,
                               modalPresentationStyle: UIModalPresentationStyle,
                               backgroundColor: UIColor = .togetherWhite) {
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        viewController.view.backgroundColor = backgroundColor

        self.present(viewController, animated: true)
    }

    func presentNavigationViewController(viewController: UIViewController,
                                         title: String = "",
                                         modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                                         modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                                         backgroundColor: UIColor = .togetherWhite) {
        let viewController = UINavigationController(rootViewController: viewController)
        viewController.navigationBar.topItem?.title = title
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        viewController.view.backgroundColor = backgroundColor

        self.present(viewController, animated: true)
    }

    func presentPanmodal(panModel: UIViewController & PanModalPresentable, backgroundColor: UIColor) {
        panModel.view.backgroundColor = backgroundColor
        panModel.modalPresentationStyle = .custom
        panModel.modalPresentationCapturesStatusBarAppearance = true
        panModel.transitioningDelegate = PanModalPresentationDelegate.default
        self.present(panModel, animated: true)
    }

    func changeRootViewController(viewController: UIViewController,
                                  modalTransitionStyle: UIModalTransitionStyle = .crossDissolve,
                                  modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                                  backgroundColor: UIColor = .togetherWhite) {
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        viewController.view.backgroundColor = backgroundColor

        if let confirmVc = viewController as? UINavigationController {
            print("잘못된 화면 전환 \(confirmVc.className)")
        } else {
            self.window?.rootViewController = nil
            self.window?.rootViewController = UINavigationController(rootViewController: viewController)
            self.window?.makeKeyAndVisible()
        }
    }

    func showIOSSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
