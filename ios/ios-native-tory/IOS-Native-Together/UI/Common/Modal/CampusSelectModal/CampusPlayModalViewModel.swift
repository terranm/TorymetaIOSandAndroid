//
//  CampusSelectBottomDetailViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/13.
//

import Foundation
import RxSwift
import RxCocoa

final class CampusPlayViewModel: RefactoringBaseViewModel {
    private let selectCampus: UniversityListResultDto.Item
    let list = BehaviorRelay<[UniversityListResultDto.Item]>(value: [])

    init(selectCampus: UniversityListResultDto.Item) {
        self.selectCampus = selectCampus
        super.init()

        bindCampusList()
            .take(1)
            .bind(to: list)
            .disposed(by: disposeBag)
    }

    func getCampusList() -> Observable<[UniversityListResultDto.Item]> {
        list.asObservable()
    }

    func getSelectItem() -> Signal<UniversityListResultDto.Item> {
        Observable.combineLatest(
            list.asObservable(),
            Observable<Int>
                .timer(
                    .milliseconds(800),
                    scheduler: MainScheduler.instance
                )
        ) {
            ($0, $1)
        }
        .map { $0.0 }
        .filter { !$0.isEmpty }
        .map {
            $0.filter { $0.isSelect }
        }
        .filter { !$0.isEmpty }
        .map { $0[0] }
        .filter { [weak self] in
            guard let self = self else { return false }
            return $0.universityCode != self.selectCampus.universityCode
        }
        .asSignal(onErrorSignalWith: .empty())
    }

    private func bindCampusList() -> Observable<[UniversityListResultDto.Item]> {
        repository.member
            .distinctUntilChanged { $0.universityCode != $1.universityCode }
            .map { $0.universityCode }
            .flatMap { [weak self] code in
                guard let self = self else { return Observable<[UniversityListResultDto.Item]>.empty() }
                return self.repository.universityList.asObservable().map {
                    $0.filter { code != $0.universityCode }
                }
            }
            .map { [weak self] in
                guard let self = self else { return $0 }
                var newList = $0
//                for index in 0..<$0.count {
//                    if selectCampus.universityCode == newList[index].universityCode {
//                        newList[index].isSelect = true
//                        return newList
//                    }
//                }
                for index in 0..<$0.count where selectCampus.universityCode == newList[index].universityCode {
                    newList[index].isSelect = true
                    return newList
                }
                return newList
            }
    }
}
