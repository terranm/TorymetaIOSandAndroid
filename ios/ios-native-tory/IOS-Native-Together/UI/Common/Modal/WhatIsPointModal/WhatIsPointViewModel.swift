//
//  WhatIsPointViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/20.
//

import Foundation
import RxSwift
import RxCocoa

final class WhatIsPointViewModel: RefactoringBaseViewModel {
    var pageData: Driver<WhatIsPointDto>?

    init(pointStatus: PointStatus) {
        switch pointStatus {
        case .tory:
            let toryWhatIsPoint = WhatIsPointDto(header: localizable.myPageWhatIsTory(),
                                                 description: localizable.myPageWhatIsToryDesc())
            pageData = Driver.just(toryWhatIsPoint)
        case .mileage:
            let mileageWhatIsPoint = WhatIsPointDto(header: localizable.myPageWhatIsMileage(),
                                                    description: localizable.myPageWhatIsMileageDesc())
            pageData = Driver.just(mileageWhatIsPoint)
        }
    }

    func getHeader() -> Driver<String>? {
        pageData?.map {
            $0.header
        }
    }

    func getDescription() -> Driver<String>? {
        pageData?.map {
            $0.description
        }
    }
}
