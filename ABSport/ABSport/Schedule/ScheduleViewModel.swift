//
//  ScheduleViewModel.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 14.03.2024.
//

import Foundation

enum ScheduleViewModelEvent {
    case openCurrentMonth
    case openNextMonth
    case openPreviousMonth
    case tapOnDay(withDate: Date)
    case tapOnShowCalendarButton
}

struct ScheduleViewModelState {
    var currentDate = Date()
    var currentMonthDates: [Date] = []
    var allReservations: [String: [Reservation]] = [:]
    var areReservationsFetched = false
    var currentMonth = Date()
    var isCalendarShowing = false
}

protocol ScheduleViewModel: ObservableObject {
    
    var state: ScheduleViewModelState { get set }
    func handle(_ event: ScheduleViewModelEvent)
    
    func formate(date: Date, toType: FormatterTypes) -> String
    
    func isSameDay(date1: Date, date2: Date) -> Bool
    func areDaysFromDifferentMonths(date1: Date, date2: Date) -> Bool
}
