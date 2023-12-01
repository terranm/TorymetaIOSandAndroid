//
//  ToryWebJSONData.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/10.
//

import Foundation

struct ToryWebJSONData: Codable {
    let functionName: String?
    let token: String?
    let isAutoLogin: Bool?
    let universityCode: String?

    // chatting...
    let chid: Int?
    let memberId: Int? // board friendMemberId..
    let nickName: String?
    let profile: String?

    /*
     isModify
     */
    let modifyYn: String?
    var isModify: Bool {
        switch modifyYn {
        case "true": return true
        case "false": return false
        default: return true
        }
    }
}
