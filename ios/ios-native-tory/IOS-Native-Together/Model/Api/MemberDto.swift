//
//  ToryDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/24.
//
import Foundation
import SwiftDate

/*
 앱 버전 체크 결과
 */
// swiftlint:disable file_length
struct AppVersionCheckResultDto: Codable {
    private let appStatus: String
    var updateType: Update {
        switch appStatus {
        case "0": return Update.noUpdate
        case "1": return Update.optionalUpdate
        case "2": return Update.forceUpdate
        default:  return Update.noUpdate
        }
    }

    enum Update: String {
        case noUpdate          = "0"
        case optionalUpdate = "1"
        case forceUpdate   = "2"
    }

    init() {
        self.appStatus = ""
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appStatus = try container.decodeIfPresent(String.self, forKey: .appStatus) ?? ""
    }
}

/*
 토리메타 Init 요청 결과
 */

struct InitResultDto: Codable {
    let memberVO: MyMemberResultDto
    let mileage: Int
    let tory: Int

    let toryItemList: [InAppPurchaseProductResultDto]
    let universityVOList: [UniversityListResultDto.Item]
    let showBannerYn: String
    let showOnAirYn: String
    var isShowBanner: Bool {
        switch showBannerYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }
    var isShowOnAir: Bool {
        switch showOnAirYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }

    let eventBannerUrl: String
    let eventBannerList: [BannerEventAttribute]
    let baseImgUrlArr: [String]

    let agreementList: [PushAgreementListResultDto.Item]

    let hasAvatarAttrYn: Bool

    let myAvatar: AvatarListResultDto.Item

    let myAvatarAttr: AvatarAttribute
    var ttcStatus: Bool

    init() {
        self.memberVO = MyMemberResultDto()
        self.mileage = 0
        self.tory = 0
        self.toryItemList = []
        self.universityVOList = []
        self.showBannerYn = "N"
        self.showOnAirYn = "N"
        self.eventBannerUrl = ""
        self.eventBannerList = []
        self.baseImgUrlArr = []
        self.agreementList = []
        self.hasAvatarAttrYn = false
        self.myAvatar = .init()
        self.myAvatarAttr = .init()
        self.ttcStatus = false
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberVO = try container.decodeIfPresent(MyMemberResultDto.self, forKey: .memberVO) ?? MyMemberResultDto()
        self.mileage = try container.decodeIfPresent(Int.self, forKey: .mileage) ?? 0
        self.tory = try container.decodeIfPresent(Int.self, forKey: .tory) ?? 0
        self.toryItemList = try container.decode([InAppPurchaseProductResultDto].self, forKey: .toryItemList)
        self.universityVOList = try container.decode([UniversityListResultDto.Item].self, forKey: .universityVOList)
        self.showBannerYn = try container.decodeIfPresent(String.self, forKey: .showBannerYn) ?? "N"
        self.showOnAirYn = try container.decodeIfPresent(String.self, forKey: .showOnAirYn) ?? "N"
        self.eventBannerUrl = try container.decodeIfPresent(String.self, forKey: .eventBannerUrl) ?? ""
        self.baseImgUrlArr = try container.decode([String].self, forKey: .baseImgUrlArr)
        self.eventBannerList = try container.decode([BannerEventAttribute].self, forKey: .eventBannerList)
        self.agreementList = try container.decode([PushAgreementListResultDto.Item].self, forKey: .agreementList)
        self.hasAvatarAttrYn = try Bool(container
            .decodeIfPresent(String.self, forKey: .hasAvatarAttrYn) == "Y" ? true: false)
        self.myAvatar = try container.decodeIfPresent(AvatarListResultDto.Item.self, forKey: .myAvatar) ?? .init()
        self.myAvatarAttr = try container.decodeIfPresent(AvatarAttribute.self, forKey: .myAvatarAttr) ?? .init()
        self.ttcStatus = try container.decodeIfPresent(String.self, forKey: .ttcStatus) == "LOGIN" ? true : false
    }
}

/*
 내 멤버 정보
 getMember()
 */
struct MyMemberResultDto: Codable {
    let memberId: Int
    var imgUrl: String
    let birth: String
    let emailId: String
    let name: String
    let phoneNum: String
    var profileName: String
    let status: String
    var universityCode: String
    var certUniYn: Int // 0 : 변경 안함, 1 : 변경함
    var isUniversityConfirm: Bool {
        switch certUniYn {
        case 0: return false
        case 1: return true
        default: return false
        }
    }

    /*
     내꺼에 대한
     노출을 할것이냐 여부
     */
    var locationExposeYn: Int

    var isLocationExpose: Bool {
        switch locationExposeYn {
        case 0: return false
        case 1: return true
        default: return false
        }
    }

    init(memberId: Int,
         imgUrl: String,
         birth: String,
         emailId: String,
         name: String,
         phoneNum: String,
         profileName: String,
         status: String,
         universityCode: String,
         locationExposeYn: Int,
         certUniYn: Int) {
        self.memberId = memberId
        self.imgUrl = imgUrl
        self.birth = birth
        self.emailId = emailId
        self.name = name
        self.phoneNum = phoneNum
        self.profileName = profileName
        self.status = status
        self.universityCode = universityCode
        self.locationExposeYn = locationExposeYn
        self.certUniYn = certUniYn
    }

    init() {
        self.memberId = 0
        self.imgUrl = ""
        self.birth = ""
        self.emailId = ""
        self.name = ""
        self.phoneNum = ""
        self.profileName = ""
        self.status = ""
        self.universityCode = ""
        self.locationExposeYn = 0
        self.certUniYn = 0
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decodeIfPresent(Int.self, forKey: .memberId) ?? 0
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl) ?? ""
        self.birth = try container.decodeIfPresent(String.self, forKey: .birth) ?? ""
        self.emailId = try container.decodeIfPresent(String.self, forKey: .emailId) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.phoneNum = try container.decodeIfPresent(String.self, forKey: .phoneNum) ?? ""
        self.profileName = try container.decodeIfPresent(String.self, forKey: .profileName) ?? ""
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.universityCode = try container.decodeIfPresent(String.self, forKey: .universityCode) ?? ""
        self.locationExposeYn = try container.decodeIfPresent(Int.self, forKey: .locationExposeYn) ?? 0
        self.certUniYn = try container.decodeIfPresent(Int.self, forKey: .certUniYn) ?? 0
    }
}

