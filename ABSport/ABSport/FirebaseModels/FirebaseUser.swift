//
//  FirebaseUser.swift
//  ABSport
//
//  Created by Александр Бобрун on 17.05.2024.
//

import Foundation

struct FirebaseUser: Identifiable, Codable {
    var id: String
    var reservations: [FirebaseReservation] // or [String] with ids
}
