//
//  ChatInviteFriendDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import Foundation

struct ChatInviteFriendDto: Equatable, Hashable {
    let memberId: Int
    let profileImgUrl: String
    let nickName: String
    var isSelect: Bool

    static func == (lhs: ChatInviteFriendDto, rhs: ChatInviteFriendDto) -> Bool {
        return lhs.memberId == rhs.memberId
    }

    func hash(into hasher: inout Hasher) {
        return hasher.combine(self.memberId)
    }
}
