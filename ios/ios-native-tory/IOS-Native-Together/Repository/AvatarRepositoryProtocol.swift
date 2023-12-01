//
//  AvatarRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/23.
//

import Foundation
import RxSwift
import RxCocoa

extension AvatarRepositoryProtocol {
    /*
     아바타 리스트
     */
    func getAvatarList() -> Observable<[AvatarListResultDto.Item]> {
        memberAPI.getAvatarList()
            .map { $0.wholeModelingAvatarList }
    }
    /*
     아바타 선택
     */
    func updateAvatar(id: Int) -> Observable<Bool> {
        memberAPI.updateAvatar(id: id)
            .map { $0.isSuccess }

    }
}

// MAKR: - Avatar (NEW)
extension AvatarRepositoryProtocol {

    func getAvatarCategoryList() -> Observable<[String]> {
        memberAPI.getAvatarCategoryList()
            .map { $0.avatarCategoryList }
    }

    func getAvatarItemList(category: String) -> Observable<[AvatarModeling]> {
        memberAPI.getAvatarItemList(category: category)
            .map { $0.avatarModelingList }
    }

    func getAvatarColorList(category: String) -> Observable<[AvatarColor]> {
        memberAPI.getAvatarColorList(category: category)
            .map { $0.avatarColorList }
    }

    func saveAvatar(saveInfo: AvatarAttribute) -> Observable<Bool> {
        memberAPI.saveAvatar(saveInfo: saveInfo)
            .map { $0.isSuccess }
    }
}
