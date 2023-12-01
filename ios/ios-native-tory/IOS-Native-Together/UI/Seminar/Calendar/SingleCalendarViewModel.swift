//
//  SingleCalendarViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import Foundation
import SwiftDate
import RxSwift
import RxCocoa

struct SingleCalendarDto {
    let title: String
    let teacher: String
    let dateStr: String
}

final class SingleCalendarViewModel: RefactoringBaseViewModel {

    let date = BehaviorRelay<Date>(value: Date())

    var list: Driver<[LiveSeminarListResultDto.Item]>?

    override init() {
        super.init()

        list = date
            .map {
                $0.dateToString(format: "yyyyMMdd")
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[LiveSeminarListResultDto.Item]>.empty() }
                return self.repository.getSingleScheduleList(date: $0)
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
