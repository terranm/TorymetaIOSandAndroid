//
//  ChattingLoungeChattingList.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/21.
//

import Foundation

struct ChattingLoungeChattingList {
    let list: [Item]

    struct Item {
        let id: Int
        let profileURL: String
        let titleName: String
        let nickName: String
        let allCnt: Int
        let participateCnt: Int
        let isSecret: Bool
        let isEntranceAble: Bool
    }
}
