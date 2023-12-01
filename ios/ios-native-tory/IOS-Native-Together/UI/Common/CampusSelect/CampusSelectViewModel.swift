//
//  MyCampusSelectViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture

final class CampusSelectViewModel: RefactoringBaseViewModel {
    enum PageType {
        case confirm
        case change
    }
    var type: Driver<PageType>! = nil
    let university = BehaviorRelay<UniversityListResultDto.Item>(value: UniversityListResultDto.Item())
    var presntCampusName: Driver<String>! = nil

    let completeButtonTap = PublishRelay<UITapGestureRecognizer>()

    var presentModifyPage: Driver<(type: PageType, university: UniversityListResultDto.Item?)>! = nil

    init(type: PageType) {
        super.init()

        self.type = Driver.just(type)

        presntCampusName = university
            .filter {
                $0.universityName != ""
            }
            .map {
                $0.universityName
            }
            .asDriver(onErrorDriveWith: .empty())

        presentModifyPage = completeButtonTap
            .map { [weak self] _ in
                (type, self?.university.value)
            }
            .filter {
                $0.1?.universityCode != ""
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
