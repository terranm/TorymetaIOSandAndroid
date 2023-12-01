//
//  BottomSlideBannerViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/13.
//

import RxSwift
import RxCocoa

final class BottomSlideBannerViewModel: RefactoringBaseViewModel {
    let list = BehaviorRelay<[BannerEventAttribute]>(value: [])

    let contentsButtonTap = PublishRelay<BannerEventAttribute>()
    let todayDoneButtonTap = PublishRelay<Void>()
    let closeButtonTap = PublishRelay<Void>()

    override init() {
        super.init()
        _ = repository.eventBannerList
            .take(1)
            .bind(to: list)
    }

    func getList() -> Driver<[BannerEventAttribute]> {
        list.asDriver(onErrorDriveWith: .empty())
    }

    func getListCount() -> Driver<Int> {
        list.map { $0.count }
            .asDriver(onErrorDriveWith: .empty())
    }

    func getContensButtonTapEvent() -> Signal<BottomSlideBannerEntranceStatus> {
        contentsButtonTap
            .map {
                let split = $0.bannerAppURL.split(separator: ":")
                let category = split[safe: 0]
                let detailPath = split[safe: 1] ?? ""
                if category == "W" {
                    return BottomSlideBannerEntranceStatus.web(String(detailPath))
                }
                if category == "N" {
                    if detailPath == "stu" {
                        return BottomSlideBannerEntranceStatus.nativeStepUp
                    } else if detailPath == "ttcauth" {
                        return BottomSlideBannerEntranceStatus.ttcLecture
                    }
                }
                return BottomSlideBannerEntranceStatus.web("")
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    func getTodayDoneButtonTapEvent() -> Signal<Void> {
        todayDoneButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }

    func getCloseButtonTapEvent() -> Signal<Void> {
        closeButtonTap
            .asSignal(onErrorSignalWith: .empty())
    }
}
