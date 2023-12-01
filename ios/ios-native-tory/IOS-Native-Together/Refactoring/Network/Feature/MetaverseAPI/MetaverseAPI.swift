//
//  MetaverseAPI.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/21.
//

import Foundation
import RxSwift
import RxCocoa

struct MetaverseAPI {
    static let shared = MetaverseAPI()
    private init() {}

    func getChattingLoungeChattingRoomList() -> Observable<ChattingLoungeChattingRoomList> {
        let requestContext = MetaverseRequestContext(path: "/room/list",
                                                     params: ["chatGroup": "chat_lounge",
                                                              "limit": "30"],
                                                     requestUIMode: .loading,
                                                     resultUIMode: .validation)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ChattingLoungeChattingRoomList>>(requestContext:
                                                                                                requestContext)
            .postMapping()
            .catchAndReturn(ChattingLoungeChattingRoomList(rooms: []))
    }
}