/*
 친구 멤버 정보
 getMember(memberId : Int)
 */
struct FriendMemberResultDto: Codable {
    let memberId: Int
    let imgUrl: String
    let birth: String
    let emailId: String
    let name: String
    let phoneNum: String
    let profileName: String
    let status: String
    let universityCode: String
    /*
     친구에 대한
     차단이 되어 있는가 여부
     */
    private let locationBlockYn: String
    var isLocationBlock: Bool {
        switch locationBlockYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }
    init() {
        self.memberId = 0
        self.imgUrl = ""
        self.birth = ""
        self.emailId = ""
        self.name = ""
        self.phoneNum = ""
        self.profileName = ""
        self.status = ""
        self.universityCode = ""
        self.locationBlockYn = "N"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decodeIfPresent(Int.self, forKey: .memberId) ?? 0
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl) ?? ""
        self.birth = try container.decodeIfPresent(String.self, forKey: .birth) ?? ""
        self.emailId = try container.decodeIfPresent(String.self, forKey: .emailId) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.phoneNum = try container.decodeIfPresent(String.self, forKey: .phoneNum) ?? ""
        self.profileName = try container.decodeIfPresent(String.self, forKey: .profileName) ?? ""
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.universityCode = try container.decodeIfPresent(String.self, forKey: .universityCode) ?? ""
        self.locationBlockYn = try container.decodeIfPresent(String.self, forKey: .locationBlockYn) ?? "N"
    }
}

/*
 이미지 업로드 결과
 */
struct UploadImageResultDto: Codable {
    let imgUrl: String
    let uploadSuccessYn: String
    var isUploadSuccess: Bool {
        switch uploadSuccessYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }

    init() {
        self.imgUrl = ""
        self.uploadSuccessYn = "N"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl) ?? ""
        self.uploadSuccessYn = try container.decodeIfPresent(String.self, forKey: .uploadSuccessYn) ?? "N"
    }
}

/*
 토리 포인트 요청 결과
 */

struct PointResultDto: Codable {
    var point: Int
    var mileage: Int

    init() {
        self.point = 0
        self.mileage = 0
    }

    init(point: Int, mileage: Int) {
        self.point = point
        self.mileage = mileage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.point = try container.decodeIfPresent(Int.self, forKey: .point) ?? 0
        self.mileage = try container.decodeIfPresent(Int.self, forKey: .mileage) ?? 0
    }
}

/*
 인앱 결제 Product 아이템 리스트 결과
 */
struct InAppPurchaseProductResultDto: Codable {
    let cashValue: Int
    let itemId: String
    let itemName: String
    let itemValue: Int
    private let useYn: String
    var isUse: Bool {
        switch useYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }

    init() {
        self.cashValue = 0
        self.itemId = ""
        self.itemName = ""
        self.itemValue = 0
        self.useYn = "N"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cashValue = try container.decodeIfPresent(Int.self, forKey: .cashValue) ?? 0
        self.itemId = try container.decodeIfPresent(String.self, forKey: .itemId) ?? ""
        self.itemName = try container.decodeIfPresent(String.self, forKey: .itemName) ?? ""
        self.itemValue = try container.decodeIfPresent(Int.self, forKey: .itemValue) ?? 0
        self.useYn = try container.decodeIfPresent(String.self, forKey: .useYn) ?? "N"
    }
}
/*
 토리포인트 충전 결과
 */
struct InAppPurchaseResultDto: Codable {
    let processYn: String
    var isSuccess: Bool {
        switch processYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }
    let tory: Int
    let mileage: Int

    init() {
        self.processYn = "N"
        self.tory = 0
        self.mileage = 0
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.processYn = try container.decodeIfPresent(String.self, forKey: .processYn) ?? "N"
        self.tory = try container.decodeIfPresent(Int.self, forKey: .tory) ?? 0
        self.mileage = try container.decodeIfPresent(Int.self, forKey: .mileage) ?? 0
    }

}

/*
 기본 이미지 리스트 결과
 */
struct DefaultImageListResultDto: Codable {
    let list: [String]

    enum CodingKeys: String, CodingKey {
        case list = "defaultImgUrl"
    }
}

/*
 세미나 입장 결과
 */
struct EntranceSeminarResultDto: Codable {
    private let entranceStatus: String
    var entranceType: Entrance {
        switch entranceStatus {
        case "0": return Entrance.ready
        case "1": return Entrance.standBy
        case "2": return Entrance.closed
        default:  return Entrance.closed
        }
    }

    // 세미나에서 보여 줄 youtube Url
    let videoUrl: String
    enum Entrance: String {
        case ready  = "0"   // 0 -> 세미나 입장 가능
        case standBy = "1"  // 1 -> 시작 전
        case closed = "2"   // 2 -> 종료 후
    }

    init() {
        self.entranceStatus = ""
        self.videoUrl = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entranceStatus = try container.decodeIfPresent(String.self, forKey: .entranceStatus) ?? ""
        self.videoUrl = try container.decodeIfPresent(String.self, forKey: .videoUrl) ?? ""
    }

}

/*
 push 동의 조회
 */

enum PushAgreementCategory: Int {
    case push = 1
    case mailSMS = 2
}

struct PushAgreementListResultDto: Codable {
    let agreementList: [Item]

    struct Item: Codable {
        let agreementCd: Int
        var pushCategory: PushAgreementCategory {
            switch agreementCd {
            case 1: return PushAgreementCategory.push
            case 2: return PushAgreementCategory.mailSMS
            default: return PushAgreementCategory.push
            }
        }
        let agreementStatus: Int
        var isAgree: Bool {
            switch agreementStatus {
            case 0: return false
            case 1: return true
            default: return false
            }
        }

