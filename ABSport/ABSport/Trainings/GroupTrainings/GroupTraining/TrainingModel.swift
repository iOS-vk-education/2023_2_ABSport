//
//  TrainingModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 13.05.2024.
//

import Foundation

enum TrainingType {
    case bike
    case running
    case power
    case machine
    case unknown
}

enum ReservationModuleType: String {
    case equipmentReservation = "Бронь станков"
    case soloTraining = "Персональная тренировка"
    case groupTraining = "Групповая тренировка"
}

struct Training {
    var trainerName: String?
    var trainingType: ReservationType
    var trainingDate: Date?
}
