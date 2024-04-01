//
//  ReservationViewModelImpl.swift
//  ABSport
//
//  Created by Александр Бобрун on 01.04.2024.
//

import Foundation

final class ReservationViewModelImpl: ReservationViewModel {
    
    @Published var state: ReservationViewModelState = ReservationViewModelState()
    
    weak var coordinator: ScheduleCoordinator?
    
    private let calendarManager: CalendarManager
    private let dateFormatterManager: DateFormatterManager
    
    init(dateFormatterManager: DateFormatterManager, calendarManager: CalendarManager) {
        self.dateFormatterManager = dateFormatterManager
        self.calendarManager = calendarManager
    }
    
    func handle(_ event: ReservationViewModelEvent) {
        switch event {
        case .openCurrentWeek:
            openCurrentWeek()
        case .tapOnDay(withDate: let date):
            setNewCurrentDay(withDate: date)
        case .tapOnTimeSlot(withReservation: let reservation):
            chooseTimeSlot(reservation)
        case .openPreviousWeek:
            openPreviousWeek()
        case .openNextWeek:
            openNextWeek()
        case .tapOnChooseButton(withDate: let date):
            print("was choosed: \(date)")
        }
    }
    
    /// function to formate Date to String
    func formate(date: Date, toType type: FormatterTypes) -> String {
        dateFormatterManager.formate(date: date, toType: type)
    }
    
    /// function to compare Date vs Date
    func isSameDay(date1: Date, date2: Date) -> Bool {
        calendarManager.isSameDay(date1: date1, date2: date2)
    }
    
    /// function to choose time slot for reservation
    func chooseTimeSlot(_ reservation: Reservation) {
        state.choosenTime = formate(date: reservation.startDate, toType: .time)
        state.isChooseButtonDisabled = false
    }
    
    /// function to choose time slot for reservation
    func setNewCurrentDay(withDate date: Date) {
        
        if state.currentDate != date {
            state.choosenTime = "0"
            state.areTimeSlotsLoaded = false
            state.isChooseButtonDisabled = true
        }
        state.currentDate = date
        getTimeSlotsForCurrentDate()
    }
    
    /// function open current week
    func openCurrentWeek() {
        state.currentWeek = calendarManager.getCurrentWeek(withThisDate: state.currentDate)
        getTimeSlotsForCurrentDate()
    }
    
    /// function open next week
    func openNextWeek() {
        
        state.choosenTime = "0"
        state.areTimeSlotsLoaded = false
        state.isChooseButtonDisabled = true
        
        state.currentDate = calendarManager.addWeekToDate(date: state.currentDate)
        openCurrentWeek()
    }
    
    /// function open previous week
    func openPreviousWeek() {
        
        state.choosenTime = "0"
        state.areTimeSlotsLoaded = false
        state.isChooseButtonDisabled = true
        
        state.currentDate = calendarManager.subtractWeekToDate(date: state.currentDate)
        openCurrentWeek()
    }
    
    /// function of getting timeslots for current week
    func getTimeSlotsForCurrentDate() {
        if state.areTimeSlotsLoaded == false {
            getAllTimeSlots(forCurrentDate: state.currentDate) { [weak self] result in
                
                guard let self else {
                    return
                }
                
                self.state.availableTimeSlots = result
                self.state.areTimeSlotsLoaded = true
            }
        }
    }
    
    func getAllTimeSlots(forCurrentDate date: Date, complition: @escaping ([Reservation]) -> Void) {
        
        var allTimeSlots: [Reservation] = []
        
        // TODO: just mock
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            
            guard let self else {
                return
            }
            
            for index in 0...10 {
                allTimeSlots.append(Reservation(id: UUID().uuidString,
                                                type: .bicycleTraining,
                                                isIndividual: true,
                                                numberOfFreeSlots: 1,
                                                trainerName: "obbrnu",
                                                startDate: self.state.currentDate.addingTimeInterval(TimeInterval(index * 100)),
                                                endDate: self.state.currentDate))
            }
            
            complition(allTimeSlots)
        }
    }
}
