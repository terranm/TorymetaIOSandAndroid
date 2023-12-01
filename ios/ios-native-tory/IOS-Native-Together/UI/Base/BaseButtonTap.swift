//
//  BaseButtonTap.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/05.
//

import UIKit
import RxSwift
import RxGesture

extension Reactive where Base: UIView {
    public func baseTapGesture(configuration: TapConfiguration? = nil) -> Observable<Void> {
        return base.rx.tapGesture()
            .when(.recognized)
            .flatMapLatest { _ -> Observable<Void> in
                /*
                 ButtonTap에 대한 공통부분 처리
                 */
                print("Common Button Tap...")
                return Observable.just(())
            }
    }
}
