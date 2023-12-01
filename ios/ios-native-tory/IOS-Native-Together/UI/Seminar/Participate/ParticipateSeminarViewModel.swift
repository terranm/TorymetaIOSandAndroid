//
//  ParticipateSeminarViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import Foundation
import RxSwift
import RxCocoa

struct ParticiPateSeminarDto {

    let imgName: String
    let title: String
    let subTitle: String
    var description: String

    init() {
        self.imgName = ""
        self.title = ""
        self.subTitle = ""
        self.description = ""
    }

    init(imgName: String, title: String, subTitle: String, description: String) {
        self.imgName = imgName
        self.title = title
        self.subTitle = subTitle
        self.description = description
    }
}

final class ParticipateSeminarViewModel: RefactoringBaseViewModel {
    typealias AlertMsg = (title: String, message: String)
    var id: Int = 0

    let updatePageData = PublishRelay<Void>()
    let pageData = BehaviorRelay<SeminarDetailResultDto>(value: .init())
    var list: Driver<[ParticiPateSeminarDto]>?

    init(id: Int) {
        self.id = id

        list = pageData
            .map {
                var list: [ParticiPateSeminarDto] = [ParticiPateSeminarDto()]
                list.append(
                    ParticiPateSeminarDto(
                        imgName: R.image.seminar_name_indicator.name,
                        title: localizable.participateSeminarName(),
                        subTitle: "",
                        description: "\($0.title)"
                    )
                )

                if !$0.description.isEmpty {
                    list.append(
                        ParticiPateSeminarDto(
                            imgName: R.image.seminar_description_indicator.name,
                            title: localizable.participateSeminarDesc(),
                            subTitle: "",
                            description: "\($0.description)"
                        )
                    )
                }
                list.append(
                    ParticiPateSeminarDto(
                        imgName: R.image.seminar_teacher_indicator.name,
                        title: localizable.participateSeminarTeacher(),
                        subTitle: "",
                        description: "\($0.teacherName)"
                    )
                )
                list.append(
                    ParticiPateSeminarDto(
                        imgName: R.image.seminar_time_indicator.name,
                        title: localizable.participateSeminarPlan(),
                        subTitle: "",
                        description: "\($0.dateStr)"
                    )
                )
                list.append(
                    ParticiPateSeminarDto(
                        imgName: R.image.seminar_Participants_indicator.name,
                        title: localizable.participateSeminarAudience(),
                        subTitle: localizable.participateSeminarAdmit(),
                        description: "\($0.participationCount)/\($0.maxEnterCount)"
                    )
                )
                return list
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