        init() {
            self.agreementCd = 1
            self.agreementStatus = 0
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<PushAgreementListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: PushAgreementListResultDto.Item.CodingKeys.self)
            self.agreementCd = try container
                .decodeIfPresent(Int.self, forKey: PushAgreementListResultDto.Item.CodingKeys.agreementCd) ?? 1
            self.agreementStatus = try container
                .decodeIfPresent(Int.self, forKey: PushAgreementListResultDto.Item.CodingKeys.agreementStatus) ?? 0
        }
    }
}

/*
 이벤트 베너 리스트
 */

struct EventBannerListResultDto: Codable {

    let list: [Item]

    struct Item: Codable {
        let eventId: String
        let eventName: String
        let cardImgUrl: String
        let detailPath: String

        init() {
            self.eventId = ""
            self.eventName = ""
            self.cardImgUrl = ""
            self.detailPath = ""
        }

        init(eventId: String,
             eventName: String,
             cardImgUrl: String,
             detailPath: String) {
            self.eventId = eventId
            self.eventName = eventName
            self.cardImgUrl = cardImgUrl
            self.detailPath = detailPath
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<EventBannerListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: EventBannerListResultDto.Item.CodingKeys.self)
            self.eventId = try container
                .decodeIfPresent(String.self, forKey: EventBannerListResultDto.Item.CodingKeys.eventId) ?? ""
            self.eventName = try container
                .decodeIfPresent(String.self, forKey: EventBannerListResultDto.Item.CodingKeys.eventName) ?? ""
            self.cardImgUrl = try container
                .decodeIfPresent(String.self, forKey: EventBannerListResultDto.Item.CodingKeys.cardImgUrl) ?? ""
            self.detailPath = try container
                .decodeIfPresent(String.self, forKey: EventBannerListResultDto.Item.CodingKeys.detailPath) ?? ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case list = "eventList"
    }
}

/*
 토리, 마일리지 조회 파라미터
 */

enum PointHistoryPeriod: String {
    case week = "1w"
    case month1 = "1m"
    case month6 = "6m"
    case year  = "1y"
    case all   = "all"
}

/*
 토리 충전 내역
 */

struct PointChargingHistoryListResultDto: Codable {
    let chargeHistoryList: [Item]

    struct Item: Codable {
        let chargeDay: String
        var date: String {
            chargeDay.toISODate()?.toFormat("yyyy-MM-dd") ?? ""
        }

        /*
         토리충전
         */
        let chargeType: String

        let quantity: Int

        init() {
            self.chargeDay = ""
            self.chargeType = ""
            self.quantity = 0
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<PointChargingHistoryListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: PointChargingHistoryListResultDto.Item.CodingKeys.self)
            self.chargeDay = try container
                .decodeIfPresent(String.self, forKey: PointChargingHistoryListResultDto.Item.CodingKeys.chargeDay) ?? ""
            self.chargeType = try container
                .decodeIfPresent(String.self,
                                 forKey: PointChargingHistoryListResultDto.Item.CodingKeys.chargeType) ?? ""
            self.quantity = try container
                .decodeIfPresent(Int.self, forKey: PointChargingHistoryListResultDto.Item.CodingKeys.quantity) ?? 0
        }
    }
}

/*
 토리, 마일리지 거래 내역
 */

struct PointTransactionListResultDto: Codable {
    let historyList: [Item]

    enum TransactionType: Int {
        case deposit = 1
        case withdraw = 2
    }

    struct Item: Codable {

        /*
         1: 입금
         2: 출금
         */
        let type: Int
        var transactionType: TransactionType {
            switch type {
            case 1: return TransactionType.deposit
            case 2: return TransactionType.withdraw
            default: return TransactionType.deposit
            }
        }
        let useTime: String
        var useDate: String {
            return useTime.toISODate()?.toFormat("yyyy.MM.dd") ?? ""
        }
        var useHourAndMin: String {
            return useTime.toISODate()?.toFormat("HH:mm") ?? ""
        }

        let history: String

        let quantity: Int

        /*
         유효기간
         */
        let expireTime: String
        var expireDate: String {
            return expireTime.toISODate()?.toFormat("yyyy.MM.dd") ?? ""
        }

        let txId: String

        init() {
            self.type = 1
            self.useTime = ""
            self.history = ""
            self.quantity = 0
            self.expireTime = ""
            self.txId = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<PointTransactionListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: PointTransactionListResultDto.Item.CodingKeys.self)
            self.type = try container
                .decodeIfPresent(Int.self, forKey: PointTransactionListResultDto.Item.CodingKeys.type) ?? 1
            self.useTime = try container
                .decodeIfPresent(String.self, forKey: PointTransactionListResultDto.Item.CodingKeys.useTime) ?? ""
            self.history = try container
                .decodeIfPresent(String.self, forKey: PointTransactionListResultDto.Item.CodingKeys.history) ?? ""
            self.quantity = try container
                .decodeIfPresent(Int.self, forKey: PointTransactionListResultDto.Item.CodingKeys.quantity) ?? 0
            self.expireTime = try container
                .decodeIfPresent(String.self, forKey: PointTransactionListResultDto.Item.CodingKeys.expireTime) ?? ""
            self.txId = try container
                .decodeIfPresent(String.self, forKey: PointTransactionListResultDto.Item.CodingKeys.txId) ?? ""
        }
    }
}

/*
 game List
 */
struct GameListResultDto: Codable {

    let gameList: [Item]

    struct Item: Codable {
        let gameType: Int
        let gameName: String
        let gameUrl: String
        let gameImgUrl: String

        init() {
            self.gameType = 0
            self.gameName = ""
            self.gameUrl = ""
            self.gameImgUrl = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<GameListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: GameListResultDto.Item.CodingKeys.self)
            self.gameType = try container
                .decodeIfPresent(Int.self, forKey: GameListResultDto.Item.CodingKeys.gameType) ?? 0
            self.gameName = try container
                .decodeIfPresent(String.self, forKey: GameListResultDto.Item.CodingKeys.gameName) ?? ""
            self.gameUrl = try container
                .decodeIfPresent(String.self, forKey: GameListResultDto.Item.CodingKeys.gameUrl) ?? ""
            self.gameImgUrl = try container
                .decodeIfPresent(String.self, forKey: GameListResultDto.Item.CodingKeys.gameImgUrl) ?? ""
        }
    }
}

