//
//  IndividualTrainingCoordinator.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 24.04.2024.
//

import UIKit

class IndividualTrainingCoordinator: Coordinator {

    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    lazy var individualTrainingViewController = {
        let viewModel = IndividualTrainingViewModel()
        viewModel.coordinator = self
        let viewController = IndividualTrainingViewController(viewModel: viewModel)
        
        viewController.navigationItem.backButtonTitle = ""
        return viewController
    }()
    
    func start() {
        rootViewController.pushViewController(individualTrainingViewController, animated: false)
    }
    
    func goToChooseTrainer() {
        let chooseTrainerViewController = ChooseIndividualTrainerViewController()
        rootViewController.pushViewController(chooseTrainerViewController, animated: true)
    }
    
    func goToChooseTraining() {
        let chooseTrainingViewController = ChooseIndividualTrainingViewController()
        rootViewController.pushViewController(chooseTrainingViewController, animated: true)
    }
    
    func goToReservation() {
        let reservationCoordinator = ReservationCoordinator(rootViewController: rootViewController)
        reservationCoordinator.start()
    }
}
