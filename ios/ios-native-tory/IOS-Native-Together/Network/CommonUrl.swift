//
//  CommonUrl.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/05/24.
//

import Foundation

protocol CommonURLProtocol {
    var distinguish: String { get set }
    var baseUrl: String { get }
    var resultUrl: String { get set }
    func getUrl() -> URL?
}

extension CommonURLProtocol {
    func getUrl() -> URL? {
        URL(string: self.resultUrl)
    }
}

// MARK: - ToryWebViewURL

enum ToryWebViewURLType: String {
    // MARK: Path
    case login = "login"    // 로그인 페이지 (캠퍼스 상단 탭)
    case setting = "setting"    // 설정 페이지 (마이페이지 Navigation Bar)
    case notice = "notice"  // 알림 페이지 (마이페이지 Navigation Bar)
    case boardTalk = "board/community/1"    // 게시판 페이지 (캠퍼스 상단 탭)
    case boardWe = "board/community/2"
    case boardHelp = "board/community/3"
    case boardMarket = "board/community/4"
    case event = "board/event"  // 교내 행사 (캠퍼스 상단 탭)
    case food = "board/food"    // 학식정보 (캠퍼스 상단 탭)
//    case checkEvent = "event/check"   // (사용하는 곳이 없음) 출석 체크 (AttendanceBanner 및 캠퍼스 왼쪽 상단 달력 버튼)
    case generalNotice = "setting/gongji"   // 공지사항
    case selectUniversity = "university/auth"   // 대학교 선택
    case myWriteDetail = "myWriteDetail"    // Detail Page
    case myCommentDetail = "myCommentDetail"
    case eventBannerDetail = "eventBannerDetail"
//    case universitySelectDetail = "universitySelectDetail"
    var path: String {
        switch self {
        case .login:                    return ToryWebViewURLType.login.rawValue
        case .setting:                  return ToryWebViewURLType.setting.rawValue
        case .notice:                   return ToryWebViewURLType.notice.rawValue
        case .boardTalk:                return ToryWebViewURLType.boardTalk.rawValue
        case .boardWe:                  return ToryWebViewURLType.boardWe.rawValue
        case .boardHelp:                return ToryWebViewURLType.boardHelp.rawValue
        case .boardMarket:              return ToryWebViewURLType.boardMarket.rawValue
        case .event:                    return ToryWebViewURLType.event.rawValue
        case .food:                     return ToryWebViewURLType.food.rawValue
        case .generalNotice:            return ToryWebViewURLType.generalNotice.rawValue
        case .selectUniversity:         return ToryWebViewURLType.selectUniversity.rawValue
        case .myWriteDetail:            return ToryWebViewURLType.myWriteDetail.rawValue
        case .myCommentDetail:          return ToryWebViewURLType.myCommentDetail.rawValue
        case .eventBannerDetail:        return ToryWebViewURLType.eventBannerDetail.rawValue
        }
    }
}

struct ToryWebViewURL: CommonURLProtocol {

    var distinguish: String = ""

    var baseUrl: String {
        AppConfigure.isProductRelease ? "https://web.torymeta.com" : "https://test-web.torymeta.com"
    }

    var resultUrl: String = ""

    init(path: String, getParams: [String: String] = [:]) {
        self.distinguish = path
        if !getParams.isEmpty {
            var params = ""
            getParams.enumerated().forEach { index, value in
                if index == 0 {
                    params += "\(value.key)=\(value.value)"
                } else {
                    params += "&\(value.key)=\(value.value)"
                }
            }
            self.resultUrl = WDHelper.convertSafeUrlName("\(baseUrl)/\(path)?\(params)")
        } else {
            self.resultUrl = WDHelper.convertSafeUrlName("\(baseUrl)/\(path)")
        }
    }

    init(myWriteDetail dto: MyWriteListResultDto.Item, getParams: [String: String] = ["isDirectDetailOpen": "true"]) {
        self.distinguish = ToryWebViewURLType.myWriteDetail.path
        if !getParams.isEmpty {
            var params = ""
            getParams.enumerated().forEach { index, value in
                if index == 0 {
                    params += "\(value.key)=\(value.value)"
                } else {
                    params += "&\(value.key)=\(value.value)"
                }
            }
            self.resultUrl = WDHelper
                .convertSafeUrlName("\(baseUrl)/board/\(dto.boardType.rawValue)/detail/\(dto.bbsId)?\(params)")
        } else {
            self.resultUrl = WDHelper
                .convertSafeUrlName("\(baseUrl)/board/\(dto.boardType.rawValue)/detail/\(dto.bbsId)")
        }
    }

