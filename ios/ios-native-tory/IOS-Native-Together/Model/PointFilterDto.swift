//
//  PointFilterDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/16.
//

import Foundation

struct PointFilterDto {
    let filterName: String
    let filterCode: PointHistoryPeriod
    var isSelect: Bool

    init() {
        self.filterName = ""
        self.filterCode = .week
        self.isSelect = false
    }

    init(filterName: String, filterCode: PointHistoryPeriod, isSelect: Bool) {
        self.filterName = filterName
        self.filterCode = filterCode
        self.isSelect = isSelect
    }
}
