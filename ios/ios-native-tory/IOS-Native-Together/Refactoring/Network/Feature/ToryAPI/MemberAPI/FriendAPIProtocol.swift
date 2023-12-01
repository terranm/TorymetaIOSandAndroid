//
//  MemberFriendAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

extension FriendAPIProtocol {
    /*
     친구 통합 리스트
     */
    func getFriendInfoList(contractList: [ContractInfo]) -> Observable<FriendInfoList> {
        var jsonObject: [String: Any] = [:]
        var phoneListArray: [[String: String]] = []
        for contractInfo in contractList {
            let phoneInfo: [String: String] = ["profileName": contractInfo.profileName,
                                               "phoneNum": contractInfo.phoneNum]
            phoneListArray.append(phoneInfo)
        }
        jsonObject["phoneList"] = phoneListArray
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/test/friends-info",
                                                   params: jsonObject,
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<FriendInfoList>>(requestContext: requestContext)
            .postMapping()
            .catchAndReturn(FriendInfoList())
    }

    /*
     친구 상태 변경 API
     */
    func updateUserState(interaction: UpdateFriendStateInteractionCase?)
    -> Observable<ReqResultDto> {
        var memberId = 0
        var target = ""
        var status = ""
        switch interaction {
        case .locationBlock(let data):
            memberId = data.memberId
            target = "L"
            status = "B"
        case .locationUnBlock(let data):
            memberId = data.memberId
            target = "L"
            status = "U"
        case .friendBlock(let data):
            memberId = data.memberId
            target = "F"
            status = "B"
        case .friendUnBlock(let data):
            memberId = data.memberId
            target = "F"
            status = "U"
        case .friendAccept(let data):
            memberId = data.memberId
            target = "F"
            status = "R"
        case .friendUnAccept(let data):
            memberId = data.memberId
            target = "F"
            status = "D"
        case .friendRequest(let data):
            memberId = data.memberId
            target = "F"
            status = "A"
        case .friendDelete(let data):
            memberId = data.memberId
            target = "F"
            status = "D"
        default: break
        }
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/test/change-status",
                                                   params: ["target": "\(target)",
                                                            "status": "\(status)",
                                                            "friendId": "\(memberId)"],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    func updateUserState(memberId: Int, target: String, status: String)
    -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/test/change-status",
                                                   params: ["target": "\(target)",
                                                            "status": "\(status)",
                                                            "friendId": "\(memberId)"],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }

    /*
     차단 친구 리스트
     */
    func getBlocFriendList() -> Observable<BlockFriendListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/test/friend/block-list",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<BlockFriendListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(BlockFriendListResultDto(blockFriendList: []))
    }

    func getSearchFriendList(phoneList: [String],
                             query: String?,
                             type: FriendType) -> Observable<SearchFriendList> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/test/friend/search",
                                                   params: ["phoneList": phoneList,
                                                            "query": query ?? "",
                                                            "type": type.rawValue],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<SearchFriendList>>(requestContext: requestContext)
            .postMapping()
            .catchAndReturn(SearchFriendList())
    }

    /*
     채팅라운지 초대하기 (푸시)
     */
    func reqChattingLoungeInvite(memberId: Int, tableId: String)
    -> Observable<ChattingLoungeInviteFriendResult> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/friend/chat-invite",
                                                   params: ["friendId": memberId,
                                                            "tableId": tableId],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ChattingLoungeInviteFriendResult>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ChattingLoungeInviteFriendResult>.empty()
            }
    }
}
