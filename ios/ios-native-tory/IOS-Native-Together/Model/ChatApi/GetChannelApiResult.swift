//
//  GetChannelApiResult.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/26.
//

import Foundation

struct GetChannelApiResult: Codable {
    private let exist: String?
    var isExist: Bool? {
        switch exist {
        case "T": return true
        case "F": return false
        default: return nil
        }
    }

    let chid: Int?
    let chnm: String?
}

// 사진 및 동영상 촬영을 위해 카메라 접근 권한이 필요합니다.
