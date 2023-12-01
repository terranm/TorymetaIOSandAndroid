//
//  TTCCurriculumListViewModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

final class TTCCurriculumListViewModel: RefactoringBaseViewModel {
//    private let repository = WDRepository.shared
    private(set) var pageOffset = 0
    typealias CurriculumSectionModel = SectionModel<String, TTCLectureList.Lecture>
    private(set) var curriculumListRelay = BehaviorRelay(value: [CurriculumSectionModel]())

    override init() {
        super.init()
        getCurriculumList()
    }

    var isTTCLoggedIn: Bool {
        repository.isTTCLoggedIn.value
    }

    func getCurriculumList(_ isRefresh: Bool = false) {
        repository.getTTCLectureList(pageOffset)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] curriculums in
                guard let self else { return }
                let lectureList = curriculums.lectureList
                let offset = curriculums.offset
                var currentCuriiculumList: [TTCLectureList.Lecture] = []
                if isRefresh {
                    currentCuriiculumList = lectureList
                } else {
                    currentCuriiculumList = self.curriculumListRelay.value.first?.items ?? []
                    currentCuriiculumList.append(contentsOf: lectureList)
                }
                curriculumListRelay.accept([CurriculumSectionModel(model: "", items: currentCuriiculumList)])
                self.pageOffset = offset
            }
            .disposed(by: disposeBag)
    }

    func refreshCurrculumList() {
        pageOffset = 0
        getCurriculumList(true)
    }
}
