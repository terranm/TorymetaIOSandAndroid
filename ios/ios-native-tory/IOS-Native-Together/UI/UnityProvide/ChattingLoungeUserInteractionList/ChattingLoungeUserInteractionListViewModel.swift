//
//  ChattingLoungeUserInteractionListViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/17.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeUserInteractionListViewModel: RefactoringBaseViewModel {
    let isHostAthority: Bool?
    let memberId: Int?

    private let list = BehaviorRelay<[ChattingLoungeUserInteraction]>(value: [])
    let interactionButtonTap = PublishRelay<ChattingLoungeUserInteractionState>()
    let requestFriendButtonTap = PublishRelay<Int>()

    init(isHostAthority: Bool?,
         memberId: Int?) {
        self.isHostAthority = isHostAthority
        self.memberId = memberId
        super.init()
    }

    func getList() -> Driver<[ChattingLoungeUserInteraction]> {
        var result: [ChattingLoungeUserInteraction] = []
        guard let isHostAthority = isHostAthority else { return Driver<[ChattingLoungeUserInteraction]>.empty() }
        if isHostAthority {
            result.append(ChattingLoungeUserInteraction(state: .dropOut,
                                                        imageName: "chatting_lounge_userInteraction_drop_out",
                                                        title: localizable.chattingLoungeUserInteractionDropOut(),
                                                        colorHexName: "#FD6E6E"))
            result.append(ChattingLoungeUserInteraction(state: .delegateHost,
                                                        imageName: "chatting_lounge_userInteraction_delegate_host",
                                                        title: localizable.chattingLoungeUserInteractionDelegateHost(),
                                                        colorHexName: "#E79447"))
        }
        result.append(ChattingLoungeUserInteraction(state: .silent,
                                                    imageName: "chatting_lounge_userInteraction_silent",
                                                    title: localizable.chattingLoungeUserInteractionSilent(),
                                                    colorHexName: "#4B555F"))
        result.append(ChattingLoungeUserInteraction(state: .requestFriend,
                                                    imageName: "chatting_lounge_userInteraction_request_friend",
                                                    title: localizable.chattingLoungeUserInteractionRequestFriend(),
                                                    colorHexName: "#6C5CE7"))
        result.append(ChattingLoungeUserInteraction(state: .report,
                                                    imageName: "chatting_lounge_userInteraction_report",
                                                    title: localizable.chattingLoungeUserInteractionReport(),
                                                    colorHexName: "#FD6E6E"))
        result.append(ChattingLoungeUserInteraction(state: .warn,
                                                    imageName: "chatting_lounge_userInteraction_warn",
                                                    title: localizable.chattingLoungeUserInteractionWarn(),
                                                    colorHexName: "#FDCB6E"))
        list.accept(result)
        return Driver.just(result)
    }

    func getListCount() -> Int {
        list.value.count
    }

    func inviteFriendButtonTapWithRequestFriend() -> Signal<Bool> {
        requestFriendButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                return self.repository.requestFriend(memberId: $0)
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    func interactionButtonTapWithEnterUnity() -> Signal<ChattingLoungeUserInteractionState> {
        interactionButtonTap.asSignal(onErrorSignalWith: .empty())
    }
}
