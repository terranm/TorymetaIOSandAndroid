//
//  ChattingLoungeDetailViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeDetailViewModel: RefactoringBaseViewModel {

    let option = BehaviorRelay<ChattingLoungeDetailOptionStatus>(value: .all)
    let list = BehaviorRelay<[ChattingLoungeChattingRoomList.Item]>(value: [])
    let entranceButtonTap = PublishRelay<ChattingLoungeChattingRoomList.Item>()

    func chttingList() -> Observable<[ChattingLoungeChattingRoomList.Item]> {
        option
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[ChattingLoungeChattingRoomList.Item]>.empty() }
                return self.repository.getChattingLoungeChattingRoomList(detailSelectOption: $0)
            }
    }

    func entranceButtonTapWithUnitySwitchScene()
    -> Signal<(videoUrl: String, item: ChattingLoungeChattingRoomList.Item)> {
        entranceButtonTap
            .flatMap { [weak self] data in
                guard let self = self else {
                    return Observable<(videoUrl: String, item: ChattingLoungeChattingRoomList.Item)>.empty()
                }
                return self.repository.getNewSeminarLoungeVideoURL().map {
                    ($0, data)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    func getListCount() -> Int {
        list.value.count
    }
}
