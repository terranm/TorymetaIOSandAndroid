//
//  BottomTabBarManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/20.
//

import UIKit

final class BottomTabBarManager {

    private var tabBar: UITabBar?

    init(_ tabBar: UITabBar) {
        self.tabBar = tabBar
    }

    static func initBottomTabBar(_ backgroundColor: UIColor = .togetherWhite) {
        let appearance = UITabBar.appearance()
        appearance.shadowImage = UIImage()
        appearance.backgroundImage = UIImage()
        appearance.backgroundColor = backgroundColor
    }

    private func configure(_ shadowColor: UIColor = .togetherGray1,
                           _ shadowOpacity: Float = 0.3,
                           _ selectColor: UIColor = .togetherPurple,
                           _ unSelectColor: UIColor = .togetherGray3) {
        /*
         상단 그림자
         */
        tabBar?.layer.masksToBounds = false
        tabBar?.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar?.layer.shadowRadius = 1

        tabBar?.layer.shadowColor = shadowColor.cgColor
        tabBar?.layer.shadowOpacity = shadowOpacity

        /*
         Tap Color
         */
        tabBar?.tintColor = selectColor
        tabBar?.unselectedItemTintColor = unSelectColor
    }
}
