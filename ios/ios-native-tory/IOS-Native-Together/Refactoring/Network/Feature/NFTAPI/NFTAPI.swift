//
//  nftAPIService.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/08.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

/*
 https://nft-api.bevarrico.com 관련 API
 */
struct NftAPI {
    static let shared = NftAPI()
    private init() {}

    func getOwnerNFT(currentPage: Int = 1,
                     perPage: Int = 6,
                     sort: String = "-updatedAt",
                     ownerMemberId: Int) -> Observable<[OwnerNftResultDto]> {
        let requestContext = NFTAPIRequestContext(path: "/nfts",
                                                  params: ["currentPage": currentPage,
                                                           "perPage": perPage,
                                                           "sort": sort,
                                                           "ownerId": ownerMemberId],
                                                  requestUIMode: .loading,
                                                  resultUIMode: .showWarning)
        return CommonRESTfulAPIService<NFTAPIResultWrapper<[OwnerNftResultDto]>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn([])
    }
}
