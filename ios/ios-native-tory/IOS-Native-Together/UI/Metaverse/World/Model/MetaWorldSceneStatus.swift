//
//  MetaWorldSceneStatus.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/22.
//

import Foundation

enum MetaWorldSceneStatus {
    case university(uniCode: String)
    case chattingLounge(tableID: String, loungeVideoURL: String)
    case lobby(loungeVideoURL: String)
    case seminar(roomID: String, unitySeminarID: String, seminarURL: String, title: String, videoStartTime: String)
    case festival(loungeVideoURL: String)
}
