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
    var reservationsFetched = false
    var currentMonth = Date()
    var calendarShowing = false
}

protocol ScheduleViewModel: ObservableObject {
    
    var state: ScheduleViewModelState { get set }
    func handle(_ event: ScheduleViewModelEvent)
    
    func formate(date: Date, toType: FormatterTypes) -> String
    
    func sameDay(date1: Date, date2: Date) -> Bool
    func daysInDifferentMonths(date1: Date, date2: Date) -> Bool
}
