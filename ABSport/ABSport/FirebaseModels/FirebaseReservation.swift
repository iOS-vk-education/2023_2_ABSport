//
//  FirebaseReservation.swift
//  ABSport
//
//  Created by Александр Бобрун on 17.05.2024.
//

import Foundation

struct FirebaseReservation: Identifiable, Codable {
    var id: String
    var type: String
    var isIndividual: Bool
    var numberOfFreeSlots: Int
    var trainerId: String
    var trainerName: String
    var userId: String
    var startDate: Date // or String
    var endDate: Date // or String
}
