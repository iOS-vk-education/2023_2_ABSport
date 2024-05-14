//
//  ReservationManager.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 13.03.2024.
//

import Foundation

// TEMP (JUST MOCK)
final class ReservationManager {
    
    static let shared = ReservationManager()
    
    var allTimeSlots: [String: [Reservation]] = [:]
    var activeReservations:  [String: [Reservation]] = [:]
    
    private let dateFormatter = DateFormaterManagerImpl()
    
    private init() {
    }
    
    func allReservations(complition: @escaping ([String: [Reservation]]) -> Void ) {
        // MARK: to fetch
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let fetchedUser = UserManager.shared.user
            
            var reservationDictionary: [String: [Reservation]] = [:]
            for item in fetchedUser.reservations {
                if reservationDictionary[self.dateFormatter.formate(date: item.startDate,
                                                                    toType: .dayMonthYear)] != nil {
                    reservationDictionary[self.dateFormatter.formate(date: item.startDate,
                                                                     toType: .dayMonthYear)]?.append(item)
                } else {
                    reservationDictionary[self.dateFormatter.formate(date: item.startDate,
                                                                     toType: .dayMonthYear)] = [item]
                }
            }
            complition(reservationDictionary)
        }
    }
}
