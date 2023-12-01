//
//  MemberSeminarAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import RxSwift
import RxCocoa

extension SeminarAPIProtocol {
    /*
     세미나 리스트
     신청 세미나 목록 -> participation
     개설 세미나 목록 -> create
     */
    func getSeminarList(query: String = "", lastId: Int = 0) -> Observable<SeminarListResultDto> {
        var params: [String: Any] = [:]
        if !query.isEmpty {
            params["query"] = query
        }
        params["lastId"] = lastId == 0 ? "" : "\(lastId)"
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar",
                                                   params: params,
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SeminarListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(SeminarListResultDto(content: []))
    }

    /*
     Live 세미나
     */
    func getLiveSeminarList() -> Observable<LiveSeminarListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/live",
                                                   params: ["query": "now"],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<LiveSeminarListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(LiveSeminarListResultDto(liveSeminarList: []))
    }

    /*
     세미나 디테일 페이지
     */
    func getSeminarDetail(id: Int) -> Observable<SeminarDetailResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/\(id)",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SeminarDetailResultDto>>(requestContext: requestContext)
            .getMapping()
            .catch { _ in
                Observable<SeminarDetailResultDto>.empty()
            }
    }

    /*
     일자별 세미나 조회
     ex) date -> 20230606
     */
    func getSingleScheduleList(date: String) -> Observable<LiveSeminarListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/live",
                                                   params: ["query": "date",
                                                            "date": date],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<LiveSeminarListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(LiveSeminarListResultDto(liveSeminarList: []))
    }

    /*
     세미나 참가 신청
     */
    func reqSeminarParticipation(id: Int) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/\(id)/participation",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    /*
     패스워드 조회
     */
    func reqSeminarRoomPassword(rooId: Int) -> Observable<ReqSeminarRoomPasswordResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/\(rooId)/password",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqSeminarRoomPasswordResultDto>>(requestContext:
                                                                                                requestContext)
        .getMapping()
        .catch { _ in
            Observable<ReqSeminarRoomPasswordResultDto>.empty()
        }
    }

    /*
     세미나 룸 조회
     ALL
     SMALL
     MEDIUME
     LARGE
     */
    func getCreateSeminarRoomList(roomSize: String = "ALL", roomType: String = "SEMINAR")
    -> Observable<SeminarRoomTypeListResultDto> {
        var params: [String: Any] = [:]
        if roomSize != "ALL" {
            params["roomSize"] = roomSize
        }
        params["roomType"] = roomType
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/room",
                                                   params: params,
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SeminarRoomTypeListResultDto>>(requestContext:
                                                                                            requestContext)
            .getMapping()
            .catchAndReturn(SeminarRoomTypeListResultDto(roomList: []))
    }

    /*
     추천메타
     */
    func getRecommendMetaList() -> Observable<SeminarRoomTypeListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/room",
                                                   params: ["roomType": "UNI"],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SeminarRoomTypeListResultDto>>(requestContext:
                                                                                            requestContext)
            .getMapping()
            .catchAndReturn(SeminarRoomTypeListResultDto(roomList: []))
    }
    /*
     세미나 룸 생성
     */
    func createSeminarRoom(params: CreateSeminarRoomParams) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar",
                                                   params: ["roomId": params.roomId,
                                                            "title": params.title,
                                                            "description": params.description,
                                                            "teacherDescription": params.teacherDescription,
                                                            "startAt": params.startDate,
                                                            "endAt": params.endDate,
                                                            "seminarUrl": params.seminarUrl,
                                                            "password": params.password,
                                                            "secretYn": params.secretYn,
                                                            "maxEnterCount": params.maxEnterCount,
                                                            "seminarFilesId": 1,
                                                            "createRoomCount": params.createRoomCount ?? 0],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    /*
     세미나 업데이트
     */
    func updateCreateSeminarRoom(seminarId: Int, params: CreateSeminarRoomParams)
    -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/\(seminarId)",
                                                   params: ["roomId": params.roomId,
                                                            "title": params.title,
                                                            "description": params.description,
                                                            "teacherDescription": params.teacherDescription,
                                                            "startAt": params.startDate,
                                                            "endAt": params.endDate,
                                                            "seminarUrl": params.seminarUrl,
                                                            "password": params.password,
                                                            "secretYn": params.secretYn,
                                                            "maxEnterCount": params.maxEnterCount,
                                                            "seminarFilesId": 1],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .patchMappding()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    /*
     세미나 입장
     */

    func entranceSeminar(roomId: Int, password: String = "")
    -> Observable<EntranceSeparatedSeminarResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/\(roomId)/enter",
                                                   params: ["password": password],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<EntranceSeparatedSeminarResultDto>>(requestContext:
                                                                                                    requestContext)
            .postMapping()
            .catch { _ in
                Observable<EntranceSeparatedSeminarResultDto>.empty()
            }
    }

    /*
     세미나 삭제
     */
    func deleteSeminar(roomId: Int) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/\(roomId)",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .deleteMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    /*
     세미나 검색
     */
    func getSearchSeminarList(query: String, filter: String, lastID: Int, size: Int)
    -> Observable<SeminarListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/seminar/search",
                                                   params: ["where": filter,
                                                            "query": query,
                                                            "lastId": lastID == 0 ? "" : "\(lastID)",
                                                            "size": size],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SeminarListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(SeminarListResultDto(content: []))
    }

    /*
     세미나 라운지 비디오
     */
    func getSeminarLoungeVideoUrl() -> Observable<SeminarLoungeVideoUrlResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .primitive,
                                                   path: "/member/v2/video-url",
                                                   params: ["type": "LOUNGE"],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SeminarLoungeVideoUrlResultDto>>(requestContext:
                                                                                                requestContext)
            .getMapping()
            .catch { _ in
                Observable<SeminarLoungeVideoUrlResultDto>.empty()
            }
    }

    /*
     세미나 라운지 정상님 테스트 버전
     */
    func getNewSeminarLoungeVideoURL(loungeType: String = "LOUNGE", mediaType: String = "mp4")
    -> Observable<SeminarLoungeVideoUrlResultDto> {
        let requestContext = ToryAPIRequestContext(
            domain: .primitive,
            path: "/member/v2/video-url",
            params: ["loungeType": loungeType,
                     "mediaType": mediaType],
            requestUIMode: .loading,
            resultUIMode: .showWarning,
            headers: ["Content-Type": "application/json",
                      "Authorization": "\(WDUserDefaultManager.shared.token ?? "")",
                      "X-API-VERSION": "2"]
        )
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SeminarLoungeVideoUrlResultDto>>(requestContext:
                                                                                                requestContext)
        .postMapping()
        .catch { _ in
            Observable<SeminarLoungeVideoUrlResultDto>.empty()
        }
    }
}
