//
//  Reservation.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 13.03.2024.
//

import Foundation

enum ReservationType: String {
    case poolTraining = "Бассейн"
    case runningTraining = "Бег"
    case bicycleTraining = "Велосипед"
    case equipmentReservation = "Бронь станка"
}

struct Reservation: Identifiable, Hashable {
    let id: String
    var type: ReservationType
    var isIndividual: Bool
    var numberOfFreeSlots: Int
    var trainerName: String?
    let startDate: Date
    let endDate: Date
}
