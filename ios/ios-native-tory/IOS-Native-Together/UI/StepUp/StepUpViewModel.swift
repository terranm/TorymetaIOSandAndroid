//
//  StepUpViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/08.
//

import UIKit
import RxSwift
import RxCocoa

final class StepUpViewModel: RefactoringBaseViewModel {

    enum State: Int {
        case checkIn  = 0
        case checkOut = 1
    }

    /*
     logic을 위한 sequence
     */
//    let canStep = PublishRelay<Void>()
//    let isLocationCheckIn = BehaviorRelay<Bool>(value: false)
//    let checkInCounting = BehaviorRelay<Int>(value: 0)
//    let checkOutCounting = BehaviorRelay<Int>(value: 0)

    /*
     UI Data
     */
    let checkInOutUistate = BehaviorRelay<State>(value: .checkIn)
    var countingMax: Driver<Int>! = nil
    var stepImage: Driver<UIImage?>! = nil
    var stepColor: Driver<UIColor>! = nil
    var stepCounting = BehaviorRelay<Int>(value: 0)

    let checkInList = BehaviorRelay<[StepUpPageDto.PaymentItem]>(value: [])
    let checkOutList = BehaviorRelay<[StepUpPageDto.PaymentItem]>(value: [])
    var payList: Driver<[StepUpPageDto.PaymentItem]>! = nil
    let paymentButtonTap = PublishRelay<StepUpPageDto.PaymentItem>()
    let stepUpCondition = BehaviorRelay<StepUpPageDto>(value: .init())

    init(canStep: Observable<Void>) {
        super.init()
        stepUpCondition
            .map { $0.checkInPaymentList }
//            .map {
//                var newItems = $0
//                newItems.insert(StepUpPageDto.PaymentItem(), at: 0)
//                return newItems
//            }
            .bind(to: checkInList)
            .disposed(by: disposeBag)

        stepUpCondition
            .map { $0.checkOutPaymentList }
//            .map {
//                var newItems = $0
//                newItems.insert(StepUpPageDto.PaymentItem(), at: 0)
//                return newItems
//            }
            .bind(to: checkOutList)
            .disposed(by: disposeBag)

        countingMax = checkInOutUistate
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Int>.empty() }
                switch $0 {
                case.checkIn:
                    return self.stepUpCondition.map {
                        $0.checkInMaxStepCount
                    }
                case.checkOut:
                    return self.stepUpCondition.map {
                        $0.checkOutMaxStepCount
                    }
                }
            }
            .asDriver(onErrorDriveWith: .empty())

        stepImage = checkInOutUistate
            .map { $0 == .checkIn ? R.image.step_purple() : R.image.step_yellow() }
            .asDriver(onErrorDriveWith: .empty())

        stepColor = checkInOutUistate
            .map { $0 == .checkIn ? UIColor.togetherPurple : UIColor.togetherYellow }
            .asDriver(onErrorDriveWith: .empty())

        Observable
            .combineLatest(checkInOutUistate.asObservable(), canStep) {
                ($0, $1)
            }
            .filter {  $0.0 == .checkIn ? true : false }
            .map { [weak self] _ in
                guard let self = self else { return 0 }
                return self.userDefaultManager.checkInCount
            }
            .bind(to: stepCounting)
            .disposed(by: disposeBag)

//        Observable
//            .combineLatest(
//                stepUpManager.checkInCount.asObservable(),
//                checkInOutUistate.asObservable(),
//                countingMax.asObservable()
//            ) {
//                ($0, $1, $2)
//            }
//            .filter {
//                switch $0.1 {
//                case.check_in: return true
//                case.check_out: return false
//                }
//            }
//            .map {
//                $0.0
//            }
//            .bind(to: stepCounting)
//            .disposed(by: disposeBag)

        Observable
            .combineLatest(checkInOutUistate.asObservable(), canStep) {
                ($0, $1)
            }
            .filter { $0.0 == .checkIn ? false : true }
            .map { [weak self] _ in
                guard let self = self else { return 0 }
                return self.userDefaultManager.checkOutCount
            }
            .bind(to: stepCounting)
            .disposed(by: disposeBag)

//        Observable
//            .combineLatest(
//                stepUpManager.checkOutCount.asObservable(),
//                checkInOutUistate.asObservable(),
//                countingMax.asObservable()
//            ) {
//                ($0, $1, $2)
//            }
//            .filter {
//                switch $0.1 {
//                case.check_in: return false
//                case.check_out: return true
//                }
//            }
//            .map {
//                $0.0
//            }
//            .bind(to: stepCounting)
//            .disposed(by: disposeBag)

//        checkInOutUistate
//            .flatMap {
//                switch $0 {
//                case.check_in:
//                    return stepUpManager.checkInCount
//                case.check_out:
//                    return stepUpManager.checkOutCount
//                }
//            }
//            .bind(to: stepCounting)
//            .disposed(by: disposeBag)

        payList = checkInOutUistate
            .flatMap { [weak self] state -> Observable<[StepUpPageDto.PaymentItem]> in
                guard let self = self else { return Observable<[StepUpPageDto.PaymentItem]>.empty() }
                return state  == .checkIn ? self.checkInList.asObservable() : self.checkOutList.asObservable()
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[StepUpPageDto.PaymentItem]>.empty() }
                return Observable.combineLatest(
                    Observable<[StepUpPageDto.PaymentItem]>.just($0),
                    self.stepCounting.asObservable()) { lists, counting in
                        lists.map {
                            StepUpPageDto.PaymentItem(
                                key: $0.key,
                                assetImageName: $0.assetImageName,
                                stepCount: $0.stepCount,
                                paymentMileage: $0.paymentMileage,
                                isPayment: $0.isPayment,
                                isGet: counting >= $0.stepCount
                        )
                    }
                }
            }
            .asDriver(onErrorDriveWith: .empty())

        paymentButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                let isCheckIn = self.checkInOutUistate.value == .checkIn ? true : false
                return self.repository.reqStepUpPaymentMileage($0.paymentMileage, $0.key, isCheckIn)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}
