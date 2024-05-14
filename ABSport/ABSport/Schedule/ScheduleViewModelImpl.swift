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
    }
    
    /// function to open previous month
    func openPreviousMonth() {
        state.currentDate = calendarManager.subtractMonthToDate(date: state.currentDate)
        getCurrentMonthDays()
    }
    
    /// function of updating current day after tap on it
    func updateCurrentDay(tappedDay day: Date) {
        if calendarManager.daysInDifferentMonths(date1: day, date2: state.currentDate) {
            state.currentDate = day
            getCurrentMonthDays()
        } else {
            state.currentDate = day
        }
    }
    
    /// function to get all month days for current month
    func getCurrentMonthDays() {
        state.currentMonthDates = calendarManager.currentMonth(withThisDate: state.currentDate)
        getCurrentMonthDaysReservations()
    }
    
    func getCurrentMonthDaysReservations() {
            
            state.reservationsFetched = false
            // MARK: - delete just mock
    //        UserManager.shared.addReservation([Reservation(id: UUID().uuidString,
    //                                                       type: .bicycleTraining,
    //                                                       isIndividual: true,
    //                                                       numberOfFreeSlots: 0,
    //                                                       trainerName: "obbrnu",
    //                                                       startDate: state.currentDate,
    //                                                       endDate: state.currentDate)])
    //        UserManager.shared.addReservation(Reservation(id: UUID().uuidString,
    //                                                      type: .runningTraining,
    //                                                      isIndividual: false,
    //                                                      numberOfFreeSlots: 0,
    //                                                      trainerName: "obbrnu",
    //                                                      startDate: state.currentDate,
    //                                                      endDate: state.currentDate))
    //        UserManager.shared.addReservation([Reservation(id: UUID().uuidString,
    //                                                       type: .equipmentReservation,
    //                                                       isIndividual: true,
    //                                                       numberOfFreeSlots: 0,
    //                                                       trainerName: "obbrnu",
    //                                                       startDate: state.currentDate,
    //                                                       endDate: state.currentDate),
    //                                           Reservation(id: UUID().uuidString,
    //                                                       type: .poolTraining,
    //                                                       isIndividual: false,
    //                                                       numberOfFreeSlots: 0,
    //                                                       trainerName: "obbrnu",
    //                                                       startDate: state.currentDate,
    //                                                       endDate: state.currentDate)])
            
    //        ReservationManager.shared.allReservations { [weak self] dictionary in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self else {
                    return
                }
                
    //            self.state.allReservations = dictionary
                self.state.allReservations = ReservationManager.shared.activeReservations
                print(ReservationManager.shared.activeReservations)
                self.state.reservationsFetched = true
            }
        }
    
}
