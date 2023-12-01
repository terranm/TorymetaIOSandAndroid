//
//  DateManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/17.
//

import Foundation

func convertDate(year: String, month: String, day: String, hour: String, min: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd.HH.mm"
    let currentDate = dateFormatter.string(from: Date())
    let split = currentDate.split(separator: ".")
    let cYear = split[0]
    let cMonth = split[1]
    let cDay = split[2]
//    let cHour = split[3]
//    let cMin = split[4]

    if cYear == year {
        if cMonth == month {
            if cDay == day {
                switch Int(hour) ?? 0 {
                case 0..<12:
                    return localizable.dateManagerAM(hour, min)
                case 12:
                    return localizable.dateManagerPMOclock(min)
                case 13..<24:
                    let hour = Int(hour) ?? 0 - 12
                    return localizable.dateManagerPM(hour, min)
                case 24:
                    return localizable.dateManagerAMOclock(min)
                default:
                    return ""
                }
            } else {
                let days = (Int(cDay) ?? 0) - (Int(day) ?? 0)
                return localizable.dateManagerDaysAgo(days)
            }
        } else {
            let months = (Int(cMonth) ?? 0) - (Int(month) ?? 0)
            return localizable.dateManagerMonthsAgo(months)
        }
    } else {
        let years = (Int(cYear) ?? 0) - (Int(year) ?? 0)
        return localizable.dateManagerYearsAgo(years)
    }
}

func convertDate2(year: String, month: String, day: String, hour: String, min: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd.HH.mm"
    let currentDate = dateFormatter.string(from: Date())
    let split = currentDate.split(separator: ".")
    let cYear = split[0]
    let cMonth = split[1]
    let cDay = split[2]
//    let cHour = split[3]
//    let cMin = split[4]

    if cYear == year {
        if cMonth == month {
            if cDay == day {
                switch Int(hour) ?? 0 {
                case 0..<12:
                    return localizable.dateManagerAM(hour, min)
                case 12:
                    return localizable.dateManagerPMOclock(min)
                case 13..<24:
                    let hours = Int(hour) ?? 0 - 12
                    return localizable.dateManagerPM(hours, min)
                case 24:
                    return localizable.dateManagerAMOclock(min)
                default:
                    return ""
                }
            } else {
                return "\(year).\(month).\(day)"
            }
        } else {
            return "\(year).\(month).\(day)"
        }
    } else {
        return "\(year).\(month).\(day)"
    }
}
