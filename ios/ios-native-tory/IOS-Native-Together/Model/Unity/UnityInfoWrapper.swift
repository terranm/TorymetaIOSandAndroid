//
//  UnityInfoWrapperWrapper.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/08/11.
//

import Foundation

struct UnityInfoWrapper<T: Codable>: Codable {
    let type: String
    let value: T?

    init(functionName: UnityCallFunctionName, value: T? = nil) {
        self.type = functionName.key
        self.value = value
    }
}

struct FromUnityEmpty: Codable {
}
