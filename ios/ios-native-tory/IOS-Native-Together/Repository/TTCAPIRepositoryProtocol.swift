//
//  TTCAPIRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/18.
//

import Foundation
import RxSwift
import RxCocoa

extension TTCAPIRepositoryProtocol {
    func requestTTCLogin(userId: String, password: String) -> Observable<Bool> {
        memberAPI.requestTTCLogin(userId: userId, password: password)
            .map { $0.isSuccess }
    }

    func getTTCLectureList(_ offset: Int) -> Observable<TTCLectureList> {
        memberAPI.getTTCLectureList(offset)
    }

    func getTTCLectureSubList(params: TTCLectureSubRequestParams) -> Observable<[TTCLectureSubList.SubLecture]> {
        memberAPI.getTTCLectureSubList(params: params)
            .map { $0.list }
    }

    func getTTCPlayerInformation(params: TTCPlayerInformationRequestParams) -> Observable<TTCLecturePlayerInformation> {
        memberAPI.getTTCPlayerInformation(params: params)
    }

    func updateTTCLecturePosition(params: TTCUpdateLectureRequestParams) -> Observable<Bool> {
        memberAPI.updateTTCLecturePosition(params: params)
            .map { $0.isSuccess }
    }

    func updateTTCLectureEnd(params: TTCUpdateLectureEndParams) -> Observable<Bool> {
        memberAPI.updateTTCLectureEnd(params: params)
            .map { $0.isSuccess }
    }
}