    init(myCommentDetail dto: MyCommentListResultDto.Item,
         getParams: [String: String] = ["isDirectDetailOpen": "true"]) {
        self.distinguish = ToryWebViewURLType.myCommentDetail.path
        if !getParams.isEmpty {
            var params = ""
            getParams.enumerated().forEach { index, value in
                if index == 0 {
                    params += "\(value.key)=\(value.value)"
                } else {
                    params += "&\(value.key)=\(value.value)"
                }
            }
            self.resultUrl = WDHelper
                .convertSafeUrlName("\(baseUrl)/board/\(dto.boardType.rawValue)/detail/\(dto.bbsId)?\(params)")
        } else {
            self.resultUrl = WDHelper
                .convertSafeUrlName("\(baseUrl)/board/\(dto.boardType.rawValue)/detail/\(dto.bbsId)")
        }
    }

    init(eventBannerDetail eventDetailPath: String, getParams: [String: String] = [:]) {
        self.distinguish = ToryWebViewURLType.eventBannerDetail.path
        if !getParams.isEmpty {
            var params = ""
            getParams.enumerated().forEach { index, value in
                if index == 0 {
                    params += "\(value.key)=\(value.value)"
                } else {
                    params += "&\(value.key)=\(value.value)"
                }
            }
            self.resultUrl = WDHelper.convertSafeUrlName("\(baseUrl)\(eventDetailPath)?\(params)")
        } else {
            self.resultUrl = WDHelper.convertSafeUrlName("\(baseUrl)\(eventDetailPath)")
        }
    }

    init(generalNoticeDetail dto: GeneralNoticeListResultDto.Item,
         getParams: [String: String] = ["isDirectDetailOpen": "true"]) {
        self.distinguish = ToryWebViewURLType.eventBannerDetail.path
        if !getParams.isEmpty {
            var params = ""
            getParams.enumerated().forEach { index, value in
                if index == 0 {
                    params += "\(value.key)=\(value.value)"
                } else {
                    params += "&\(value.key)=\(value.value)"
                }
            }
            self.resultUrl = WDHelper
                .convertSafeUrlName("\(baseUrl)/\(ToryWebViewURLType.generalNotice.path)/\(dto.bbsID)?\(params)")

            print("반드시 확인해보자 \(self.resultUrl)")
        } else {
            self.resultUrl = WDHelper
                .convertSafeUrlName("\(baseUrl)/\(ToryWebViewURLType.generalNotice.path)/\(dto.bbsID)")
        }
    }
}

// MARK: - NFTWebViewURL

struct NFTWebViewURL: CommonURLProtocol {

    static let nftBottomTap = "nft_bottom_tap"
    static let nftDetail     = "nft_detail"

    var distinguish: String = ""

    var baseUrl: String {
        AppConfigure.isProductRelease ? "https://webview.bevarrico.com" : "https://test-webview.bevarrico.com"
    }

    var resultUrl: String = ""

    let userDefaultManager = WDUserDefaultManager.shared

    init() {
        self.distinguish = NFTWebViewURL.nftBottomTap
        self.resultUrl = WDHelper.convertSafeUrlName("\(self.baseUrl)" +
                                                     "?bcToken=\(userDefaultManager.bcToken ?? "")" +
                                                     "&token=\(userDefaultManager.token ?? "")" +
                                                     "&guide_home=\(userDefaultManager.guideHome)" +
                                                     "&guide_mint=\(userDefaultManager.guideMint)" +
                                                     "&guide_collection=\(userDefaultManager.guideCollection)" +
                                                     "&guide_auction=\(userDefaultManager.guideAuction)" +
                                                     "&guide_sale=\(userDefaultManager.guideSale)"
        )
    }

    init(nftDto: OwnerNftResultDto) {
        self.distinguish = NFTWebViewURL.nftDetail
        self.resultUrl = WDHelper.convertSafeUrlName("\(self.baseUrl)/extern/nft/detail/\(nftDto.nftIdx)?" +
                                                     "bcToken=\(userDefaultManager.bcToken ?? "")" +
                                                     "&token=\(userDefaultManager.token ?? "")")
    }
}

// MARK: - ImgUrl

struct ImgUrl {
    static let avatarWholeModeling = "avatar/whole-modeling"

    private var base = ""
    init() {
        let host = AppConfigure.isProductRelease ? "torymeta-image" : "test-torymeta-image"
        base = "https://\(host).s3.ap-northeast-2.amazonaws.com"
    }

    func getAvaratImg(groupCode: String, id: Int) -> URL? {
        URL(string: "\(base)/\(ImgUrl.avatarWholeModeling)/\(groupCode)_\(id).png")
    }
}