/*
캠퍼스 뚜벅이 API result
 */
struct StepUpResultDto: Codable {

    let maxInsideStep: Int
    let maxOutsideStep: Int

    let insideRatio: Double
    let outsideRatio: Double

    let stepCondition: [PayItem]

    let inStepYnArr: [String?]
    let outStepYnArr: [String?]

    init() {
        self.maxInsideStep = 0
        self.maxOutsideStep = 0
        self.insideRatio = 0.0
        self.outsideRatio = 0.0
        self.stepCondition = []
        self.inStepYnArr = []
        self.outStepYnArr = []
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.maxInsideStep = try container.decodeIfPresent(Int.self, forKey: .maxInsideStep) ?? 0
        self.maxOutsideStep = try container.decodeIfPresent(Int.self, forKey: .maxOutsideStep) ?? 0
        self.insideRatio = try container.decodeIfPresent(Double.self, forKey: .insideRatio) ?? 0.0
        self.outsideRatio = try container.decodeIfPresent(Double.self, forKey: .outsideRatio) ?? 0.0
        self.stepCondition = try container.decode([StepUpResultDto.PayItem].self, forKey: .stepCondition)
        self.inStepYnArr = try container.decode([String].self, forKey: .inStepYnArr)
        self.outStepYnArr = try container.decode([String].self, forKey: .outStepYnArr)
    }

    struct PayItem: Codable {
        let key: String
        let value: String
        var stepCount: Int {
            return Int(value) ?? 0
        }

        init() {
            self.key = ""
            self.value = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<StepUpResultDto.PayItem.CodingKeys> = try decoder
                .container(keyedBy: StepUpResultDto.PayItem.CodingKeys.self)
            self.key = try container
                .decodeIfPresent(String.self, forKey: StepUpResultDto.PayItem.CodingKeys.key) ?? ""
            self.value = try container
                .decodeIfPresent(String.self, forKey: StepUpResultDto.PayItem.CodingKeys.value) ?? ""
        }
    }
}

/*
 캠퍼스 뚜벅이 Data를 정제하기 위한 자료구조
 */
struct StepUpPageDto {
    let checkInMaxStepCount: Int
    let checkOutMaxStepCount: Int

    let checkInPaymentList: [PaymentItem]
    let checkOutPaymentList: [PaymentItem]

    init() {
        self.checkInMaxStepCount = 0
        self.checkOutMaxStepCount = 0
        self.checkInPaymentList =  []
        self.checkOutPaymentList = []
    }

    init(checkInMaxStepCount: Int,
         checkOutMaxStepCount: Int,
         checkInPaymentList: [PaymentItem],
         checkOutPaymentList: [PaymentItem]) {
        self.checkInMaxStepCount = checkInMaxStepCount
        self.checkOutMaxStepCount = checkOutMaxStepCount
        self.checkInPaymentList = checkInPaymentList
        self.checkOutPaymentList = checkOutPaymentList
    }

    struct PaymentItem {
        let key: String
        let assetImageName: String
        let stepCount: Int
        let paymentMileage: Int

        var isPayment: Bool

        var isGet: Bool

        init() {
            self.key = ""
            self.assetImageName = ""
            self.stepCount = 0
            self.paymentMileage = 0
            self.isPayment = false
            self.isGet = false
        }

        init(key: String,
             assetImageName: String,
             stepCount: Int,
             paymentMileage: Int,
             isPayment: Bool,
             isGet: Bool) {
            self.key = key
            self.assetImageName = assetImageName
            self.stepCount = stepCount
            self.paymentMileage = paymentMileage
            self.isPayment = isPayment
            self.isGet = isGet
        }
    }
}

/*
 아바타 조회
 */
struct AvatarListResultDto: Codable {
    let wholeModelingAvatarList: [Item]

    struct Item: Codable {
        let id: Int
        let name: String
        let avatarType: String
        let groupCode: String
        let groupName: String

        var isSelect: Bool

        init() {
            id = 0
            name = ""
            avatarType = ""
            groupCode = ""
            groupName = ""
            isSelect = false
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<AvatarListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: AvatarListResultDto.Item.CodingKeys.self)
            self.id = try container
                .decodeIfPresent(Int.self, forKey: AvatarListResultDto.Item.CodingKeys.id) ?? 0
            self.name = try container
                .decodeIfPresent(String.self, forKey: AvatarListResultDto.Item.CodingKeys.name) ?? ""
            self.avatarType = try container
                .decodeIfPresent(String.self, forKey: AvatarListResultDto.Item.CodingKeys.groupCode) ?? ""
            self.groupCode = try container
                .decodeIfPresent(String.self, forKey: AvatarListResultDto.Item.CodingKeys.groupCode) ?? ""
            self.groupName = try container
                .decodeIfPresent(String.self, forKey: AvatarListResultDto.Item.CodingKeys.groupName) ?? ""
            self.isSelect = try container
                .decodeIfPresent(Bool.self, forKey: AvatarListResultDto.Item.CodingKeys.isSelect) ?? false
        }
    }
}

// 세미나 태그 상태
enum SeminarTagState: String {
    case standBy = "BEFORE_START"
    case closed = "END"
    case start = "START"
    case confirm = "CONFIRM"
    case reject = "REJECT"
    case confirmWait = "CONFIRM_WAIT"
}

// 세미나 리스트
struct SeminarListResultDto: Codable {

    let content: [Item]

    struct Item: Codable {
        let id: Int
        // 상태 확인 필요
        let room: Room
        let status: String
        var tagState: SeminarTagState {
            switch status {
            case "BEFORE_START":
                return SeminarTagState.standBy
            case "END":
                return SeminarTagState.closed
            case "START":
                return SeminarTagState.start
            case "CONFIRM":
                return SeminarTagState.confirm
            case "REJECT":
                return SeminarTagState.reject
            case "CONFIRM_WAIT":
                return SeminarTagState.confirmWait
            default:
                return .closed
            }
        }

