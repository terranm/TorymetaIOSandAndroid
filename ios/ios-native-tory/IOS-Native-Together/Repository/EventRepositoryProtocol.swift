//
//  EventRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa

extension EventRepositoryProtocol {
    func getEventBannerList() -> Observable<[EventBannerListResultDto.Item]> {
        memberAPI.getEventBannerList()
            .map { $0.list }
    }
    /*
     캠퍼스 뚜벅이
     */
    func getStepUpCondition() -> Observable<StepUpPageDto> {
        memberAPI.getStepUpCondition()
            .map { condition in
                var checkInPaymentList = condition.stepCondition.map {
                    StepUpPageDto.PaymentItem(key: $0.key,
                                              assetImageName: R.image.step_purple_circle.name,
                                              stepCount: $0.stepCount,
                                              paymentMileage: Int(Double($0.stepCount) * condition.insideRatio),
                                              isPayment: false,
                                              isGet: false)
                }
                for index in condition.inStepYnArr.indices {
                    let isPayment = condition.inStepYnArr[index] == "Y" ? true : false
                    checkInPaymentList[index].isPayment = isPayment
                }
                var checkOutPaymentList = condition.stepCondition.map {
                    StepUpPageDto.PaymentItem(key: $0.key,
                                              assetImageName: R.image.step_yellow_circle.name,
                                              stepCount: $0.stepCount,
                                              paymentMileage: Int(Double($0.stepCount) * condition.outsideRatio),
                                              isPayment: false,
                                              isGet: false)
                }
                for index in condition.outStepYnArr.indices {
                    let isPayment = condition.outStepYnArr[index] == "Y" ? true : false
                    checkOutPaymentList[index].isPayment = isPayment
                }
                return StepUpPageDto(checkInMaxStepCount: condition.maxInsideStep,
                                     checkOutMaxStepCount: condition.maxOutsideStep,
                                     checkInPaymentList: checkInPaymentList,
                                     checkOutPaymentList: checkOutPaymentList)
            }
    }
    /*
     캠퍼스 뚜벅이 마일리지 요청하기
     */
    func reqStepUpPaymentMileage(_ mileage: Int,
                                 _ key: String,
                                 _ isCheckIn: Bool) -> Observable<Bool> {
        memberAPI.reqStepUpPaymentMileage(key, isCheckIn)
            .map { [weak self] in
                guard let self = self else { return false }
                /*
                 point Update....
                 */
                var newPoint = self.repositoryModel.point.value
                newPoint.mileage += mileage
                self.repositoryModel.point.accept(newPoint)
                return $0.isSuccess
            }
    }
}
