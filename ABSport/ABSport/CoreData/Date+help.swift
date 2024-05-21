//
//  Date+help.swift
//  ABSport
//
//  Created by mac on 18.05.2024.
//

import Foundation

func getCurrentDateTimeInLocalTimezone() -> Date {
    let currentDate = Date()
    let timeZone = TimeZone.current
    let secondsOffset = TimeInterval(timeZone.secondsFromGMT(for: currentDate))
    return Date(timeInterval: secondsOffset, since: currentDate)
}

func dateCustomFormatter(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter.string(from: date)
}
