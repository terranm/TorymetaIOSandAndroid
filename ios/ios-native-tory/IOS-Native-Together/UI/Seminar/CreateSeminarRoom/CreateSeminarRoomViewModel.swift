//
//  CreateSeminarRoomViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/05.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftDate

struct SeminarRoomDto {
    let imgUrl: String
    let description: String
    var isSelect: Bool
}

final class CreateSeminarRoomViewModel: RefactoringBaseViewModel {

    static let NEW = -1
    var id: Int = CreateSeminarRoomViewModel.NEW
    var parentListUpdate: PublishRelay<Void>?

    let title = BehaviorRelay<String?>(value: "")
    let craeteDescription = BehaviorRelay<String?>(value: "")
    let teacher = BehaviorRelay<String?>(value: "")

    let startDate = BehaviorRelay<Date?>(value: Date())
    let endDate = BehaviorRelay<Date?>(value: Date())

    let urlPath = BehaviorRelay<String?>(value: "")

    let password = BehaviorRelay<String?>(value: "")

    /*
     0 -> ALL
     1 -> SMALL
     2 -> MIDDLE
     3 -> BIG
     */
    let roomTag = BehaviorRelay<Int>(value: 0)
    let seminarList = BehaviorRelay<[SeminarRoomTypeListResultDto.Item]>(value: [])

    let seminarCnt = BehaviorRelay<Int>(value: 0)

    let isOn = BehaviorRelay<Bool>(value: false)

    var completeStr: Driver<String>! = nil
    let completeButtonTap = PublishRelay<Void>()
    var presentCompleteButtonTap: Signal<Bool>! = nil
    /*
     0 -> New
     1 -> Modify
     */
    init(id: Int, parentListUpdate: PublishRelay<Void>? = nil) {
        self.id = id
        self.parentListUpdate = parentListUpdate
        super.init()

        completeStr = Driver<String>.just("")
            .map { _ in
                if id != CreateSeminarRoomViewModel.NEW {
                    return localizable.createSeminarModify()
                } else {
                    return localizable.createSeminarOpen()
                }
            }

        presentCompleteButtonTap = completeButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                let seminarFilter = seminarList.value
                    .filter {
                        $0.isSelect
                    }[0]
                let title = title.value ?? ""
                let description = craeteDescription.value ?? ""
                let teacher = teacher.value ?? ""
                let startDate = startDate.value
                let endDate = endDate.value
                let urlPath = urlPath.value ?? ""
                let password = password.value ?? ""
                let isOn = isOn.value
                let seminarFilesId = 1
                let seminarCnt = seminarCnt.value

                if id == CreateSeminarRoomViewModel.NEW {
                    return repository.createSeminarRoom(params: CreateSeminarRoomParams(
                        roomId: seminarFilter.roomId,
                        title: title,
                        description: description,
                        teacherDescription: teacher,
                        startAt: startDate,
                        endAt: endDate,
                        seminarUrl: urlPath,
                        password: password,
                        isSecret: isOn,
                        maxEnterCount: seminarFilter.maxParticipation,
                        seminarFilesId: seminarFilesId,
                        createRoomCount: seminarCnt
                    ))
                } else {
                    return repository.updateCreateSeminarRoom(seminarId: id, params: CreateSeminarRoomParams(
                        roomId: seminarFilter.roomId,
                        title: title,
                        description: description,
                        teacherDescription: teacher,
                        startAt: startDate,
                        endAt: endDate,
                        seminarUrl: urlPath,
                        password: password,
                        isSecret: isOn,
                        maxEnterCount: seminarFilter.maxParticipation,
                        seminarFilesId: seminarFilesId,
                        createRoomCount: nil
                    ))
                }

            }
            .asSignal(onErrorSignalWith: .empty())
    }

    func isPossibleCompleteObservable() -> Observable<Bool> {
        if id == CreateSeminarRoomViewModel.NEW {
            return Observable.combineLatest(
                title,
                endDate,
                startDate,
                seminarList,
                seminarCnt
            ) { title, endDate, startDate, seminarList, seminarCnt in
                let diff = (endDate ?? Date()) - (startDate ?? Date())
                let equalDate = diff.in(.year) == 0 && diff.in(.month) == 0 && diff.in(.day) == 0 && diff.in(.hour) == 0 && diff.in(.minute) == 0
                let seminarFilter = seminarList
                    .filter {
                        $0.isSelect
                    }
                let seminarCnt = seminarCnt
                return title?.count ?? 0 > 0
                && !equalDate
                && !seminarFilter.isEmpty
                && seminarCnt > 0
            }
        } else {
            return Observable.combineLatest(
                title,
                endDate,
                startDate,
                seminarList
            ) { title, endDate, startDate, seminarList in
                let diff = (endDate ?? Date()) - (startDate ?? Date())
                let equalDate = diff.in(.year) == 0 && diff.in(.month) == 0 && diff.in(.day) == 0 && diff.in(.hour) == 0 && diff.in(.minute) == 0
                let seminarFilter = seminarList
                    .filter {
                        $0.isSelect
                    }
                return title?.count ?? 0 > 0
                && !equalDate
                && !seminarFilter.isEmpty
            }
        }

    }

    func isPossibleComplete() -> Bool {
        if id == CreateSeminarRoomViewModel.NEW {
            let diff = (endDate.value ?? Date()) - (startDate.value ?? Date())
            let equalDate = diff.in(.year) == 0 && diff.in(.month) == 0 && diff.in(.day) == 0 && diff.in(.hour) == 0 && diff.in(.minute) == 0
            let seminarFilter = seminarList.value
                .filter {
                    $0.isSelect
                }
            let seminarCnt = seminarCnt.value
            return title.value?.count ?? 0 > 0
            && !equalDate
            && !seminarFilter.isEmpty
            && seminarCnt > 0

        } else {
            let diff = (endDate.value ?? Date()) - (startDate.value ?? Date())
            let equalDate = diff.in(.year) == 0 && diff.in(.month) == 0 && diff.in(.day) == 0 && diff.in(.hour) == 0 && diff.in(.minute) == 0
            let seminarFilter = seminarList.value
                .filter {
                    $0.isSelect
                }
            return title.value?.count ?? 0 > 0
            && !equalDate
            && !seminarFilter.isEmpty
        }

    }

}

/*
 Unity -> IOS: 유니티 생명주기, BACK 2개만 있다. "String"
 IOS -> UInity
 */
