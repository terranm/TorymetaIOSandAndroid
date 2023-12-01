//
//  CreateSeminarViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import Foundation
import RxSwift
import RxCocoa

final class CreateSeminarViewModel: RefactoringBaseViewModel {

    typealias LiveSeminarParticipateParams = (roomId: Int, password: String)
    typealias PasswordCheck = (roomId: Int, password: String)

    let list = BehaviorRelay<[SeminarListResultDto.Item]>(value: [.init()])

    let passwordCheckButtonTap = PublishRelay<Int>()
    var presentPasswordCheckButtonTap: Signal<PasswordCheck>?

    let deleteButtonTap = PublishRelay<Int>()
    var presentDeleteButtonTap: Signal<(result: Bool, roomId: Int)>?

    let isLastPage = BehaviorRelay(value: false)

    let seminarItem = BehaviorRelay<SeminarListResultDto.Item>(value: .init())
    let liveSeminarParticipateButtonTap = PublishRelay<LiveSeminarParticipateParams>()
    var presentLiveSeminarParticipateButtonTap: Signal<EntranceSeparatedSeminarResultDto>?

    override init() {
        super.init()

        presentPasswordCheckButtonTap = passwordCheckButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<PasswordCheck>.empty() }
                return self.repository.reqSeminarRoomPassword(rooId: $0)
            }
            .asSignal(onErrorSignalWith: .empty())

        presentDeleteButtonTap = deleteButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<(result: Bool, roomId: Int)>.empty() }
                return self.repository.deleteSeminar(roomId: $0)
            }
            .asSignal(onErrorSignalWith: .empty())

        presentLiveSeminarParticipateButtonTap = liveSeminarParticipateButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<EntranceSeparatedSeminarResultDto>.empty() }
                return self.repository.entranceSeminar(roomId: $0.roomId, password: $0.password)
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    func paging() -> Observable<[SeminarListResultDto.Item]> {
        Observable<Void>.just(())
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return self.list.value.count > 1
            }
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return !self.isLastPage.value
            }
            .map { [weak self] _ in
                guard let self = self else { return 0 }
                return self.list.value[list.value.count - 1].id
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[SeminarListResultDto.Item]>.empty() }
                return self.repository.getSeminarList(query: "create", lastId: $0)
            }
            .flatMap { [weak self] in
                if !$0.isEmpty {
                    return Observable.just($0)
                } else {
                    self?.isLastPage.accept(true)
                    return Observable.empty()
                }
            }
    }
}
