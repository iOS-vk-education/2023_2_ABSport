//
//  UserManager.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 14.03.2024.
//

import Foundation

// TEMP (JUST MOCK)
final class UserManager {
    
    static let shared = UserManager()
    
    var user = User(id: UUID().uuidString, reservations: [])
    
    private init() {
    }
    
    func addReservation(_ reservations: [Reservation]) {
        user.reservations.append(contentsOf: reservations)
    }
    
    func addReservation(_ reservation: Reservation) {
        user.reservations.append(reservation)
    }
}
