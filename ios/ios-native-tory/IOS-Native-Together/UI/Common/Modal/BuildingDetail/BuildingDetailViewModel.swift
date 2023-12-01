//
//  BuildingDetailViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/20.
//

import Foundation
import RxSwift
import RxCocoa

final class BuildingDetailViewModel: RefactoringBaseViewModel {
    var detailData: Driver<BuildingMarkerDetailResultDto>?

    init(markerID: Int) {
        super.init()
        detailData = repository.getBuildingMakrerDetail(markerId: markerID)
            .asDriver(onErrorDriveWith: .empty())
    }
}
