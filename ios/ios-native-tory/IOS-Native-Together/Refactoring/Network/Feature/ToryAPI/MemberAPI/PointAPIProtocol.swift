//
//  MemberPointAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import RxSwift
import RxCocoa

extension PointAPIProtocol {
    func isToryCharging(receipt: String) -> Observable<InAppPurchaseResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/point/charge/ios",
                                                   params: ["receiptData": receipt],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)

        return CommonRESTfulAPIService<ToryAPIResultWrapper<InAppPurchaseResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<InAppPurchaseResultDto>.empty()
            }
    }

    func getPoint() -> Observable<PointResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/point",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)

        return CommonRESTfulAPIService<ToryAPIResultWrapper<PointResultDto>>(requestContext: requestContext)
            .getMapping()
            .catch { _ in
                Observable<PointResultDto>.empty()
            }
    }

    /*
     토리 충전 내역
     */
    func getToryChargeHistoryList(period: PointHistoryPeriod, page: Int, lenth: Int)
    -> Observable<PointChargingHistoryListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/point/charge",
                                                   params: ["length": lenth,
                                                            "page": page,
                                                            "period": period.rawValue],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<PointChargingHistoryListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(PointChargingHistoryListResultDto(chargeHistoryList: []))
    }

    /*
     토리 거래내역
     */
    func getToryTransactionHistoryList(period: PointHistoryPeriod, page: Int, lenth: Int)
    -> Observable<PointTransactionListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/point/history",
                                                   params: ["length": lenth,
                                                            "page": page,
                                                            "period": period.rawValue],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<PointTransactionListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(PointTransactionListResultDto(historyList: []))
    }

    /*
     마일리지 거래내역
     */
    func getMileageTransactionHistoryList(period: PointHistoryPeriod, page: Int, lenth: Int)
    -> Observable<PointTransactionListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/mileage/history",
                                                   params: ["length": lenth,
                                                            "page": page,
                                                            "period": period.rawValue],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<PointTransactionListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(PointTransactionListResultDto(historyList: []))
    }
}
