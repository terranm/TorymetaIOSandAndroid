//
//  MemberUserAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import RxSwift
import RxCocoa

extension UserAPIProtocol {
    func getDefaultImgList() -> Observable<DefaultImageListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/default-img-url",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<DefaultImageListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(DefaultImageListResultDto(list: []))
    }

    func getPushAgreementList() -> Observable<PushAgreementListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/agreement",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<PushAgreementListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(PushAgreementListResultDto(agreementList: []))
    }

    func getMember() -> Observable<MyMemberResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/get",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<MyMemberResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<MyMemberResultDto>.empty()
            }
    }

    func getMember(memberId: Int) -> Observable<FriendMemberResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/\(memberId)",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<FriendMemberResultDto>>(requestContext: requestContext)
            .getMapping()
            .catch { _ in
                Observable<FriendMemberResultDto>.empty()
            }
    }
    /*
     사용자 이름 변경
     */
    func updateNickname(nickName: String) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/profile-name/change",
                                                   params: ["newProfileName": nickName],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func updateUserImage(image: UIImage?) -> Observable<UploadImageResultDto> {
        // 의존성 주입으로 해결
        guard let image = image,
              let newImage = image.resize(newWidth: image.size.width / 2),
              let imageData = newImage.jpegData(compressionQuality: 0.2) else { return Observable.empty() }
        let multipartFormDatas = [MultiPartForm(data: imageData,
                                                withName: "imgFile",
                                                fileName: "\(UUID().uuidString).jpeg",
                                                mimeType: "image/jpeg")]
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/img/upload",
                                                   multipartFormDatas: multipartFormDatas,
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<UploadImageResultDto>>(requestContext: requestContext)
            .multipartFormMapping()
            .catch { _ in
                Observable<UploadImageResultDto>.empty()
            }
    }

    func updateUniversity(universityCode: String) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/university/\(universityCode)",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func updateMyLocationState(isLocationExpose: Bool) -> Observable<ReqResultDto> {
        let locationExposeYn = isLocationExpose ? "Y" : "N"
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/location-expose",
                                                   params: ["locationExposeYn": locationExposeYn],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func updatePushAgreement(pushCategory: PushAgreementCategory,
                             isAgree: Bool) -> Observable<ReqResultDto> {
        var params: [String: Any] = [:]
        switch pushCategory {
        case .push: params.updateValue("1", forKey: "agreementCd")
        case .mailSMS: params.updateValue("2", forKey: "agreementCd")
        }
        params.updateValue(isAgree ? "1" : "0", forKey: "agreementStatus")
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/member/agreement",
                                                   params: params,
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func reqUserReport(memberId: Int, statusList: [ChattingLoungeReportOptionState])
    -> Observable<ReqResultDto> {
        let statusListResult = statusList.map { $0.rawValue }
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/report",
                                                   params: ["memberId": memberId,
                                                            "chatRoomId": 0,
                                                            "reportMainType": 0,
                                                            "reportSubType": statusListResult],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showToast)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func reqRoomReport(chatRoomId: Int, statusList: [ChattingLoungeReportOptionState])
    -> Observable<ReqResultDto> {
        let statusListResult = statusList.map { $0.rawValue }
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/report",
                                                   params: ["memberId": 0,
                                                            "chatRoomId": chatRoomId,
                                                            "reportMainType": 1,
                                                            "reportSubType": statusListResult],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showToast)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }
}
