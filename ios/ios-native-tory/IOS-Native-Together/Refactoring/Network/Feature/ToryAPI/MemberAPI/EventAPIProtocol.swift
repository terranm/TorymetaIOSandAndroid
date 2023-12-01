//
//  MemberEventAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import RxSwift
import RxCocoa

extension EventAPIProtocol {
    func getEventBannerList() -> Observable<EventBannerListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/event",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<EventBannerListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(EventBannerListResultDto(list: []))
    }

    /*
     캠퍼스 뚜벅이 page 데이터
     */
    func getStepUpCondition() -> Observable<StepUpResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/event/walk",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<StepUpResultDto>>(requestContext: requestContext)
            .getMapping()
            .catch { _ in
                Observable<StepUpResultDto>.empty()
            }
    }

    /*
     캠퍼스 뚜벅이 마일리지 요청
     */
    func reqStepUpPaymentMileage(_ key: String,
                                 _ isCheckIn: Bool) -> Observable<ReqResultDto> {
        let rangeYn: String = isCheckIn ? "Y" : "N"
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/event/walk",
                                                   params: ["conditionType": key,
                                                            "inRangeYn": rangeYn],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }
}
