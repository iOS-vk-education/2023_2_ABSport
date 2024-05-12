//
//  TrainingModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 12.05.2024.
//

import Foundation
enum TrainingType {
    case bike
    case running
    case power
}

struct Training {
    var trainers: [Trainer]
    var trainingType: TrainingType
    var date: Date
}

struct Trainer {
    var trainerName: String
}
