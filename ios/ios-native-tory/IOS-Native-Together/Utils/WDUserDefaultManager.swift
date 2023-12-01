//
//  UserDefaultManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/24.
//

import Foundation
import SwiftDate

final class WDUserDefaultManager {

    static let shared = WDUserDefaultManager()
    private let user = UserDefaults.standard

    enum Key: String {
        case isAutoLogin = "isAutoLogin"
        case token = "token"
        case memberID = "memberId"
        case fcmToken = "fcmToken"
        case bcToken = "bcToken"   // NFT에서 사용하는 토큰
        case guideHome = "guide_home"    // NFT 소개 페이지 보여주기, 보여주지 않기 여부
        case guideMint = "guide_mint"
        case guideCollection = "guide_collection"
        case guideAuction = "guide_auction"
        case guideSale = "guide_sale"
        case guideMypage = "guide_mypage"  // 마이페이지 소개 페이지 보여주기, 보여주지 않기 여부
        case currentDate = "current_date"   // 걸음수 관련 데이터
        case checkInCount = "check_in_count"
        case checkOutCount = "check_out_count"
        case stepUpBeforeData = "step_up_before_data"
        case isStepUpBannerShow = "is_step_up_banner_show"  // 걸음수 베너 보여주기
        case isCampusTopColapse = "is_campus_top_colapse"    // Campus UI 유지 하기 위한 변수
        case isCampusRightColapse = "is_campus_right_colapse"
        case networkErrorInfo = "network_error_info"  // network error 판별
        case eventBannerCheckDate = "eventBannerCheckDate"
        case isEventBannerNotShow = "isEventBannerNotShow"
    }

    var isAutoLogin: Bool {
        user.bool(forKey: Key.isAutoLogin.rawValue)
    }
    var token: String? {
        user.string(forKey: Key.token.rawValue)
    }

    var memberId: Int {
        user.integer(forKey: Key.memberID.rawValue)
    }

    var fcmToken: String? {
        user.string(forKey: Key.fcmToken.rawValue)
    }

    var bcToken: String? {
        user.string(forKey: Key.bcToken.rawValue)
    }

    var guideHome: String {
        user.string(forKey: Key.guideHome.rawValue) ?? "true"
    }

    var guideMint: String {
        user.string(forKey: Key.guideMint.rawValue) ?? "true"
    }

    var guideCollection: String {
        user.string(forKey: Key.guideCollection.rawValue) ?? "true"
    }

    var guideAuction: String {
        user.string(forKey: Key.guideAuction.rawValue) ?? "true"
    }

    var guideSale: String {
        user.string(forKey: Key.guideSale.rawValue) ?? "true"
    }

    var guideMypage: String {
        user.string(forKey: Key.guideMypage.rawValue) ?? "true"
    }

    var currentDate: String {
        user.string(forKey: Key.currentDate.rawValue) ?? ""
    }

    var checkInCount: Int {
        user.integer(forKey: Key.checkInCount.rawValue)
    }

    var checkOutCount: Int {
        user.integer(forKey: Key.checkOutCount.rawValue)
    }

    var stepUpBeforeData: Int {
        user.integer(forKey: Key.stepUpBeforeData.rawValue)
    }

    var isStepUpBannerShow: String {
        user.string(forKey: Key.isStepUpBannerShow.rawValue) ?? "true"
    }

    var isCampusTopColapse: Bool {
        user.bool(forKey: Key.isCampusTopColapse.rawValue)
    }

    var isCampusRightColapse: Bool {
        user.bool(forKey: Key.isCampusRightColapse.rawValue)
    }

    var networkErrorInfo: String {
        user.string(forKey: Key.networkErrorInfo.rawValue) ?? ""
    }

    var eventBannerCheckDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        return user.string(forKey: Key.eventBannerCheckDate.rawValue) ?? dateString
    }

    var isEventBannerNotShow: Bool {
        user.bool(forKey: Key.isEventBannerNotShow.rawValue)
    }

    func save(value: Any?, key: Key) {
        self.user.setValue(value, forKey: key.rawValue)
    }

    /*
     걸음수 초기화
     */
    func initStepUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())

        if self.currentDate.isEmpty {
            save(value: currentDate, key: Key.currentDate)
        }

        if self.currentDate != currentDate {
            save(value: 0, key: Key.checkInCount)
            save(value: 0, key: Key.checkOutCount)
            save(value: currentDate, key: Key.currentDate)
        }
    }
}
