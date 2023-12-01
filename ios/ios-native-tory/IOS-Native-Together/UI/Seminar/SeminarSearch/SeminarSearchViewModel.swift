//
//  SeminarSearchViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/09.
//

import Foundation
import RxSwift
import RxCocoa

final class SeminarSearchViewModel: RefactoringBaseViewModel {
    let list = BehaviorRelay<[SeminarListResultDto.Item]>(value: [])
    let query = BehaviorRelay<String?>(value: "")

    let isLastPage = BehaviorRelay(value: false)

    func paging(isBottom: Bool) -> Observable<[SeminarListResultDto.Item]> {
        Observable<Bool>.just(isBottom)
            .filter { $0 }
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
                return self.repository.getSearchSeminarList(query: query.value ?? "", lastId: $0)
            }
            .filter { !$0.isEmpty }
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
