//
//  TTCLectureViewModel.swift
//  IOS-Native-Together
//
//  Created by Chad Hur on 2023/09/20.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

final class TTCLectureViewModel: RefactoringBaseViewModel {

    typealias LectureSectionModel = SectionModel<String, TTCLectureSubList.SubLecture>
    private(set) var lectureListRelay = BehaviorRelay(value: [LectureSectionModel]())

//    private let repository = WDRepository.shared
    private(set) var playVideoRelay = PublishRelay<TTCLecturePlayerInformation>()
    private(set) var curriculumViewModel: TTCCurriculumListViewModel
    private(set) var currentWROrder: Int?

    init(_ curriculumViewModel: TTCCurriculumListViewModel, _ lectureReqInfo: TTCLectureSubRequestParams) {
        self.curriculumViewModel = curriculumViewModel
        super.init()
        getLectureList(lectureReqInfo)
    }

    private func getLectureList(_ lectureReqInfo: TTCLectureSubRequestParams) {
        repository.getTTCLectureSubList(params: lectureReqInfo)
            .subscribe { [weak self] lectures in
                self?.lectureListRelay.accept([LectureSectionModel(model: "", items: lectures)])
            }
            .disposed(by: disposeBag)
    }

    func getVideoInfo(_ item: LectureSectionModel.Item) {
        guard item.wrOrder != currentWROrder else { return } // 현재 재생중인 강의인 경우 리턴
        let selectedLectureInfo = TTCPlayerInformationRequestParams(applyId: item.applyId,
                                                                    lecId: item.lecId,
                                                                    wrOrder: item.wrOrder)
        repository.getTTCPlayerInformation(params: selectedLectureInfo)
            .bind { [weak self] lectureVideoInfo in
                self?.playVideoRelay.accept(lectureVideoInfo)
                self?.currentWROrder = item.wrOrder
            }
            .disposed(by: disposeBag)
    }

    func setPlayingStatus(_ indexPath: IndexPath) {
        guard var items = lectureListRelay.value[safe: indexPath.section]?.items else { return }
        items.indices.forEach {
            items[$0].isPlaying = $0 == indexPath.item ? true : false
        }
        lectureListRelay.accept([LectureSectionModel(model: "", items: items)])
    }
}
