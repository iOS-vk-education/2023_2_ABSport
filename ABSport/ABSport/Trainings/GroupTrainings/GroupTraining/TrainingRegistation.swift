//
//  TrainingRegistation.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 13.05.2024.
//

import Foundation

class TrainingRegistation {
    
    static let shared = TrainingRegistation()
    
    var trainingRegistation: Training = Training(trainingType: .unknown, trainingDate: "", training: .groupTraining)
    var trainingArray: [Training] = []
    
    // Список тренеров
    var groupTrainerList: [String] = [
        "Aлексей Жуков",
        "Иван Иванов",
        "Сергей Сидоров"
    ]
    
    var individualTrainerList: [String] = [
        "Александр Дуб",
        "Алексей Бояркин",
        "Даниил Малай"
    ]
    
    // Список дат
    var dates1: [Date] = [
    ]
    
    func getTraining(name: String, type: TrainingType, date: String) {
        trainingRegistation.trainerName = name
        trainingRegistation.trainingType = type
        trainingRegistation.trainingDate = date
    }
    
    func addTraining() {
        trainingArray.append(trainingRegistation)
        print(trainingArray)
    }
    
    func clearRegistation() {
        trainingRegistation.trainerName = ""
        trainingRegistation.trainingDate = ""
        trainingRegistation.trainingType = .unknown
    }
}
