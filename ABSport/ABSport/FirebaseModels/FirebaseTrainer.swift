//
//  FirebaseTrainer.swift
//  ABSport
//
//  Created by Александр Бобрун on 17.05.2024.
//

import Foundation

struct FirebaseTrainer: Identifiable, Codable  {
    var id: String
    var types: [String]
    var reservations: [FirebaseReservation] // or [String] with ids
}
