//
//  TTCAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/18.
//

import Foundation
import RxSwift
import RxCocoa

extension TTCAPIProtocol {
    func requestTTCLogin(userId: String, password: String) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/ttc-login",
                                                   params: ["mbId": userId,
                                                            "passwd": password],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func getTTCLectureList(_ offset: Int) -> Observable<TTCLectureList> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/api",
                                                   params: ["offset": offset],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .validation)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<TTCLectureList>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<TTCLectureList>.empty()
            }
    }

    func getTTCLectureSubList(params: TTCLectureSubRequestParams)
    -> Observable<TTCLectureSubList> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/api-sub",
                                                   params: ["wrId": params.wrId,
                                                            "lecId": params.lecId],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<TTCLectureSubList>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<TTCLectureSubList>.empty()
            }
    }

    func getTTCPlayerInformation(params: TTCPlayerInformationRequestParams)
    -> Observable<TTCLecturePlayerInformation> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/api-player",
                                                   params: ["applyId": params.applyId,
                                                            "lecId": params.lecId,
                                                            "wrOrder": params.wrOrder],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<TTCLecturePlayerInformation>>(requestContext:
                                                                                            requestContext)
            .postMapping()
            .catch { _ in
                Observable<TTCLecturePlayerInformation>.empty()
            }
    }

    func updateTTCLecturePosition(params: TTCUpdateLectureRequestParams)
    -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/api-update-position",
                                                   params: ["applyId": params.applyId,
                                                            "lecId": params.lecId,
                                                            "wrOrder": params.wrOrder,
                                                            "lmsTimeId": params.lmsTimeId,
                                                            "isStudied": params.isStudied,
                                                            "contentTime": params.contentTime,
                                                            "curpos": params.curpos],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func updateTTCLectureEnd(params: TTCUpdateLectureEndParams) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/api-update-end",
                                                   params: ["applyId": params.applyId,
                                                            "lecId": params.lecId,
                                                            "wrOrder": params.wrOrder,
                                                            "lmsTimeId": params.lmsTimeId,
                                                            "isStudied": params.isStudied,
                                                            "endCk": params.endCk,
                                                            "time": params.time,
                                                            "contentTime": params.contentTime],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }
}
