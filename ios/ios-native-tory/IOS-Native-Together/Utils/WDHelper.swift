//
//  WilldHelper.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/17.
//

import UIKit

struct WDHelper {

    static let shared: WDHelper = WDHelper()
    private init() {}

    static func getWindow() -> UIWindow? {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }

    static func getTopMostViewController() -> UIViewController? {
        getRootViewController()?.topMostViewController
    }

    static func getRootViewController() -> UIViewController? {
        getWindow()?.rootViewController
    }

    static func numberToNumberSeparator(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","

        let formatterNumber = formatter.string(from: NSNumber(value: number))
        return formatterNumber ?? ""
    }

    static func numberToNumberSeparator(string number: String) -> String {
        let number = Int(number) ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","

        let formatterNumber = formatter.string(from: NSNumber(value: number))
        return formatterNumber ?? ""
    }

    static func convertSafeUrl(_ url: String) -> URL? {
        let safeUrl = url
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\\", with: "")
        return URL(string: safeUrl)
    }

    static func convertSafeUrlName(_ url: String) -> String {
        url
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\\", with: "")
    }

    static func convertSafeStr(_ str: String?) -> String? {
        str?
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\\", with: "")
    }

    static func safeEncoding(data: Encodable) -> String {
        let data = try? JSONEncoder().encode(data)
        let jsonStr = String(data: data ?? Data(), encoding: .utf8)
        let safeJson = convertSafeStr(jsonStr)
        return safeJson ?? ""
    }
}

extension String {
    /*
     String Format
     yyyy-MM-dd HH:mm:ss
     */
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension Date {
    func dateToString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: AppConfigure.local)
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}
