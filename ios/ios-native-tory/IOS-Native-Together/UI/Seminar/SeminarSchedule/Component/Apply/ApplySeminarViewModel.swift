//
//  ApplySeminarViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import Foundation
import RxSwift
import RxCocoa

final class ApplySeminarViewModel: RefactoringBaseViewModel {

    typealias PasswordCheck = (roomId: Int, password: String)

    let list = BehaviorRelay<[SeminarListResultDto.Item]>(value: [.init()])

    let passwordCheckButtonTap = PublishRelay<Int>()
    var presentPasswordCheckButtonTap: Signal<PasswordCheck>?

    /*
     LastId -> "", "0",  "1"
     */
    let isLastPage = BehaviorRelay(value: false)

    override init() {
        super.init()

        presentPasswordCheckButtonTap = passwordCheckButtonTap
            .flatMap { [weak self] in
                guard let self = self else { return Observable<PasswordCheck>.empty() }
                return repository.reqSeminarRoomPassword(rooId: $0)
            }
            .asSignal(onErrorSignalWith: .empty())
    }

    func paging(isBottom: Bool) -> Observable<[SeminarListResultDto.Item]> {
        Observable<Bool>.just(isBottom)
            .filter {
                $0
            }
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return self.list.value.count > 1
            }
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return !self.isLastPage.value
            }
            .map { [weak self] _ in
                /*
                 1번이 첫번째다.
                 */
                guard let self = self else { return 0 }
                return self.list.value[list.value.count - 1].id
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<[SeminarListResultDto.Item]>.empty() }
                return self.repository.getSeminarList(query: "participation", lastId: $0)
            }
            .filter {
                !$0.isEmpty
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
