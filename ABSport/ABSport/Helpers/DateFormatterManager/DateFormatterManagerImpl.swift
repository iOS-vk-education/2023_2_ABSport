//
//  DateFormaterManagerImpl.swift
//  ABSport
//
//  Created by Александр Бобрун on 29.03.2024.
//

import Foundation

final class DateFormaterManagerImpl: DateFormatterManager {
    
    private var formatter = DateFormatter()
    
    func formate(date: Date, toType type: FormatterTypes) -> String {
        getFormatter(of: type).string(from: date)
    }
    
    private func getFormatter(of type: FormatterTypes) -> DateFormatter {
        formatter.locale = Locale(identifier: "ru_RU")
        switch type {
        case .time:
            formatter.dateFormat = "HH:mm"
        case .day:
            formatter.dateFormat = "d"
        case .dayMonth:
            formatter.dateFormat = "d MMMM"
        case .dayMonthYear:
            formatter.dateFormat = "d MMMM YYYY"
        case .week:
            formatter.dateFormat = "EE"
        case .monthYear:
            formatter.dateFormat = "YYYY MMMM"
        case .weekDayMonthYear:
            formatter.dateFormat = "eeee, d MMMM YYYY"
        }
        
        return formatter
    }
    
}
