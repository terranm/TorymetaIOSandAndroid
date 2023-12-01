//
//  ChattingLoungeReportViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/16.
//

import Foundation
import RxSwift
import RxCocoa

final class ChattingLoungeReportViewModel: RefactoringBaseViewModel {
    let reportState: ChattingLoungeReportState
    let isBackgrounClorClear: Bool

    let harassCheckboxButtonTap = BehaviorRelay<ChattingLoungeReportOptionState>(value: .none)
    let lieCheckBoxButtonTap = BehaviorRelay<ChattingLoungeReportOptionState>(value: .none)
    let hateCheckBoxButtonTap = BehaviorRelay<ChattingLoungeReportOptionState>(value: .none)
    let improperCheckBoxButtonTap = BehaviorRelay<ChattingLoungeReportOptionState>(value: .none)

    let reportButtonTap = PublishRelay<Void>()

    init(reportState: ChattingLoungeReportState, isBackgrounClorClear: Bool) {
        self.reportState = reportState
        self.isBackgrounClorClear = isBackgrounClorClear
        super.init()
    }

    func reportNonActive() -> Observable<Bool> {
        Observable.combineLatest(harassCheckboxButtonTap,
                                 lieCheckBoxButtonTap,
                                 hateCheckBoxButtonTap,
                                 improperCheckBoxButtonTap) { harass, lie, hate, improper in
            let reseult = (harass == .none && lie == .none && hate == .none && improper == .none)
            return reseult
        }
    }

    func getResult() -> [ChattingLoungeReportOptionState] {
        var result: [ChattingLoungeReportOptionState] = []

        let harass = harassCheckboxButtonTap.value
        let lie = lieCheckBoxButtonTap.value
        let hate = hateCheckBoxButtonTap.value
        let improper = improperCheckBoxButtonTap.value
        [harass, lie, hate, improper].forEach {
            if $0 != .none {
                result.append($0)
            }
        }
        return result
    }

    func reportButtonTapWithComplete() -> Signal<Bool> {
        reportButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                let harass = self.harassCheckboxButtonTap.value
                let lie = self.lieCheckBoxButtonTap.value
                let hate = self.hateCheckBoxButtonTap.value
                let improper = self.improperCheckBoxButtonTap.value

                let isNon = (harass == .none && lie == .none && hate == .none && improper == .none)
                switch reportState {
                case .reportRoom(let chatRoomId):
                    return !isNon
                    ? self.repository.reqRoomReport(chatRoomId: chatRoomId ?? 0, statusList: getResult())
                    : Observable<Bool>.empty()
                case .reportUser(let memberId):
                    return !isNon
                    ? self.repository.reqUserReport(memberId: memberId ?? 0, statusList: getResult())
                    : Observable<Bool>.empty()
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
