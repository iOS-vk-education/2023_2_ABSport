//
//  CalendarManager.swift
//  ABSport
//
//  Created by Александр Бобрун on 29.03.2024.
//

import Foundation

protocol CalendarManager {
    
    func sameDay(date1: Date, date2: Date) -> Bool
    
    func daysInDifferentMonths(date1: Date, date2: Date) -> Bool
    
    func currentWeek(withThisDate currentDate: Date) -> [Date]
    func addWeekToDate(date: Date) -> Date
    func subtractWeekToDate(date: Date) -> Date
    func nextWeek(fromDate date: Date) -> [Date]
    func previousWeek(fromDate date: Date) -> [Date]
    
    func currentMonth(withThisDate currentDate: Date) -> [Date]
    func addMonthToDate(date: Date) -> Date
    func subtractMonthToDate(date: Date) -> Date
    func nextMonth(fromDate date: Date) -> [Date]
    func previousMonth(fromDate date: Date) -> [Date]
}
