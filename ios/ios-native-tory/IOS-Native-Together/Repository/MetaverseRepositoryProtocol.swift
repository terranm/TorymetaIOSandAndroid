//
//  MetaverseRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/21.
//

import Foundation
import RxSwift
import RxCocoa

extension MetaverseRepositoryProtocol {

    func getChattingLoungeChattingRoomList(selectOption: ChattingLoungeChattingListStatus)
    -> Observable<[ChattingLoungeChattingRoomList.Item]> {
        metaverseAPI.getChattingLoungeChattingRoomList()
            .flatMap {
                let list = $0.rooms
                switch selectOption {
                case .all:
                    return Observable.just(list)
                case .participate:
                    let result = list.filter { !$0.isRoomLock }
                    return Observable.just(result)
                case .open:
                    let result = list.filter { !$0.isSecret }
                    return Observable.just(result)
                case .secret:
                    let result = list.filter { $0.isSecret }
                    return Observable.just(result)
                }
            }
    }

    func getChattingLoungeChattingRoomList(detailSelectOption: ChattingLoungeDetailOptionStatus)
    -> Observable<[ChattingLoungeChattingRoomList.Item]> {
        metaverseAPI.getChattingLoungeChattingRoomList()
            .flatMap {
                let list = $0.rooms
                switch detailSelectOption {
                case .all:
                    return Observable.just(list)
                case .open:
                    let result = list.filter { !$0.isSecret }
                    return Observable.just(result)
                case .secret:
                    let result = list.filter { $0.isSecret }
                    return Observable.just(result)
                }
            }
    }
}
