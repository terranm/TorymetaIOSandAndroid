//
//  OtherUserStatusChange.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/31.
//

import Foundation

enum UpdateFriendStateInteractionCase {
    case locationBlock(_ data: RangeFriendInfo)
    case locationUnBlock(_ data: RangeFriendInfo)

    case friendBlock(_ data: RangeFriendInfo)
    case friendUnBlock(_ data: BlockFriendInfo)

    case friendAccept(_ data: FriendInfo)
    case friendUnAccept(_ data: FriendInfo)
    case friendRequest(_ data: FriendInfo)
    case friendDelete(_ data: RangeFriendInfo)
    case friendMarketing(_ data: FriendInfo)
}
