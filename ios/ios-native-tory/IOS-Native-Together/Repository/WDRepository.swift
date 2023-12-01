//
//  WilldRepository.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/27.

import Foundation
import RxSwift
import RxCocoa

protocol CertificationRepositoryProtocol: CommonRepositoryProtocol {}
protocol UserRepositoryProtocol: CommonRepositoryProtocol {}
protocol FriendRepositoryProtocol: CommonRepositoryProtocol {}
protocol PointRepositoryProtocol: CommonRepositoryProtocol {}
protocol EventRepositoryProtocol: CommonRepositoryProtocol {}
protocol SeminarRepositoryProtocol: CommonRepositoryProtocol {}
protocol TTCAPIRepositoryProtocol: CommonRepositoryProtocol {}
protocol AvatarRepositoryProtocol: CommonRepositoryProtocol {}
protocol NFTRepositoryProtocol: CommonRepositoryProtocol {}
protocol MapRepositoryProtocol: CommonRepositoryProtocol {}
protocol BoardRepositoryProtocol: CommonRepositoryProtocol {}
protocol InformationRepositoryProtocol: CommonRepositoryProtocol {}
protocol MetaverseRepositoryProtocol: CommonRepositoryProtocol {}

protocol FromUnityRepositoryProtocol: CommonRepositoryProtocol {}
final class WDRepository: CertificationRepositoryProtocol,
                          UserRepositoryProtocol,
                          FriendRepositoryProtocol,
                          PointRepositoryProtocol,
                          EventRepositoryProtocol,
                          SeminarRepositoryProtocol,
                          TTCAPIRepositoryProtocol,
                          AvatarRepositoryProtocol,
                          NFTRepositoryProtocol,
                          MapRepositoryProtocol,
                          BoardRepositoryProtocol,
                          InformationRepositoryProtocol,
                          MetaverseRepositoryProtocol,
                          FromUnityRepositoryProtocol {
    static let shared = WDRepository()
    private init() {}

    static var pushActionUrl: String = ""

    lazy var isForground = repositoryModel.isForground

    lazy var initData = repositoryModel.initData
    lazy var member = repositoryModel.member
    lazy var point = repositoryModel.point

    lazy var isSeminarBannerShow = repositoryModel.isSeminarBannerShow
    lazy var isSeminarOnAirShow = repositoryModel.isSeminarOnAirShow
    lazy var starBugsEventImgUrl = repositoryModel.starBugsEventImgUrl

    lazy var universityList = repositoryModel.universityList
    lazy var inAppPurchaseProductList = repositoryModel.inAppPurchaseProductList

    lazy var eventBannerList = repositoryModel.eventBannerList
    lazy var defaultImgUrlList = repositoryModel.defaultImgUrlList

    lazy var isPushAgree = repositoryModel.isPushAgree

    lazy var myWriteList = repositoryModel.myWriteList
    lazy var myCommentList = repositoryModel.myCommentList

    lazy var hasAvaterAttr = repositoryModel.hasAvaterAttr
    lazy var myAvatarAttr = repositoryModel.myAvatarAttr

    lazy var newMainSeminarReload = repositoryModel.newMainSeminarReload
    lazy var seminarMainReload = repositoryModel.seminarMainReload
    lazy var seminarSearchReload = repositoryModel.seminarSearchReload

    lazy var friendListReload = repositoryModel.friendListReload
    lazy var friendListDetailReload = repositoryModel.friendDetailReload
    lazy var friendSearchReload = repositoryModel.friendSearchReload

    lazy var isTTCLoggedIn = repositoryModel.isTTCLoggedIn
}
