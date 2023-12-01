//
//  MileagePointTransactionHistoryViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/11/09.
//

import Foundation
import RxSwift
import RxCocoa

final class MileagePointTransactionHistoryViewModel: RefactoringBaseViewModel {
    var mileagePoint: Driver<String>! = nil
    let filterItems = BehaviorRelay<[PointFilterDto]>(value: [
        .init(filterName: localizable.toryChargingHistoryOneWeek(), filterCode: .week, isSelect: false),
        .init(filterName: localizable.toryChargingHistoryOneMonth(), filterCode: .month1, isSelect: true),
        .init(filterName: localizable.toryChargingHistorySixMonths(), filterCode: .month6, isSelect: false),
        .init(filterName: localizable.toryChargingHistoryOneYear(), filterCode: .year, isSelect: false),
        .init(filterName: localizable.toryChargingHistoryAll(), filterCode: .all, isSelect: false)
    ])

    let currentFilter = BehaviorRelay<PointFilterDto>(value: .init())

    var historyItems = BehaviorRelay<[PointTransactionListResultDto.Item]>(value: [])

    let filterButtonTap = PublishRelay<Int>()

    /*
     isPaging
     */
    let paging = PublishRelay<Bool>()

    let pageSize = 10
    let currentPage = BehaviorRelay<Int>(value: 0)
    let isLastPage = BehaviorRelay<Bool>(value: false)

    override init() {
        super.init()

        self.mileagePoint = repository.point
            .map {
                WDHelper.numberToNumberSeparator($0.mileage) + " M"
            }
            .asDriver(onErrorDriveWith: .empty())

        filterItems
            .map {
                $0.filter {
                    $0.isSelect
                }
            }
            .filter { !$0.isEmpty }
            .map { $0[0] }
            .bind(to: currentFilter)
            .disposed(by: disposeBag)

        currentFilter
            .filter { $0.filterName != "" }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[PointTransactionListResultDto.Item]>.empty() }
                return self.repository.getMileageTransactionHistoryList(period: $0.filterCode,
                                                            page: self.currentPage.value,
                                                            lenth: self.pageSize)
            }
            .bind(to: historyItems)
            .disposed(by: disposeBag)

        paging
            .filter { $0 }
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return !self.isLastPage.value
            }
            .flatMap { [weak self] _ -> Observable<Int> in
                guard let self = self else { return Observable<Int>.empty() }
                var currentPage = self.currentPage.value
                currentPage += 1
                self.currentPage.accept(currentPage)
                return Observable.just(currentPage)
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[PointTransactionListResultDto.Item]>.empty() }
                return self.repository.getMileageTransactionHistoryList(period: self.currentFilter.value.filterCode,
                                                            page: $0,
                                                            lenth: self.pageSize)
            }
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if $0.count < self.pageSize {
                    self.isLastPage.accept(true)
                }

                var items = self.historyItems.value
                if !$0.isEmpty {
                    items += $0
                    self.historyItems.accept(items)
                }
            })
            .disposed(by: disposeBag)
    }
}
