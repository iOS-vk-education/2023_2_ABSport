//
//  ReservationViewModel.swift
//  ABSport
//
//  Created by Александр Бобрун on 01.04.2024.
//

import Foundation

enum ReservationViewModelEvent {
    case tapOnDay(withDate: Date)
    case tapOnTimeSlot(withReservation: Reservation)
    case openCurrentWeek
    case openPreviousWeek
    case openNextWeek
    case tapOnChooseButton(withDate: String)
}

struct ReservationViewModelState {
    var type: ReservationModuleType
    var currentDate = Date()
    var availableTimeSlots: [Reservation] = []
    var currentWeek: [Date] = []
    var choosenTime = "0"
    var chooseButtonDisabled = true
    var timeSlotsLoaded = false
}

protocol ReservationViewModel: ObservableObject {
    
    var state: ReservationViewModelState { get set }
    func handle(_ event: ReservationViewModelEvent)
    
    func formate(date: Date, toType: FormatterTypes) -> String
    
    func sameDay(date1: Date, date2: Date) -> Bool
}
