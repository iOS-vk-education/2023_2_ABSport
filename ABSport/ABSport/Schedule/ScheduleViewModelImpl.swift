//
//  ScheduleViewModelImpl.swift
//  ABSport
//
//  Created by Александр Бобрун on 30.03.2024.
//

import Foundation

final class ScheduleViewModelImpl: ScheduleViewModel {
    
    @Published var state: ScheduleViewModelState = ScheduleViewModelState()
    
    weak var coordinator: ScheduleCoordinator?

    private let calendarManager: CalendarManager
    private let dateFormatterManager: DateFormatterManager
    
    init(dateFormatterManager: DateFormatterManager, calendarManager: CalendarManager) {
        self.dateFormatterManager = dateFormatterManager
        self.calendarManager = calendarManager
        getDayReservations(date: state.currentDate)
    }
    
    /// function to formate Date to String
    func formate(date: Date, toType type: FormatterTypes) -> String {
        dateFormatterManager.formate(date: date, toType: type)
    }
    
    /// function to compare Date vs Date
    func sameDay(date1: Date, date2: Date) -> Bool {
        calendarManager.sameDay(date1: date1, date2: date2)
    }
    
    /// function to compare Date vs Date
    func daysInDifferentMonths(date1: Date, date2: Date) -> Bool {
        calendarManager.daysInDifferentMonths(date1: date1, date2: date2)
    }
    
    /// function to handle tap and slide events from view
    func handle(_ event: ScheduleViewModelEvent) {
        switch event {
        case .openCurrentMonth:
            getCurrentMonthDays()
        case .openNextMonth:
            openNextMonth()
        case .openPreviousMonth:
            openPreviousMonth()
        case .tapOnDay(withDate: let date):
            updateCurrentDay(tappedDay: date)
        case .tapOnShowCalendarButton:
            showOrDismissCalendar()
        case .tapOnCancelButton(reservation: let reservation):
            cancelReservation(reservation: reservation)
        }
    }
    
    /// function of showing or dismissing calendar
    func showOrDismissCalendar() {
        state.calendarShowing.toggle()
    }
    
    /// function to open next month
    func openNextMonth() {
        state.currentDate = calendarManager.addMonthToDate(date: state.currentDate)
        getCurrentMonthDays()
        getDayReservations(date: state.currentDate)
    }
    
    /// function to open previous month
    func openPreviousMonth() {
        state.currentDate = calendarManager.subtractMonthToDate(date: state.currentDate)
        getCurrentMonthDays()
        getDayReservations(date: state.currentDate)
    }
    
    /// function of updating current day after tap on it
    func updateCurrentDay(tappedDay day: Date) {
        if calendarManager.daysInDifferentMonths(date1: day, date2: state.currentDate) {
            state.currentDate = day
            getCurrentMonthDays()
        } else {
            state.currentDate = day
        }
        getDayReservations(date: state.currentDate)
    }
    
    /// function to get all month days for current month
    func getCurrentMonthDays() {
        state.currentMonthDates = calendarManager.currentMonth(withThisDate: state.currentDate)
        for day in state.currentMonthDates {
            getDayReservations(date: day)
        }
    }
    
    /// function to get reservations for current day
    func getDayReservations(date: Date) {
        
        state.reservationsFetched = false
        // MARK: - delete just mock
        ReservationManager.shared.fetchUserReservations(withId: "testUserId 103FC930-40D6-4B35-87DB-FD6749CDC305",
                                                        forDay: formate(date: date, toType: .dayMonth))
        { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let dictionary):
                self.state.allReservations[formate(date: date, toType: .dayMonthYear)] = dictionary
            case .failure(let error):
                print(error)
            }
            
            self.state.reservationsFetched = true
        }
    }
    
    /// function to cancel reservations
    func cancelReservation(reservation: Reservation) {
        ReservationManager.shared.deleteReservation(forDay: formate(date: state.currentDate, toType: .dayMonth),
                                                    reservation: reservation)
        self.state.allReservations[formate(date: state.currentDate, toType: .dayMonthYear)]?.removeAll(where: { $0.id == reservation.id})
        print("deleted: \(reservation.id)")
    }
    
}
