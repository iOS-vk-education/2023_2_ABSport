//
//  ReservationViewModelImpl.swift
//  ABSport
//
//  Created by Александр Бобрун on 01.04.2024.
//

import Foundation
import UserNotifications

final class ReservationViewModelImpl: ReservationViewModel {
    
    @Published var state: ReservationViewModelState
    
    weak var coordinator: ScheduleCoordinator?
    
    private let calendarManager: CalendarManager
    private let dateFormatterManager: DateFormatterManager
    
    init(dateFormatterManager: DateFormatterManager, calendarManager: CalendarManager, type: ReservationModuleType) {
        self.dateFormatterManager = dateFormatterManager
        self.calendarManager = calendarManager
        state = ReservationViewModelState(type: type)
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
        state.choosenTime = reservation.startDate
        print(reservation.startDate)
        state.chooseButtonDisabled = false
    }
    
    /// function to choose time slot for reservation
    func setNewCurrentDay(withDate date: Date) {
        
        if state.currentDate != date {
            state.choosenTime = Calendar.current.date(bySettingHour: 00, 
                                                      minute: 00,
                                                      second: 1,
                                                      of: Date())!
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
        
        state.choosenTime = Calendar.current.date(bySettingHour: 00, 
                                                  minute: 00,
                                                  second: 1,
                                                  of: state.currentDate)!
        state.timeSlotsLoaded = false
        state.chooseButtonDisabled = true
        
        state.currentDate = calendarManager.addWeekToDate(date: state.currentDate)
        openCurrentWeek()
    }
    
    /// function open previous week
    func openPreviousWeek() {
        
        state.choosenTime = Calendar.current.date(bySettingHour: 00, 
                                                  minute: 00,
                                                  second: 1,
                                                  of: state.currentDate)!
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
        
        let startDate = state.choosenTime
        let endDate = startDate.addingTimeInterval(TimeInterval(3600))
        let reservation = Reservation(id: UUID().uuidString,
                                      type: .bicycleTraining,
                                      isIndividual: true,
                                      numberOfFreeSlots: 1,
                                      trainerName: "obbrnu",
                                      trainerId: "testTrainerId " + UUID().uuidString,
                                      startDate: startDate,
                                      endDate: endDate)
        ReservationManager.shared.sendReservations(forDay: formate(date: state.currentDate, toType: .dayMonth),
                                                   reservation: reservation)
    }
    
    func allTimeSlots(forCurrentDate date: Date, complition: @escaping ([Reservation]) -> Void) {
        
        var allTimeSlots: [Reservation] = []
        
        // MARK: just mock
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            
            guard let self else {
                return
            }
            
            for index in 0...11 {
                let startDate = Calendar.current.date(bySettingHour: 10,
                                                      minute: 00,
                                                      second: 0,
                                                      of: Date())!.addingTimeInterval(TimeInterval(index * 3600))
                let endDate = startDate.addingTimeInterval(TimeInterval(3600))
                allTimeSlots.append(Reservation(id: UUID().uuidString,
                                                type: .bicycleTraining,
                                                isIndividual: true,
                                                numberOfFreeSlots: 1,
                                                trainerName: "obbrnu",
                                                trainerId: "1",
                                                startDate: startDate,
                                                endDate: endDate))
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