        let title: String
        let description: String
        let teacherId: Int
        let teacherDescription: String
        let startAt: String
        var startDate: Date? {
            let startDate = startAt.stringToDate()
            return startDate
        }
        let endAt: String
        var endDate: Date? {
            let endDate = endAt.stringToDate()
            return endDate
        }
        var dateStr: String {
            let startStr = startDate?.dateToString(format: "yyyy-MM-dd (EE) HH:mm") ?? ""
            let endStr = endDate?.dateToString(format: "HH:mm") ?? ""
            return "\(startStr) ~ \(endStr)"
        }
        let curriculumImgUrl: String
        var password: String

        let secretYn: String
        var isSecret: Bool {
            return secretYn == "Y" ? true : false
        }
        let maxEnterCount: Int
        let currentParticipation: Int
        let requestParticipation: Int
        let showYn: String
        var isShow: Bool {
            return showYn == "Y" ? true : false
        }

        let teacherImageUrl: String

        var participationYn: String
        var isParticipate: Bool {
            return participationYn == "Y" ? true : false
        }

        init() {
            self.id = 0
            self.room = Room()
            self.status = ""
            self.title = ""
            self.description = ""
            self.teacherId = 0
            self.teacherDescription = ""
            self.startAt = ""
            self.endAt = ""
            self.curriculumImgUrl = ""
            self.password = ""
            self.secretYn = "N"
            self.maxEnterCount = 0
            self.currentParticipation = 0
            self.requestParticipation = 0
            self.showYn = "N"
            self.teacherImageUrl = ""
            self.participationYn = "Y"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            self.room = try container.decodeIfPresent(SeminarListResultDto.Item.Room.self, forKey: .room) ?? Room()
            self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
            self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
            self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
            self.teacherId = try container.decodeIfPresent(Int.self, forKey: .teacherId) ?? 0
            self.teacherDescription = try container.decodeIfPresent(String.self, forKey: .teacherDescription) ?? ""
            self.startAt = try container.decodeIfPresent(String.self, forKey: .startAt) ?? ""
            self.endAt = try container.decodeIfPresent(String.self, forKey: .endAt) ?? ""
            self.curriculumImgUrl = try container.decodeIfPresent(String.self, forKey: .curriculumImgUrl) ?? ""
            self.password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
            self.secretYn = try container.decodeIfPresent(String.self, forKey: .secretYn) ?? "N"
            self.maxEnterCount = try container.decodeIfPresent(Int.self, forKey: .maxEnterCount) ?? 0
            self.currentParticipation = try container.decodeIfPresent(Int.self, forKey: .currentParticipation) ?? 0
            self.requestParticipation = try container.decodeIfPresent(Int.self, forKey: .requestParticipation) ?? 0
            self.showYn = try container.decodeIfPresent(String.self, forKey: .showYn) ?? "N"
            self.teacherImageUrl = try container.decodeIfPresent(String.self, forKey: .teacherImageUrl) ?? ""
            self.participationYn = try container.decodeIfPresent(String.self, forKey: .participationYn) ?? "Y"
        }

        struct Room: Codable {
            let id: Int
            let createdAt: String
            let modifiedAt: String
            let roomType: String
            let roomSize: String
            let maxParticipation: Int
            let roomImageUrl: String

            init() {
                self.id = 0
                self.createdAt = ""
                self.modifiedAt = ""
                self.roomType = ""
                self.roomSize = ""
                self.maxParticipation = 0
                self.roomImageUrl = ""
            }

            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<SeminarListResultDto.Item.Room.CodingKeys> = try decoder
                    .container(keyedBy: SeminarListResultDto.Item.Room.CodingKeys.self)
                self.id = try container
                    .decodeIfPresent(Int.self, forKey: SeminarListResultDto.Item.Room.CodingKeys.id) ?? 0
                self.createdAt = try container
                    .decodeIfPresent(String.self, forKey: SeminarListResultDto.Item.Room.CodingKeys.createdAt) ?? ""
                self.modifiedAt = try container
                    .decodeIfPresent(String.self, forKey: SeminarListResultDto.Item.Room.CodingKeys.modifiedAt) ?? ""
                self.roomType = try container
                    .decodeIfPresent(String.self, forKey: SeminarListResultDto.Item.Room.CodingKeys.roomType) ?? ""
                self.roomSize = try container
                    .decodeIfPresent(String.self, forKey: SeminarListResultDto.Item.Room.CodingKeys.roomSize) ?? ""
                self.maxParticipation = try container
                    .decodeIfPresent(Int.self, forKey: SeminarListResultDto.Item.Room.CodingKeys.maxParticipation) ?? 0
                self.roomImageUrl = try container
                    .decodeIfPresent(String.self, forKey: SeminarListResultDto.Item.Room.CodingKeys.roomImageUrl) ?? ""
            }
        }

        struct SeminarFile: Codable {
            let createdAt: String
            let modifiedAt: String
            let id: Int
            let seminarId: Int
            let fileName: String
            let fileType: String

            init() {
                self.createdAt = ""
                self.modifiedAt = ""
                self.id = 0
                self.seminarId = 0
                self.fileName = ""
                self.fileType = ""
            }

            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<SeminarListResultDto.Item.SeminarFile.CodingKeys> = try decoder
                    .container(keyedBy: SeminarListResultDto.Item.SeminarFile.CodingKeys.self)
                self.createdAt = try container
                    .decodeIfPresent(String.self,
                                     forKey: SeminarListResultDto.Item.SeminarFile.CodingKeys.createdAt) ?? ""
                self.modifiedAt = try container
                    .decodeIfPresent(String.self,
                                     forKey: SeminarListResultDto.Item.SeminarFile.CodingKeys.modifiedAt) ?? ""
                self.id = try container
                    .decodeIfPresent(Int.self,
                                     forKey: SeminarListResultDto.Item.SeminarFile.CodingKeys.id) ?? 0
                self.seminarId = try container
                    .decodeIfPresent(Int.self,
                                     forKey: SeminarListResultDto.Item.SeminarFile.CodingKeys.seminarId) ?? 0
                self.fileName = try container
                    .decodeIfPresent(String.self,
                                     forKey: SeminarListResultDto.Item.SeminarFile.CodingKeys.fileName) ?? ""
                self.fileType = try container
                    .decodeIfPresent(String.self,
                                     forKey: SeminarListResultDto.Item.SeminarFile.CodingKeys.fileType) ?? "''"
            }
        }
    }
}

