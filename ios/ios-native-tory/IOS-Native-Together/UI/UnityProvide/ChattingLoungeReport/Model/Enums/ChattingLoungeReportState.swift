//
//  ChattingLoungeReportState.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/18.
//

import Foundation

enum ChattingLoungeReportState {
    case reportRoom(_ chatRoomId: Int?)
    case reportUser(_ memeberId: Int?)
}
