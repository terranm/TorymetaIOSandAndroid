//
//  NFTRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa

extension NFTRepositoryProtocol {
    /*
     NFTColloecion 리스트
     */
    func getNFTList(currentPage: Int,
                    perPage: Int,
                    sort: String = "-updatedAt") -> Observable<[OwnerNftResultDto]> {
        nftAPI.getOwnerNFT(currentPage: currentPage,
                           perPage: perPage,
                           sort: sort,
                           ownerMemberId: self.repositoryModel.member.value.memberId)
    }
}