/*
 Live 세미나
 */
struct LiveSeminarListResultDto: Codable {

    let liveSeminarList: [Item]

    struct Item: Codable {
        let id: Int
        let title: String
        let status: String
        var tagState: SeminarTagState {
            switch status {
            case "BEFORE_START":
                return SeminarTagState.standBy
            case "END":
                return SeminarTagState.closed
            case "START":
                return SeminarTagState.start
            case "CONFIRM":
                return SeminarTagState.confirm
            case "REJECT":
                return SeminarTagState.reject
            case "CONFIRM_WAIT":
                return SeminarTagState.confirmWait
            default:
                return .closed
            }
        }
        let roomImageUrl: String
        let teacherImageUrl: String
        let teacherName: String
        let teacherId: Int
        let currentParticipation: Int
        let requestParticipation: Int
        let maxParticipation: Int
        let startAt: String
        var startDate: Date? {
            let start = startAt.stringToDate()
            return start
        }
        let endAt: String
        var endDate: Date? {
            let end = endAt.stringToDate()
            return end
        }
        var dateStr: String {
            let startStr = startDate?.dateToString(format: "yyyy-MM-dd (EE) HH:mm") ?? ""
            let endStr = endDate?.dateToString(format: "HH:mm") ?? ""
            return "\(startStr) ~ \(endStr)"
        }

        let description: String

        let secretYn: String
        var isSecret: Bool {
            return secretYn == "Y" ? true : false
        }

        let participationYn: String
        var isParticipate: Bool {
            return participationYn == "Y" ? true : false
        }

        init() {
            self.id = 0
            self.title = ""
            self.status = "END"
            self.teacherName = ""
            self.roomImageUrl = ""
            self.teacherImageUrl = ""
            self.teacherId = 0
            self.currentParticipation = 0
            self.requestParticipation = 0
            self.maxParticipation = 0
            self.startAt = ""
            self.endAt = ""
            self.description = ""
            self.secretYn = "N"
            self.participationYn = "Y"
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<LiveSeminarListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: LiveSeminarListResultDto.Item.CodingKeys.self)
            self.id = try container
                .decodeIfPresent(Int.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.id) ?? 0
            self.title = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.title) ?? ""
            self.status = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.status) ?? ""
            self.teacherName = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.teacherName) ?? ""
            self.roomImageUrl = try container
                .decodeIfPresent(String.self, forKey: .roomImageUrl) ?? ""
            self.teacherImageUrl = try container
                .decodeIfPresent(String.self, forKey: .teacherImageUrl) ?? ""
            self.teacherId = try container
                .decodeIfPresent(Int.self, forKey: .teacherId) ?? 0
            self.currentParticipation = try container
                .decodeIfPresent(Int.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.currentParticipation) ?? 0
            self.requestParticipation = try container
                .decodeIfPresent(Int.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.requestParticipation) ?? 0
            self.maxParticipation = try container
                .decodeIfPresent(Int.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.maxParticipation) ?? 0
            self.startAt = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.startAt) ?? ""
            self.endAt = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.endAt) ?? ""
            self.description = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.description) ?? ""
            self.secretYn = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.secretYn) ?? "N"
            self.participationYn = try container
                .decodeIfPresent(String.self, forKey: LiveSeminarListResultDto.Item.CodingKeys.participationYn) ?? "Y"
        }
    }
}

/*
 세미나 상세
 */
struct SeminarDetailResultDto: Codable {
    let title: String

    let description: String
    let teacherId: Int
    let roomImageUrl: String
    let status: String
    var tagState: SeminarTagState {
        switch status {
        case "BEFORE_START":
            return SeminarTagState.standBy
        case "END":
            return SeminarTagState.closed
        case "START":
            return SeminarTagState.start
        case "CONFIRM":
            return SeminarTagState.confirm
        case "REJECT":
            return SeminarTagState.reject
        case "CONFIRM_WAIT":
            return SeminarTagState.confirmWait
        default:
            return .closed
        }
    }

    let teacherName: String
    let startAt: String
    var startDate: Date? {
        let start = startAt.stringToDate()
        return start
    }
    let endAt: String
    var endDate: Date? {
        let end = endAt.stringToDate()
        return end
    }
    var dateStr: String {
        let startStr = startDate?.dateToString(format: "yyyy-MM-dd (EE) HH:mm") ?? ""
        let endStr = endDate?.dateToString(format: "HH:mm") ?? ""
        return "\(startStr) ~ \(endStr)"
    }
    let secretYn: String
    var isSecret: Bool {
        return secretYn == "Y" ? true : false
    }

    let participationCount: Int
    let maxEnterCount: Int
    let curriculumImageUrl: String

    let seminarUrl: String
    let roomId: Int

    let participateYn: String
    var isParticipate: Bool {
        return participateYn == "Y" ? true : false
    }

