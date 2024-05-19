//
//  ReservationManager.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 13.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// TEMP (JUST MOCK)
final class ReservationManager {
    
    static let shared = ReservationManager()
    
    var userReservationsCache: [String:[Reservation]] = [:] //dayMonth : [user reservations with this day]
    
    private let dateFormatter = DateFormaterManagerImpl()
    
    private let database = Firestore.firestore()
    
    private init() {
    }
    
    func allReservations(complition: @escaping ([String: [Reservation]]) -> Void ) {
        // MARK: to fetch
        DispatchQueue.main.async {
            let fetchedUser = UserManager.shared.user
            var reservationDictionary: [String: [Reservation]] = [:]
            for item in fetchedUser.reservations {
                reservationDictionary[self.dateFormatter.formate(date: item.startDate,
                                                                 toType: .dayMonthYear), default: [item]].append(item)
            }
            complition(reservationDictionary)
        }
    }
    
    func fetchTrainers(complition: @escaping (Result<Trainer, Error>) -> Void ) {
        
    }
    
    func fetchUserReservations(forDay: String, complition: @escaping ([Reservation]) -> Void) {
        
    }
    
    func sendReservation(reservation: FirebaseReservation) {
        DispatchQueue.main.async {
            do {
                try self.database.collection("test").document("test1").setData(from: reservation)
            } catch {
                print("Error adding messages to Firestore: \(error.localizedDescription)")
            }
        }
    }
}
