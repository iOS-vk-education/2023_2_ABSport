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

struct Training {
    var trainerName: String?
    var trainerId: String?
    var trainingType: ReservationType
    var trainingDate: Date?
    var reservation: Reservation?
}
