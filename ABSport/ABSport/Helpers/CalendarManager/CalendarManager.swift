//
//  CalendarManager.swift
//  ABSport
//
//  Created by Александр Бобрун on 29.03.2024.
//

import Foundation

protocol CalendarManager {
    
    func isSameDay(date1: Date, date2: Date) -> Bool
    
    func areDaysFromDifferentMonths(date1: Date, date2: Date) -> Bool
    
    func getCurrentWeek(withThisDate currentDate: Date) -> [Date]
    func addWeekToDate(date: Date) -> Date
    func subtractWeekToDate(date: Date) -> Date
    func getNextWeek(fromDate date: Date) -> [Date]
    func getPreviousWeek(fromDate date: Date) -> [Date]
    
    func getCurrentMonth(withThisDate currentDate: Date) -> [Date]
    func addMonthToDate(date: Date) -> Date
    func subtractMonthToDate(date: Date) -> Date
    func getNextMonth(fromDate date: Date) -> [Date]
    func getPreviousMonth(fromDate date: Date) -> [Date]
}
