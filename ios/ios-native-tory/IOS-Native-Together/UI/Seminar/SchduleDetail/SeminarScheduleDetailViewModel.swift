//
//  SeminarScheduleDetailViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/02.
//

import Foundation
import RxSwift
import RxCocoa

final class SeminarScheduleDetailViewModel: RefactoringBaseViewModel {
    var id: Int = 0
    let pageData = BehaviorRelay<SeminarDetailResultDto>(value: .init())

    var isLock: Driver<Bool>! = nil
    /*
     tag
     */
    var seminarTag: Driver<SeminarTagState>?

    var thumbnail: Driver<URL?>?

    var list: Driver<[ParticiPateSeminarDto]>?

    init(id: Int) {
        self.id = id
        super.init()

        isLock = pageData
            .map { $0.isSecret }
            .asDriver(onErrorDriveWith: .empty())

        seminarTag = pageData
            .map { $0.tagState }
            .asDriver(onErrorDriveWith: .empty())

        thumbnail = pageData
            .map { $0.roomImageUrl }
            .map { URL(string: $0) }
            .asDriver(onErrorDriveWith: .empty())

        list = pageData
            .map {
                var list: [ParticiPateSeminarDto] = [ParticiPateSeminarDto()]
                    list.append(
                        ParticiPateSeminarDto(
                            imgName: R.image.seminar_name_indicator.name,
                            title: localizable.seminarScheduleDetailSeminarName(),
                            subTitle: "",
                            description: "\($0.title)"
                        )
                    )

                    if !$0.description.isEmpty {
                        list.append(
                            ParticiPateSeminarDto(
                                imgName: R.image.seminar_description_indicator.name,
                                title: localizable.seminarScheduleDetailSeminarDesc(),
                                subTitle: "",
                                description: "\($0.description)"
                            )
                        )
                    }
                    list.append(
                        ParticiPateSeminarDto(
                            imgName: R.image.seminar_teacher_indicator.name,
                            title: localizable.seminarScheduleDetailTeacherName(),
                            subTitle: "",
                            description: "\($0.teacherName)"
                        )
                    )
                    list.append(
                        ParticiPateSeminarDto(
                            imgName: R.image.seminar_time_indicator.name,
                            title: localizable.seminarScheduleDetailSeminarPlan(),
                            subTitle: "",
                            description: "\($0.dateStr)"
                        )
                    )
                    list.append(
                        ParticiPateSeminarDto(
                            imgName: R.image.seminar_Participants_indicator.name,
                            title: localizable.seminarScheduleDetailApply(),
                            subTitle: localizable.seminarScheduleDetailAdmitDesc(),
                            description: "\($0.participationCount)/\($0.maxEnterCount)"
                        )
                    )

                return list
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
