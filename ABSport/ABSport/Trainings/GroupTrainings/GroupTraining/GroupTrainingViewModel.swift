//
//  GroupTrainingViewModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 22.04.2024.
//

import UIKit

protocol GroupTrainingViewModelDelegate: AnyObject {
    func didTapChooseTrainerButton()
    func didTapChooseTrainingButton()
    func didTapChooseDateButton()
}

class GroupTrainingViewModel: GroupTrainingViewModelDelegate {
    
    weak var coordinator: GroupTrainingCoordinator?
    
    var notificationCenter = NotificationCenter.default
    var trainerName: String?

    func didTapChooseTrainerButton() {
        coordinator?.goToChooseTrainer()
    }
    
    func didTapChooseTrainingButton() {
        coordinator?.goToChooseTraining()
    }
    
    func didTapChooseDateButton() {
        coordinator?.goToReservation()
    }
    
    func didTapChooseButton() {
//        coordinator?.start()
    }
}
