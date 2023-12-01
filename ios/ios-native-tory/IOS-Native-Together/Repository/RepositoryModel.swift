//
//  RepositoryModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa

struct RepositoryModel {
    static let shared = RepositoryModel()

    private let disponseBag = DisposeBag()
    /*
     앱 백그라운도 forgorund 상태 저장
     */
    let isForground = BehaviorRelay<Bool>(value: false)

    let initData = BehaviorRelay<InitResultDto>(value: InitResultDto())
    let member = BehaviorRelay<MyMemberResultDto>(value: MyMemberResultDto())
    let point = BehaviorRelay<PointResultDto>(value: PointResultDto())

    let isSeminarBannerShow = BehaviorRelay<Bool>(value: false)
    let isSeminarOnAirShow = BehaviorRelay<Bool>(value: false)
    var starBugsEventImgUrl: Driver<String>?

    let universityList = BehaviorRelay<[UniversityListResultDto.Item]>(value: [])
    var inAppPurchaseProductList: Driver<[InAppPurchaseProductResultDto]>?
    let defaultImgUrlList = BehaviorRelay<[String]>(value: [])
    let eventBannerList = BehaviorRelay<[BannerEventAttribute]>(value: [])

    let isPushAgree = BehaviorRelay<Bool>(value: false)

    let myWriteList = BehaviorRelay<[MyWriteListResultDto.Item]>(value: [])
    let myCommentList = BehaviorRelay<[MyCommentListResultDto.Item]>(value: [])

    /*
     아바타
     */
    let hasAvaterAttr = BehaviorRelay<Bool>(value: false)
    let myAvatarAttr = BehaviorRelay<AvatarAttribute>(value: .init())

    /*
     전역 관리
     */
    let newMainSeminarReload = PublishRelay<Void>()
    let seminarMainReload = PublishRelay<Void>()
    // Seminar ID
    let seminarSearchReload = PublishRelay<Int>()

    /*
     토리톡 전역 관리
     */
    let friendListReload = PublishRelay<UpdateFriendStateInteractionCase?>()
    let friendDetailReload = PublishRelay<UpdateFriendStateInteractionCase?>()
    let friendSearchReload = PublishRelay<UpdateFriendStateInteractionCase?>()

    let isTTCLoggedIn = BehaviorRelay<Bool>(value: false)

    /*
     initData가 변경되면
     아래의 결과는 모두 바뀐다.
     또한 initData가 nil이라면 아무런 값 방출을 안할것. <이것은 내가 의도 한바>
     */
    private init() {
        /*
         bind
         */
        initData
            .filter { $0.memberVO.memberId != 0 }
            .bind(onNext: { [self] in
                acceptData(initData: $0)
            })
            .disposed(by: disponseBag)
        /*
         convert
         */
        starBugsEventImgUrl = initData
            .filter { $0.memberVO.memberId != 0 }
            .map { $0.eventBannerUrl }
            .asDriver(onErrorDriveWith: .empty())

        inAppPurchaseProductList = initData
            .filter { $0.memberVO.memberId != 0 }
            .map { $0.toryItemList }
            .asDriver(onErrorDriveWith: .empty())
    }

    private func acceptData(initData: InitResultDto) {
        member.accept(initData.memberVO)
        let point = PointResultDto(point: initData.tory, mileage: initData.mileage)
        self.point.accept(point)
        isSeminarBannerShow.accept(initData.isShowBanner)
        isSeminarOnAirShow.accept(initData.isShowOnAir)
        universityList.accept(initData.universityVOList)
        eventBannerList.accept(initData.eventBannerList)
        defaultImgUrlList.accept(initData.baseImgUrlArr)
        hasAvaterAttr.accept(initData.hasAvatarAttrYn)
        myAvatarAttr.accept(initData.myAvatarAttr)
        let convertList = initData.agreementList
            .filter { $0.pushCategory == PushAgreementCategory.push }
            .map { $0.isAgree }
        if !convertList.isEmpty {
            isPushAgree.accept(convertList[0])
        }

        isTTCLoggedIn.accept(initData.ttcStatus)
    }
}
