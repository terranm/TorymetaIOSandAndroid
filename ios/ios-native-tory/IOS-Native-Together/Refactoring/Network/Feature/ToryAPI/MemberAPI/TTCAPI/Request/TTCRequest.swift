//
//  TTCRequest.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/18.
//

import Foundation

struct TTCLectureSubRequestParams {
    let wrId: Int
    let lecId: Int
}

struct TTCPlayerInformationRequestParams {
    let applyId: Int
    let lecId: Int
    let wrOrder: Int
}

struct TTCUpdateLectureRequestParams {
    let applyId: Int
    let lecId: Int
    let wrOrder: Int
    let lmsTimeId: Int
    let isStudied: Bool
    let contentTime: Double
    let curpos: Double
}

struct TTCUpdateLectureEndParams {
    let applyId: Int
    let lecId: Int
    let wrOrder: Int
    let lmsTimeId: Int
    let isStudied: Bool
    let endCk: String
    let time: Double
    let contentTime: Double
}
