//
//  FriendSearchViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/08/03.
//

import Foundation
import RxSwift
import RxCocoa

final class FriendSearchViewModel: RefactoringBaseViewModel {
    let pageData = BehaviorRelay<SearchFriendList>(value: .init())

    let query = BehaviorRelay<String?>(value: "")
    let type = BehaviorRelay<FriendType>(value: .new)

    let commonFriendViewModel = FriendCommonViewModel()

    func getFriendSearchList() -> Observable<SearchFriendList> {
        query
            .filter {
                !($0?.isEmpty ?? true)
            }
            .flatMap { [weak self] in
                guard let self = self else { return Observable<SearchFriendList>.empty() }
                return self.repository.getSearchFriendList(query: $0, type: self.type.value)
            }
    }

}
