//
//  ChatingListViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/16.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeChattingListViewModel: RefactoringBaseViewModel {
    let list = BehaviorRelay<[ChattingLoungeChattingRoomList.Item]>(value: [])
    let optionSelect = BehaviorRelay<ChattingLoungeChattingListStatus>(value: .all)
    let entranceButtonTap = PublishRelay<ChattingLoungeChattingRoomList.Item>()

    func entranceButtonTapWithUnityBridge() -> Signal<ChattingLoungeChattingRoomList.Item> {
        entranceButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }

    func chattingList() -> Observable<[ChattingLoungeChattingRoomList.Item]> {
        optionSelect
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[ChattingLoungeChattingRoomList.Item]>.empty() }
                return self.repository.getChattingLoungeChattingRoomList(selectOption: $0)
            }
    }

    func getListConunt() -> Int {
        return list.value.count
    }
}
