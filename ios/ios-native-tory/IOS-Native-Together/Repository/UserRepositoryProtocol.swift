//
//  UserRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa

extension UserRepositoryProtocol {
    /*
     기본 이미지 리스트
     */
    func getDefaultImageList() -> Observable<[URL?]> {
        memberAPI.getDefaultImgList().map {
            $0.list.map {
                URL(string: $0)
            }
        }
    }

    /*
     내 정보 업데이트
     */
    func updateMember() -> Observable<Void> {
        memberAPI.getMember()
            .map { member in
                self.repositoryModel.member.accept(member)
                return ()
            }
    }

    /*
     point Update
     */
    func updatePoint() -> Observable<Void> {
        memberAPI.getPoint()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Void>.empty() }
                self.repositoryModel.point.accept($0)
                return Observable.just(())
            }
    }

    /*
     결재 요청 및 Point 업데이트
     */
    func reqPointCharging(receipt: String) -> Observable<Bool> {
        memberAPI.isToryCharging(receipt: receipt)
            .map { [weak self] in
                guard let self = self else { return false }
                if $0.isSuccess {
                    var newPoint = self.repositoryModel.point.value
                    newPoint.point = $0.tory
                    newPoint.mileage = $0.mileage
                    self.repositoryModel.point.accept(newPoint)
                }
                return $0.isSuccess
            }
    }

    /*
     내가 쓴글 업데이트
     */
    func updateMyWriteList() -> Observable<Bool> {
        boardAPI.getMyWriteList()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                self.repositoryModel.myWriteList.accept($0.list)
                return Observable.just(true)
            }
    }
    /*
     내가 쓴 댓글 업데이트
     */
    func updateMyComment() -> Observable<Bool> {
        boardAPI.getMyCommentList()
            .flatMap { [weak self] in
                guard let self = self else { return Observable<Bool>.empty() }
                self.repositoryModel.myCommentList.accept($0.list)
                return Observable.just(true)
            }
    }

    /*
     이미지 업로드 및 업데이트
     */
    func uploadImage(image: UIImage?) -> Observable<Bool> {
        memberAPI.updateUserImage(image: image)
            .map { [weak self] in
                guard let self = self else { return false }
                var newMember = self.repositoryModel.member.value
                newMember.imgUrl = $0.imgUrl
                self.repositoryModel.member.accept(newMember)
                return $0.isUploadSuccess
            }
    }

    /*
     내 위치 노출 상태 변경
     */
    func updateMyLocationInformation() -> Observable<MyMemberResultDto> {
        memberAPI.updateMyLocationState(isLocationExpose: !repositoryModel.member.value.isLocationExpose)
            .flatMap { [weak self] in
                guard let self = self else { return Observable<MyMemberResultDto>.empty() }
                if $0.isSuccess {
                    var newMember = self.repositoryModel.member.value
                    newMember.locationExposeYn = newMember.isLocationExpose ? 0 : 1
                    self.repositoryModel.member.accept(newMember)
                    return Observable<MyMemberResultDto>.just(newMember)
                } else {
                    return Observable<MyMemberResultDto>.empty()
                }
            }
    }

    /*
     내 위치 업데이트
     */
    func uploadLocation(lat: Double,
                        lng: Double,
                        isLocationExpose: Bool) -> Observable<UpdateMyLatLngResultDto> {
        mapAPI.updateMyLocation(lat: lat,
                                lng: lng,
                                isLocationExpose: isLocationExpose,
                                universityCode: repositoryModel.member.value.universityCode)
    }
    /*
     대학교 UniversityCode 업데이트
     */
    func updateUniversityCode(universityCode: String) -> Observable<Bool> {
        memberAPI.updateUniversity(universityCode: universityCode)
            .map { [weak self] in
                guard let self = self else { return false }
                if $0.isSuccess {
                    var newMember = self.repositoryModel.member.value
                    newMember.universityCode = universityCode
                    self.repositoryModel.member.accept(newMember)
                }
                return $0.isSuccess
            }
    }
    /*
     push 설정 요청
     */
    func reqPushAgreement(pushCategory: PushAgreementCategory, isAgree: Bool) -> Observable<Bool> {
        memberAPI.updatePushAgreement(pushCategory: pushCategory, isAgree: isAgree)
            .map {
                $0.isSuccess ? isAgree : !isAgree
            }
    }

    /*
     push 설정 리스트
     */
    func getPushAgreementList() -> Observable<[PushAgreementListResultDto.Item]> {
        memberAPI.getPushAgreementList()
            .map {
                $0.agreementList
            }
    }

    /*
     나의 학교 정보
     */
    func getMyCampus() -> Observable<UniversityListResultDto.Item> {
        repositoryModel.member
            .distinctUntilChanged { $0.universityCode == $1.universityCode }
            .filter { $0.memberId != 0 }
            .map { $0.universityCode }
            .flatMap { [weak self] code in
                guard let self else { return Observable<[UniversityListResultDto.Item]>.just([]) }
                /*
                 universityList는 앱 전반에 있어서 정적 데이터
                 변화에 신경을 안써줘도 된다.
                 */
                return self.repositoryModel.universityList.asObservable()
                    .map {
                        $0.filter { $0.universityCode == code }
                    }
            }
            .filter { !$0.isEmpty }
            .map { $0[0] }
    }

    func getMyCampus(_ universityCode: String) -> Observable<UniversityListResultDto.Item> {
        repositoryModel.universityList
            .map {
                $0.filter { $0.universityCode == universityCode }
            }
            .filter { !$0.isEmpty }
            .map { $0[0] }
            .asObservable()
    }

    /*
     사용자 이름 변경
     */
    func reqChangeNickName(nickName: String) -> Observable<Bool> {
        memberAPI.updateNickname(nickName: nickName).flatMap { [weak self] in
            guard let self = self else { return Observable<Bool>.empty() }
            if $0.isSuccess {
                var oldMember = self.repositoryModel.member.value
                oldMember.profileName = nickName
                self.repositoryModel.member.accept(oldMember)
            }
            return Observable.just($0.isSuccess)
        }
    }

    func reqRoomReport(chatRoomId: Int, statusList: [ChattingLoungeReportOptionState]) -> Observable<Bool> {
        memberAPI.reqRoomReport(chatRoomId: chatRoomId, statusList: statusList)
            .map { $0.isSuccess }
    }

    func reqUserReport(memberId: Int, statusList: [ChattingLoungeReportOptionState]) -> Observable<Bool> {
        memberAPI.reqUserReport(memberId: memberId, statusList: statusList)
            .map { $0.isSuccess }
    }
}
