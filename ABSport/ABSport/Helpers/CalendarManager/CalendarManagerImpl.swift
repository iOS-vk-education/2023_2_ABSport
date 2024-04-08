//
//  CalendarManagerImpl.swift
//  ABSport
//
//  Created by Александр Бобрун on 29.03.2024.
//

import Foundation

final class CalendarManagerImpl: CalendarManager {
    
    private var calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.locale = Locale(identifier: "ru_RU")
        
        return calendar
    }()
    
    func sameDay(date1: Date, date2: Date) -> Bool {
        return calendar.isDate(date1, equalTo: date2, toGranularity: .day)
    }
    
    func daysInDifferentMonths(date1: Date, date2: Date) -> Bool {
        return !calendar.isDate(date1, equalTo: date2, toGranularity: .month)
    }
    
    func currentWeek(withThisDate currentDate: Date) -> [Date] {
        
        var dayOfWeek = calendar.component(.weekday, from: currentDate)
        if dayOfWeek == 1 {
            dayOfWeek = 7
        } else {
            dayOfWeek -= 1
        }
        let weekDates = calendar.range(of: .weekday,
                                       in: .weekOfYear,
                                       for: currentDate)!
            .compactMap {
                calendar.date(byAdding: .day,
                              value: $0 - dayOfWeek,
                              to: currentDate)
            }
        
        return weekDates
    }
    
    func addWeekToDate(date: Date) -> Date {
        guard let nextWeekDate = calendar.date(byAdding: .weekOfYear,
                                               value: 1,
                                               to: date) else {
            return Date()
        }
        return nextWeekDate
    }
    
    func subtractWeekToDate(date: Date) -> Date {
        guard let nextWeekDate = calendar.date(byAdding: .weekOfYear,
                                               value: -1,
                                               to: date) else {
            return Date()
        }
        return nextWeekDate
    }
    
    func nextWeek(fromDate date: Date) -> [Date] {
        let nextWeekDate = addWeekToDate(date: date)
        return currentWeek(withThisDate: nextWeekDate)
    }
    
    func previousWeek(fromDate date: Date) -> [Date] {
        let previousWeekDate = subtractWeekToDate(date: date)
        return currentWeek(withThisDate: previousWeekDate)
    }
    
    func currentMonth(withThisDate currentDate: Date) -> [Date] {
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month],
                                                                            from: currentDate))!
        var dayOfWeekOfFirstdayOfMonth = calendar.component(.weekday, from: startDate)
        if dayOfWeekOfFirstdayOfMonth == 1 {
            dayOfWeekOfFirstdayOfMonth = 7
        } else {
            dayOfWeekOfFirstdayOfMonth -= 1
        }
        
        var monthDates = calendar.range(of: .day,
                                   in: .month,
                                   for: currentDate)!
            .compactMap {
                calendar.date(byAdding: .day,
                                 value: $0 - 1,
                                 to: startDate)
        }
        
        for dayCounter in 1..<dayOfWeekOfFirstdayOfMonth {
            monthDates.insert(calendar.date(byAdding: .day,
                                            value: -dayCounter,
                                            to: startDate)!, at: 0)
        }
        
        return monthDates
    }
    
    func addMonthToDate(date: Date) -> Date {
        guard let nextMonthDate = calendar.date(byAdding: .month,
                                                value: 1,
                                                to: date) else {
            return Date()
        }
        return nextMonthDate
    }
    
    func subtractMonthToDate(date: Date) -> Date {
        guard let nextMonthDate = calendar.date(byAdding: .month,
                                                value: -1,
                                                to: date) else {
            return Date()
        }
        return nextMonthDate
    }
    
    func nextMonth(fromDate date: Date) -> [Date] {
        let nextMonthDate = addMonthToDate(date: date)
        return currentMonth(withThisDate: nextMonthDate)
    }
    
    func previousMonth(fromDate date: Date) -> [Date] {
        let previousMonthDate = subtractMonthToDate(date: date)
        return currentMonth(withThisDate: previousMonthDate)
    }
    
}
