//
//  AppContext.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit
import RxSwift
import RxCocoa
/*
 AppDelegate에서 단 하나만 생성하도록 하자
 App Life cycle 시작과 끝을 담당하는 객체다 (앱 전체의 전역을 담당한다.)
 */
class AppContext {
    let judgeViewController = BehaviorRelay<UIViewController?>(value: nil)
}
