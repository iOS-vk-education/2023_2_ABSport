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
    case unknown = "Что-то пошло не так"
}

struct Reservation: Identifiable, Hashable {
    let id: String
    let type: ReservationType
    let isIndividual: Bool
    var numberOfFreeSlots: Int
    let trainerName: String?
    let trainerId: String?
    let startDate: Date
    let endDate: Date
}
