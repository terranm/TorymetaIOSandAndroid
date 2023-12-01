//
//  FromUnityRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/21.
//

import Foundation
import RxSwift
import RxCocoa

extension FromUnityRepositoryProtocol {

    func getChattingLoungeParticipantsInfo(data: FromUnityParticipantsInformation)
    -> Observable<FromUnityParticipantsInformation> {
        let diffCnt = (data.maxClient ?? data.list.count) - data.list.count
        var newList: [FromUnityParticipantsInformation.Item] = []
        newList += data.list
        for _ in 0..<diffCnt {
            newList.append(FromUnityParticipantsInformation.Item())
        }
        let result = FromUnityParticipantsInformation(roomId: data.roomId,
                                                      tableId: data.tableId,
                                                      maxClient: data.maxClient,
                                                      chatRoomId: data.chatRoomId,
                                                      list: newList)
        return Observable.just(result)
    }
}
