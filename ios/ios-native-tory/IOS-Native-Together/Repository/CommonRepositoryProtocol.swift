//
//  CommonRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol CommonRepositoryProtocol: AnyObject {}
extension CommonRepositoryProtocol {
    var tag: String { return String(describing: Self.self) }
    var memberAPI: MemberAPI { return MemberAPI.shared }
    var mapAPI: MapAPI { return MapAPI.shared }
    var nftAPI: NftAPI { return NftAPI.shared }
    var boardAPI: BoardAPI { return BoardAPI.shared }
    var metaverseAPI: MetaverseAPI { return MetaverseAPI.shared }
    var repositoryModel: RepositoryModel { return RepositoryModel.shared }
}
