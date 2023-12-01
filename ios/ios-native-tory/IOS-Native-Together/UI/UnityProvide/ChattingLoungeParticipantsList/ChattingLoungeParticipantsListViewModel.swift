//
//  ChattingLoungeParticipantsListViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import Foundation
import RxSwift
import RxCocoa

struct ChattingLoungeParticipants {
    let list: [Item]
    let allCnt: Int
    let participageCnt: Int

    struct Item {
        let memeberId: Int
        let status: ChattingLoungeParticipantsItemStatus
        let profileURL: String
        let nickName: String
        let isOwner: Bool
    }
}

final class ChattingLoungeParticipantsListViewModel: RefactoringBaseViewModel {
    private let participantsInfo: FromUnityParticipantsInformation
    let pageData = BehaviorRelay<FromUnityParticipantsInformation>(value: .init(roomId: "",
                                                                                tableId: "",
                                                                                maxClient: 0,
                                                                                chatRoomId: 0,
                                                                                list: []))
    let requestButtonTap = PublishRelay<ChattingLoungeParticipantsItemStatus>()

    init(participantsInfo: FromUnityParticipantsInformation) {
        self.participantsInfo = participantsInfo
        super.init()
    }

    func header() -> Driver<String> {
        pageData.map {
            let substantialList = $0.list.filter {
                $0.status == .exist
            }
            return "(\(substantialList.count)/\($0.maxClient ?? $0.list.count))"
        }
        .asDriver(onErrorDriveWith: .empty())
    }

    func participantsList() -> Driver<FromUnityParticipantsInformation> {
        repository.getChattingLoungeParticipantsInfo(data: participantsInfo)
            .asDriver(onErrorDriveWith: .empty())
    }

    func getParticipantsCount() -> Int {
        pageData.value.list.count
    }

    func requestButtonTapWithUnityFunctionCall() -> Signal<ChattingLoungeParticipantsItemStatus> {
        requestButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }
}