    init() {
        self.title = ""
        self.description = ""
        self.roomImageUrl = ""
        self.teacherId = 0
        self.status = "END"
        self.teacherName = ""
        self.startAt = ""
        self.endAt = ""
        self.secretYn = ""
        self.participationCount = 0
        self.maxEnterCount = 0
        self.curriculumImageUrl = ""

        self.seminarUrl = ""
        self.roomId = 0
        self.participateYn = "N"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.roomImageUrl = try container.decodeIfPresent(String.self, forKey: .roomImageUrl) ?? ""
        self.teacherId = try container.decodeIfPresent(Int.self, forKey: .teacherId) ?? 0
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? "END"

        self.teacherName = try container.decodeIfPresent(String.self, forKey: .teacherName) ?? ""
        self.startAt = try container.decodeIfPresent(String.self, forKey: .startAt) ?? ""
        self.endAt = try container.decodeIfPresent(String.self, forKey: .endAt) ?? ""
        self.secretYn = try container.decodeIfPresent(String.self, forKey: .secretYn) ?? ""
        self.participationCount = try container.decodeIfPresent(Int.self, forKey: .participationCount) ?? 0
        self.maxEnterCount = try container.decodeIfPresent(Int.self, forKey: .maxEnterCount) ?? 0
        self.curriculumImageUrl = try container.decodeIfPresent(String.self, forKey: .curriculumImageUrl) ?? ""

        self.seminarUrl = try container.decodeIfPresent(String.self, forKey: .seminarUrl) ?? ""
        self.roomId = try container.decodeIfPresent(Int.self, forKey: .roomId) ?? 0

        self.participateYn = try container.decodeIfPresent(String.self, forKey: .participateYn) ?? "N"
    }
}

struct ReqSeminarRoomPasswordResultDto: Codable {
    let password: String

    init() {
        self.password = ""
    }
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<ReqSeminarRoomPasswordResultDto.CodingKeys> = try decoder
            .container(keyedBy: ReqSeminarRoomPasswordResultDto.CodingKeys.self)
        self.password = try container
            .decodeIfPresent(String.self, forKey: ReqSeminarRoomPasswordResultDto.CodingKeys.password) ?? ""
    }
}

struct SeminarRoomTypeListResultDto: Codable {
    let roomList: [Item]

    struct Item: Codable {

        let roomId: Int
        let roomType: String
        let roomSize: String
        let roomName: String
        let maxParticipation: Int
        let roomImageUrl: String

        /*
         추천 메타
         */
        let uniCode: String

        var isSelect: Bool

        init() {
            self.roomId = 0
            self.roomType = ""
            self.roomSize = ""
            self.roomName = ""
            self.maxParticipation = 0
            self.roomImageUrl = ""
            self.uniCode = ""
            self.isSelect = false
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<SeminarRoomTypeListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: SeminarRoomTypeListResultDto.Item.CodingKeys.self)
            self.roomId = try container
                .decodeIfPresent(Int.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.roomId) ?? 0
            self.roomType = try container
                .decodeIfPresent(String.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.roomType) ?? ""
            self.roomSize = try container
                .decodeIfPresent(String.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.roomSize) ?? ""
            self.roomName = try container
                .decodeIfPresent(String.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.roomName) ?? ""
            self.maxParticipation = try container
                .decodeIfPresent(Int.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.maxParticipation) ?? 0
            self.roomImageUrl = try container
                .decodeIfPresent(String.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.roomImageUrl) ?? ""
            self.uniCode = try container
                .decodeIfPresent(String.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.uniCode) ?? ""
            self.isSelect = try container
                .decodeIfPresent(Bool.self, forKey: SeminarRoomTypeListResultDto.Item.CodingKeys.isSelect) ?? false
        }
    }
}

/*
 세미나 생성 파라미터
 */

struct CreateSeminarRoomParams {
    let roomId: Int
    let title: String
    let description: String
    let teacherDescription: String
    let startAt: Date?
    var startDate: String {
        return startAt?.dateToString() ?? "\(Date().dateToString())"
    }
    let endAt: Date?
    var endDate: String {
        return endAt?.dateToString() ?? "\(Date().dateToString())"
    }
//    let curriculumImgUrl: String
    let seminarUrl: String
    let password: String
    let isSecret: Bool
    var secretYn: String {
        return isSecret ? "Y" : "N"
    }
    let maxEnterCount: Int
    let seminarFilesId: Int
    let createRoomCount: Int?
}

/*
 세미나 입장
 */
struct EntranceSeparatedSeminarResultDto: Codable {
    let enterYn: String
    var isEnter: Bool {
        return enterYn == "Y" ? true : false
    }
    let unitySeminarId: String
    let seminarUrl: String
    let roomId: String

    init() {
        self.enterYn = "N"
        self.unitySeminarId = ""
        self.seminarUrl = ""
        self.roomId = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.enterYn = try container.decodeIfPresent(String.self, forKey: .enterYn) ?? "N"
        self.unitySeminarId = try container.decodeIfPresent(String.self, forKey: .unitySeminarId) ?? ""
        self.seminarUrl = try container.decodeIfPresent(String.self, forKey: .seminarUrl) ?? ""
        self.roomId = try container.decodeIfPresent(String.self, forKey: .roomId) ?? ""
    }

}

/*
 세미나 라운지 비디오 URL
 */
struct SeminarLoungeVideoUrlResultDto: Codable {
    let videoUrl: String

    init() {
        self.videoUrl = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.videoUrl = try container.decodeIfPresent(String.self, forKey: .videoUrl) ?? ""
    }
}

/*
 토리톡 친구리스트 파라미터
 */
struct ContractInfo: Codable {
    let profileName: String
    let phoneNum: String
}

/*
 토리톡 친구 리스트 정상님 Version
 */
struct FriendInfoList: Codable {
    var newFriendList: [FriendInfo]
    var acceptWaitFriendList: [FriendInfo]
    var friendListInRange: [RangeFriendInfo]
    var friendListOutRange: [RangeFriendInfo]
    var currentFriendList: [FriendInfo]
    init() {
        self.newFriendList = []
        self.acceptWaitFriendList = []
        self.friendListInRange = []
        self.friendListOutRange = []
        self.currentFriendList = []
    }
}

/*
 토리톡 차단 목록 결과
 */
struct BlockFriendListResultDto: Codable {
    var blockFriendList: [BlockFriendInfo]
}

/*
 친구 리스트 검색 결과
 */
struct SearchFriendList: Codable {
    var newFriendList: [FriendInfo]
    var waitFriendList: [FriendInfo]
    var friendListInRange: [RangeFriendInfo]
    var friendListOutRange: [RangeFriendInfo]
    var blockFriendList: [BlockFriendInfo]

