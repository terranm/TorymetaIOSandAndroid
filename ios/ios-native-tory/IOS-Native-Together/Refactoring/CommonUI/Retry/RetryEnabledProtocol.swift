//
//  RetryEnabledProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/10/04.
//

import UIKit

protocol RetryEnabledProtocol {
    var retryContainerView: UIView { get }
    func processRetry()
}
