//
//  WDAnalyticsManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/03/23.
//

import Foundation
import FirebaseAnalytics

struct AnalyticsManager {
    static let osName = "ios"
    static let intro = "mobile_intro"
    static let campus = "mobile_campus"
    static let myPage = "mobile_mypage"
    static let toryTalk = "mobile_torytolk"
    static let m2e = "mobile_m2e"
    static let toryCharge = "mobile_torycharge"
    static let toryChargeHistory = "mobile_torycharge_history"
    static let toryChargeTransaction = "mobile_torycharge_transaction"
    static let mileageHistory = "mobile_mileage_history"

    static let nft = "mobile_nft"
    static let communityMarket = "mobile_community_market"
    static let communityGether = "mobile_community_gother"
    static let communityTalk = "mobile_community_talk"
    static let communityHelp = "mobile_community_help"
    static let schoolMeal = "mobile_school_meal"
    static let schoolEvent = "mobile_school_event"
    static let notice = "mobile_notice"
    static let setting = "mobile_setting"

    /*
     Seminar
     */
    static let seminarCenter = "mobile_seminacenter"
    static let toryLounge = "mobile_torylounge"
    static let seminarSearch = "mobile_seminasearch"
    static let seminarSchedule = "mobile_seminaschedule"
    static let mySeminarApply = "mobile_mysemina_apply"
    static let mySeminarSet = "mobile_mysemina_set"
    static let recommendMeta = "mobile_3dcampus"

    // MARK: - TTC Lecture
    static let mobileBottomTTCClassroom = "mobile_bottom_ttc_classroom"
    static let mobileTTCMyClassroom = "mobile_ttc_myclassroom"

    static func setAnalytics(_ id: String, _ params: [String: Any]) {
        guard AppConfigure.isProductRelease else { return }
        Analytics.logEvent(id, parameters: params)
        print("📈 Send analytics : \(id) / \(params)")
    }
}
