//
//  ReservationViewModelImpl.swift
//  ABSport
//
//  Created by Александр Бобрун on 01.04.2024.
//

import Foundation
import UserNotifications

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
            tryToReserve(date: date)
        }
    }
    
    /// function to formate Date to String
    func formate(date: Date, toType type: FormatterTypes) -> String {
        dateFormatterManager.formate(date: date, toType: type)
    }
    
    /// function to compare Date vs Date
    func sameDay(date1: Date, date2: Date) -> Bool {
        calendarManager.sameDay(date1: date1, date2: date2)
    }
    
    /// function to choose time slot for reservation
    func chooseTimeSlot(_ reservation: Reservation) {
        state.choosenTime = formate(date: reservation.startDate, toType: .time)
        state.chooseButtonDisabled = false
    }
    
    /// function to choose time slot for reservation
    func setNewCurrentDay(withDate date: Date) {
        
        if state.currentDate != date {
            state.choosenTime = "0"
            state.timeSlotsLoaded = false
            state.chooseButtonDisabled = true
        }
        state.currentDate = date
        timeSlotsForCurrentDate()
    }
    
    /// function open current week
    func openCurrentWeek() {
        state.currentWeek = calendarManager.currentWeek(withThisDate: state.currentDate)
        timeSlotsForCurrentDate()
    }
    
    /// function open next week
    func openNextWeek() {
        
        state.choosenTime = "0"
        state.timeSlotsLoaded = false
        state.chooseButtonDisabled = true
        
        state.currentDate = calendarManager.addWeekToDate(date: state.currentDate)
        openCurrentWeek()
    }
    
    /// function open previous week
    func openPreviousWeek() {
        
        state.choosenTime = "0"
        state.timeSlotsLoaded = false
        state.chooseButtonDisabled = true
        
        state.currentDate = calendarManager.subtractWeekToDate(date: state.currentDate)
        openCurrentWeek()
    }
    
    /// function of getting timeslots for current week
    func timeSlotsForCurrentDate() {
        if state.timeSlotsLoaded == false {
            allTimeSlots(forCurrentDate: state.currentDate) { [weak self] result in
                
                guard let self else {
                    return
                }
                
                self.state.availableTimeSlots = result
                self.state.timeSlotsLoaded = true
            }
        }
    }
    
    /// function of reserving timeslot for current week
    func tryToReserve(date: String) {
        addNotification(time: 0.1,
                        title: "Уведомление о записи",
                        subtitle: "",
                        body: "Вы записаны на время: \(date)")
    }
    
    func allTimeSlots(forCurrentDate date: Date, complition: @escaping ([Reservation]) -> Void) {
        
        var allTimeSlots: [Reservation] = []
        
        // MARK: just mock
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            
            guard let self else {
                return
            }
            
            for index in 0...10 {
                let startDate = self.state.currentDate.addingTimeInterval(TimeInterval(index * 100))
                allTimeSlots.append(Reservation(id: UUID().uuidString,
                                                type: .bicycleTraining,
                                                isIndividual: true,
                                                numberOfFreeSlots: 1,
                                                trainerName: "obbrnu",
                                                startDate: startDate,
                                                endDate: self.state.currentDate))
            }
            
            complition(allTimeSlots)
        }
    }
    
    func addNotification(time: Double, title: String, subtitle: String, body: String) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default
    
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
    
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
            print("add")
        }
    
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success {
                        addRequest()
                    } else {
                        print("Authorization declined")
                    }
                }
            }
        }
    }
}
