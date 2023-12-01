//
//  SeminarManagerModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/25.
//

import Foundation
import RxSwift
import RxCocoa

struct NeedInformationToSeminar {
    let title: String
    let videoStartTime: String
    let isSecret: Bool
    let seminarID: Int
    init() {
        self.title = ""
        self.videoStartTime = ""
        self.isSecret = false
        self.seminarID = 0
    }
    init(title: String, videoStartTime: String, isSecret: Bool, seminarID: Int) {
        self.title = title
        self.videoStartTime = videoStartTime
        self.isSecret = isSecret
        self.seminarID = seminarID
    }
}

class SeminarManagerModel: RefactoringBaseViewModel {
    typealias ParticipateParams = (roomId: Int, password: String)
    /*
     Item 전달 받아야 된다.....
     */
    let needInformationToSeminar = BehaviorRelay<NeedInformationToSeminar>(value: .init())
    let participate = PublishRelay<ParticipateParams>()
    var presentParticipate: Signal<EntranceSeparatedSeminarResultDto>?

    /*
     세미나 신청
     */
    let apply = PublishRelay<Int>()
    var presentApply: Signal<Bool>?

    /*
     여기서 Int는 seminarRoomId
     */
    let mySeminarParticipate = PublishRelay<Int>()
    var presentMySeminarParticipate: Signal<ParticipateParams>?

    override init() {
        super.init()

        presentParticipate = participate
            .flatMap { [weak self] in
                guard let self = self else { return Observable<EntranceSeparatedSeminarResultDto>.empty() }
                return self.repository.entranceSeminar(roomId: $0.roomId, password: $0.password)
            }
            .asSignal(onErrorSignalWith: .empty())

        presentApply = apply
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                return self.repository.reqSeminarParticipation(id: $0)
            }
            .asSignal(onErrorSignalWith: .empty())

        presentMySeminarParticipate = mySeminarParticipate
            .flatMap { [weak self] in
                guard let self = self else { return Observable<ParticipateParams>.empty() }
                return self.repository.reqSeminarRoomPassword(rooId: $0)
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
