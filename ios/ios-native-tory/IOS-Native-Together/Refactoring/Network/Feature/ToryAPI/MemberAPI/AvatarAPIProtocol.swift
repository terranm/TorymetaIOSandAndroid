//
//  MemberAvatarAPIProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/19.
//

import Foundation
import RxSwift
import RxCocoa

extension AvatarAPIProtocol {
    /*
     아바타 리스트
     */
    func getAvatarList() -> Observable<AvatarListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/avatar/whole-modeling",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<AvatarListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catch { _ in
                Observable<AvatarListResultDto>.empty()
            }
    }

    /*
     아바타 선택
     */
    func updateAvatar(id: Int) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/avatar",
                                                   params: ["wholeModelingAvatarId": id],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }
}

// MAKR: - Avatar (NEW)
extension AvatarAPIProtocol {

    // MARK: Avatar Category List
    func getAvatarCategoryList() -> Observable<AvatarCategoryList> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/avatar/category",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<AvatarCategoryList>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(AvatarCategoryList(avatarCategoryList: []))
    }

    // MARK: Avatar Item List
    func getAvatarItemList(category: String) -> Observable<AvatarModelingList> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/avatar/item",
                                                   params: ["category": category],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<AvatarModelingList>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(AvatarModelingList(avatarModelingList: []))
    }

    // MARK: Avatar Color List
    func getAvatarColorList(category: String) -> Observable<AvatarColorList> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/avatar/color",
                                                   params: ["category": category],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<AvatarColorList>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(AvatarColorList(avatarColorList: []))
    }

    // MARK: Save Avatar
    func saveAvatar(saveInfo: AvatarAttribute) -> Observable<ReqResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .member,
                                                   path: "/avatar/save",
                                                   params: saveInfo.convertToDict() ?? [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<ReqResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<ReqResultDto>.empty()
            }
    }
}