    init() {
        self.newFriendList = []
        self.waitFriendList = []
        self.friendListInRange = []
        self.friendListOutRange = []
        self.blockFriendList = []
    }
}

struct LocationFriendListResultDto: Codable {
    let friendListInRange: [Item]
    let friendListOutRange: [Item]

    struct Item: Codable {
        let memberId: Int
        let imgUrl: String
        let profileName: String
        var locationBlockYn: String
        var isLocationBlock: Bool {
            switch locationBlockYn {
            case "Y": return true
            case "N": return false
            default: return false
            }
        }

        init(memberId: Int, imgUrl: String, profileName: String, locationBlockYn: String) {
            self.memberId = memberId
            self.imgUrl = imgUrl
            self.profileName = profileName
            self.locationBlockYn = locationBlockYn
        }

        init() {
            self.memberId = 0
            self.imgUrl = ""
            self.profileName = ""
            self.locationBlockYn = "N"
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<LocationFriendListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: LocationFriendListResultDto.Item.CodingKeys.self)
            self.memberId = try container
                .decodeIfPresent(Int.self, forKey: LocationFriendListResultDto.Item.CodingKeys.memberId) ?? 0
            self.imgUrl = try container
                .decodeIfPresent(String.self, forKey: LocationFriendListResultDto.Item.CodingKeys.imgUrl) ?? ""
            self.profileName = try container
                .decodeIfPresent(String.self, forKey: LocationFriendListResultDto.Item.CodingKeys.profileName) ?? ""
            self.locationBlockYn = try container
                .decodeIfPresent(String.self,
                                 forKey: LocationFriendListResultDto.Item.CodingKeys.locationBlockYn) ?? "N"
        }
    }
}

struct FriendInfo: Codable {
    let memberId: Int
    let profileName: String
    var isInvitedYn: String
    var isInvite: Bool { isInvitedYn == "Y" ? true : false }
    let imgUrl: String
    let phoneNum: String
    let isMember: Int
    var isToryUser: Bool { isMember == 1 ? true : false }

    init() {
        self.memberId = 0
        self.profileName = ""
        self.isInvitedYn = "N"
        self.imgUrl = ""
        self.phoneNum = ""
        self.isMember = 0
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decodeIfPresent(Int.self, forKey: .memberId) ?? 0
        self.profileName = try container.decodeIfPresent(String.self, forKey: .profileName) ?? ""
        self.isInvitedYn = try container.decodeIfPresent(String.self, forKey: .isInvitedYn) ?? "N"
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl) ?? ""
        self.phoneNum = try container.decodeIfPresent(String.self, forKey: .phoneNum) ?? ""
        self.isMember = try container.decodeIfPresent(Int.self, forKey: .isMember) ?? 0
    }
}

struct RangeFriendInfo: Codable {
    let memberId: Int
    let profileName: String
    var locationBlockYn: String
    var isLocationBlock: Bool { locationBlockYn == "Y" ? true : false }
    let blockYn: String
    var isBlock: Bool { blockYn == "Y" ? true : false }
    let imgUrl: String
    let phoneNum: String

    init() {
        self.memberId = 0
        self.profileName = ""
        self.locationBlockYn = "N"
        self.blockYn = "N"
        self.imgUrl = ""
        self.phoneNum = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decodeIfPresent(Int.self, forKey: .memberId) ?? 0
        self.profileName = try container.decodeIfPresent(String.self, forKey: .profileName) ?? ""
        self.locationBlockYn = try container.decodeIfPresent(String.self, forKey: .locationBlockYn) ?? "N"
        self.blockYn = try container.decodeIfPresent(String.self, forKey: .blockYn) ?? "N"
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl) ?? ""
        self.phoneNum = try container.decodeIfPresent(String.self, forKey: .phoneNum) ?? ""
    }
}

struct BlockFriendInfo: Codable {
    let memberId: Int
    let imgUrl: String
    let profileName: String

    init() {
        self.memberId = 0
        self.imgUrl = ""
        self.profileName = ""
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.memberId = try container.decodeIfPresent(Int.self, forKey: .memberId) ?? 0
        self.imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl) ?? ""
        self.profileName = try container.decodeIfPresent(String.self, forKey: .profileName) ?? ""
    }
}

struct ChattingLoungeInviteFriendResult: Codable {
    let inviteYn: String
    var isInvite: Bool {
        inviteYn == "Y" ? true : false
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.inviteYn = try container.decodeIfPresent(String.self, forKey: .inviteYn) ?? "N"
    }
}

struct BannerEventAttribute: Codable {
    let eventBannerMgntID: Int
    let eventID, bannerAppURL, bannerLocation, bannerType: String
    let bannerImageURL: String
    let externURL, title: String
    let sortOrder: Int
    let startTime, endTime: String

    enum CodingKeys: String, CodingKey {
        case eventBannerMgntID = "eventBannerMgntId"
        case eventID = "eventId"
        case bannerAppURL = "bannerAppUrl"
        case bannerLocation, bannerType
        case bannerImageURL = "bannerImageUrl"
        case externURL = "externUrl"
        case title, sortOrder, startTime, endTime
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventBannerMgntID = try container.decodeIfPresent(Int.self, forKey: .eventBannerMgntID) ?? 0
        self.eventID = try container.decodeIfPresent(String.self, forKey: .eventID) ?? ""
        self.bannerAppURL = try container.decodeIfPresent(String.self, forKey: .bannerAppURL) ?? ""
        self.bannerLocation = try container.decodeIfPresent(String.self, forKey: .bannerLocation) ?? ""
        self.bannerType = try container.decodeIfPresent(String.self, forKey: .bannerType) ?? ""
        self.bannerImageURL = try container.decodeIfPresent(String.self, forKey: .bannerImageURL) ?? ""
        self.externURL = try container.decodeIfPresent(String.self, forKey: .externURL) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.sortOrder = try container.decodeIfPresent(Int.self, forKey: .sortOrder) ?? 0
        self.startTime = try container.decodeIfPresent(String.self, forKey: .startTime) ?? ""
        self.endTime = try container.decodeIfPresent(String.self, forKey: .endTime) ?? ""
    }
}
