//
//  ToryboardAPIService.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/26.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

/*
 https://web.torymeta.com/bbs/v1 관련 API
 */

struct BoardAPI {
    static let shared = BoardAPI()
    private init() {}

    func getMyWriteList() -> Observable<MyWriteListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .board,
                                                   path: "/mythread",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<MyWriteListResultDto>>(requestContext: requestContext)
            .postMapping()
            .catchAndReturn(MyWriteListResultDto(list: []))
    }

    func getMyCommentList() -> Observable<MyCommentListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .board,
                                                   path: "/mycmnt",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<MyCommentListResultDto>>(requestContext: requestContext)
            .postMapping()
            .catchAndReturn(MyCommentListResultDto(list: []))
    }
}
