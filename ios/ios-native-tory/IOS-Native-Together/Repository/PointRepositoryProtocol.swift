//
//  PointRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa

extension PointRepositoryProtocol {
    /*
     토리포인트 리스트
     */
    func getToryTransactionHistoryList(period: PointHistoryPeriod,
                                       page: Int,
                                       lenth: Int) -> Observable<[PointTransactionListResultDto.Item]> {
        memberAPI.getToryTransactionHistoryList(period: period, page: page, lenth: lenth)
            .map { $0.historyList }
    }
    /*
     마일리지 리스트
     */
    func getMileageTransactionHistoryList(period: PointHistoryPeriod,
                                          page: Int,
                                          lenth: Int) -> Observable<[PointTransactionListResultDto.Item]> {
        memberAPI.getMileageTransactionHistoryList(period: period, page: page, lenth: lenth)
            .map { $0.historyList }
    }

    /*
     충전내역 리스트
     */
    func getToryPointChargeHistoryList(period: PointHistoryPeriod,
                                       page: Int,
                                       lenth: Int) -> Observable<[PointChargingHistoryListResultDto.Item]> {
        memberAPI.getToryChargeHistoryList(period: period, page: page, lenth: lenth)
            .map { $0.chargeHistoryList }
    }
}
