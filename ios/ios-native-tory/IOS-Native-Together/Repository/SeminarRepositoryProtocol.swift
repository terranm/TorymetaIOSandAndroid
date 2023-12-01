//
//  SeminarRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/23.
//

import Foundation
import RxSwift
import RxCocoa

extension SeminarRepositoryProtocol {
    /*
     세미나 리스트
     신청 세미나 목록 -> participation
     개설 세미나 목록 -> create
     */
    func getSeminarList(query: String = "", lastId: Int = 0) -> Observable<[SeminarListResultDto.Item]> {
        memberAPI.getSeminarList(query: query, lastId: lastId)
            .map { $0.content }
    }

    /*
     Live 세미나 리스트
     */
    func getLiveSeminarList() -> Observable<[LiveSeminarListResultDto.Item]> {
        memberAPI.getLiveSeminarList()
            .map { $0.liveSeminarList }
    }

    /*
     세미나 디테일
     */
    func getSeminarDetail(id: Int) -> Observable<SeminarDetailResultDto> {
        memberAPI.getSeminarDetail(id: id)
    }

    /*
     일자별 세미나 조회
     ex) date -> 20230606
     */
    func getSingleScheduleList(date: String) -> Observable<[LiveSeminarListResultDto.Item]> {
        memberAPI.getSingleScheduleList(date: date)
            .map { $0.liveSeminarList }
    }

    /*
     세미나 참가 신청
     */
    func reqSeminarParticipation(id: Int) -> Observable<Bool> {
        memberAPI.reqSeminarParticipation(id: id)
            .map { $0.isSuccess }
    }

    /*
     패스워드 조회
     */

    func reqSeminarRoomPassword(rooId: Int) -> Observable<(roomId: Int, password: String)> {
        memberAPI.reqSeminarRoomPassword(rooId: rooId)
            .map { (rooId, $0.password) }
    }

    /*
     세미나 룸 조회
     */

    func getCreateSeminarRoomList(roomSize: String = "ALL") -> Observable<[SeminarRoomTypeListResultDto.Item]> {
        memberAPI.getCreateSeminarRoomList(roomSize: roomSize)
            .map { $0.roomList }
    }

    /*
     추천 메타
     */
    func getRecommendMetaList() -> Observable<[SeminarRoomTypeListResultDto.Item]> {
        memberAPI.getRecommendMetaList()
            .map { $0.roomList }
    }

    /*
     세미나 ROOM 생성
     */

    func createSeminarRoom(params: CreateSeminarRoomParams) -> Observable<Bool> {
        return memberAPI.createSeminarRoom(params: params)
            .map { $0.isSuccess }
    }

    /*
     세미나 Update
     */
    func updateCreateSeminarRoom(seminarId: Int, params: CreateSeminarRoomParams) -> Observable<Bool> {
        memberAPI.updateCreateSeminarRoom(seminarId: seminarId, params: params)
            .map { $0.isSuccess }
    }

    /*
     세미나 입장
     */

    func entranceSeminar(roomId: Int, password: String = "") -> Observable<EntranceSeparatedSeminarResultDto> {
        memberAPI.entranceSeminar(roomId: roomId, password: password)
    }

    /*
     세미나 삭제
     */
    func deleteSeminar(roomId: Int) -> Observable<(result: Bool, roomId: Int)> {
        memberAPI.deleteSeminar(roomId: roomId)
            .map { ($0.isSuccess, roomId) }
    }

    /*
     세미나 검색
     */
    func getSearchSeminarList(query: String,
                              filter: String = "all",
                              lastId: Int = 0,
                              size: Int = 8) -> Observable<[SeminarListResultDto.Item]> {
        memberAPI.getSearchSeminarList(query: query, filter: filter, lastID: lastId, size: size)
            .map { $0.content }
    }

    /*
     세미나 라운지 비디오
     */
    func getSeminarLoungeVideoUrl() -> Observable<String> {
        memberAPI.getSeminarLoungeVideoUrl()
            .map { $0.videoUrl }
    }

    /*
     세미나 라운지 정상님 테스트 버전
     */
    func getNewSeminarLoungeVideoURL(loungeType: String = "LOUNGE",
                                     mediaType: String = "mp4") -> Observable<String> {
        memberAPI.getNewSeminarLoungeVideoURL(loungeType: loungeType, mediaType: mediaType)
            .map { $0.videoUrl }
    }
}
