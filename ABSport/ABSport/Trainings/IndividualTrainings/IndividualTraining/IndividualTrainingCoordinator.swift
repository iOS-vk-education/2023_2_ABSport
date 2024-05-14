//
//  IndividualTrainingCoordinator.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 24.04.2024.
//

import UIKit

class IndividualTrainingCoordinator: Coordinator {

    var rootViewController: UINavigationController
    let viewModel = IndividualTrainingViewModel()
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    lazy var individualTrainingViewController = {
        
        viewModel.coordinator = self
        let viewController = IndividualTrainingViewController(viewModel: viewModel)
        
        viewController.navigationItem.backButtonTitle = ""
        return viewController
    }()
    
    func start() {
        rootViewController.pushViewController(individualTrainingViewController, animated: false)
    }
    
    func goToChooseTrainer() {
        let chooseTrainerViewController = ChooseIndividualTrainerViewController(viewModel: viewModel)
        rootViewController.pushViewController(chooseTrainerViewController, animated: true)
    }
    
    func goToChooseTraining() {
        let chooseTrainingViewController = ChooseIndividualTrainingViewController(viewModel: viewModel)
        rootViewController.pushViewController(chooseTrainingViewController, animated: true)
    }
    
    func goToReservation() {
        let reservationCoordinator = ReservationCoordinator(rootViewController: rootViewController, type: .soloTraining)
        reservationCoordinator.start()
    }
    
    func updateTrainer() {
        individualTrainingViewController.individualTrainingView.chooseTrainingButton.isEnabled = true
        individualTrainingViewController.individualTrainingView.chooseTrainingButton.isHidden = false
        individualTrainingViewController.individualTrainingView.addOKImage(
            to: individualTrainingViewController.individualTrainingView.chooseTrainerButton)
        rootViewController.popViewController(animated: true)
    }
    
    func updateTraining() {
        individualTrainingViewController.individualTrainingView.chooseDateButton.isEnabled = true
        individualTrainingViewController.individualTrainingView.chooseDateButton.isHidden = false
        individualTrainingViewController.individualTrainingView.addOKImage(
            to: individualTrainingViewController.individualTrainingView.chooseTrainingButton)
        rootViewController.popViewController(animated: true)
    }
    
    func updateDate() {
        individualTrainingViewController.chooseButton.isEnabled = true
        individualTrainingViewController.individualTrainingView.addOKImage(
            to: individualTrainingViewController.individualTrainingView.chooseDateButton)
        individualTrainingViewController.chooseButton.backgroundColor = UIColor(
            named: "GroupTrainers/ButtonColor")
        rootViewController.popViewController(animated: true)
    }
    
    func gotoMain() {
        rootViewController.popViewController(animated: true)
    }
}
