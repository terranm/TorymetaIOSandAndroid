//
//  ChatPreview.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/10/31.
//

import Foundation

struct ChatPreView {
    let channelId: Int
    let profileImageUrl: String
    let nickName: String
    var messagePreview: String
    var time: String
    var messageCount: Int

    let memberCount: Int

    init(channelId: Int,
         profileImageUrl: String,
         nickName: String,
         messagePreview: String,
         time: String,
         messageCount: Int,
         memberCount: Int) {
        self.channelId = channelId
        self.profileImageUrl = profileImageUrl
        self.nickName = nickName
        self.messagePreview = messagePreview
        self.time = time
        self.messageCount = messageCount
        self.memberCount = memberCount
    }

    init() {
        self.channelId = 0
        self.profileImageUrl = ""
        self.nickName = ""
        self.messagePreview = ""
        self.time = ""
        self.messageCount = 0
        self.memberCount = 0
    }
}
