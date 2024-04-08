//
//  DateFormatters.swift
//  ABSport
//
//  Created by Александр Бобрун on 21.03.2024.
//

import Foundation

enum FormatterTypes {
    case time
    case day
    case dayMonth
    case dayMonthYear
    case week
    case monthYear
    case weekDayMonthYear
}

protocol DateFormatterManager {
    func formate(date: Date, toType: FormatterTypes) -> String
}
