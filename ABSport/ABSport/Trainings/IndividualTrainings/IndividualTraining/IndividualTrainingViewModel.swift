//
//  IndividualTrainingViewModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 24.04.2024.
//

import UIKit

protocol IndividualTrainingViewModelDelegate: AnyObject {
    func didTapChooseTrainerButton()
    func didTapChooseTrainingButton()
    func didTapChooseDateButton()
}

class IndividualTrainingViewModel: IndividualTrainingViewModelDelegate {
    
    weak var coordinator: IndividualTrainingCoordinator?
    
    func didTapChooseTrainerButton() {
        coordinator?.goToChooseTrainer()
    }
    
    func didTapChooseTrainingButton() {
        coordinator?.goToChooseTraining()
    }
    
    func didTapChooseDateButton() {
        coordinator?.goToReservation()
    }
}
