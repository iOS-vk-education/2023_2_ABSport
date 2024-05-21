//
//  Reservation.swift
//  SwiftUIPlayground
//
//  Created by Александр Бобрун on 13.03.2024.
//

import Foundation

enum ReservationType: String {
    case poolTraining = "Силовая тренировка"
    case runningTraining = "Бег"
    case bicycleTraining = "Велосипед"
    case equipmentReservation = "Бронь станка"
    case unknown = "Что-то пошло не так"
}

struct Reservation: Identifiable, Hashable {
    let id: String
    var type: ReservationType
    var isIndividual: Bool
    var numberOfFreeSlots: Int
    var trainerName: String?
    var trainerId: String?
    var startDate: Date
    var endDate: Date
}
