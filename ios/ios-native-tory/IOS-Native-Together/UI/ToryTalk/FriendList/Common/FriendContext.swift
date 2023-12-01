//
//  FriendContext.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/02.
//

import Foundation

enum FriendType: Int {
    case new = 1
    case reqeust = 2
    case rangeIn = 3
    case rangeOut = 4
    case block = 5
//    case marketing = 6
}

struct FriendContext {
    /*
     friendList에서 사용
     */
    static func getType(section: Int) -> FriendType? {
        switch section {
        case 0:
            return FriendType.new
        case 1:
            return FriendType.reqeust
        case 2:
            return FriendType.rangeIn
        case 3:
            return FriendType.rangeOut
//        case 4:
//            return FriendType.marketing
        default: return nil
        }
    }

    static func getTypeName(type: FriendType?) -> String {
        switch type {
        case .new:
            return localizable.friendContextNew()
        case .reqeust:
            return localizable.friendContextRequest()
        case .rangeIn:
            return localizable.friendContextIntCampus()
        case .rangeOut:
            return localizable.friendContextUnknownLoc()
//        case .marketing:
//            return "연락처 목록"
        case .block:
            return localizable.friendContextBlocked()
        default: return ""
        }
    }

    static func getEmptyText(section: Int) -> String {
        let type = getType(section: section)
        return getEmptyText(type: type)
    }

    static func getEmptyText(type: FriendType?) -> String {
        switch type {
        case .new:
            return localizable.friendContextNoNew()
        case .reqeust:
            return localizable.friendContextNoReqeust()
        case .rangeIn:
            return localizable.friendContextNoInCampu()
        case .rangeOut:
            return localizable.friendContextNoInUknowLoc()
        case .block:
            return localizable.friendContextNoInBlock()
//        case .marketing:
//            return "연락처 친구 목록이 없습니다."
        default: return ""
        }
    }
}
