//
//  GroupTrainingCoordinator.swift
//  ABSport
//
//  Created by mac on 05.04.2024.
//

import UIKit

class GroupTrainingCoordinator: Coordinator {

    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    lazy var groupTrainingViewController = {
        let viewModel = GroupTrainingViewModel()
        viewModel.coordinator = self
        let viewController = GroupTrainingViewController(viewModel: viewModel)
        
        viewController.navigationItem.backButtonTitle = ""
        return viewController
    }()
    
    func start() {
        rootViewController.pushViewController(groupTrainingViewController, animated: true)
    }
    
    func goToChooseTrainer() {
        let chooseTrainerViewController = ChooseGroupTrainerViewController()
        rootViewController.pushViewController(chooseTrainerViewController, animated: true)
    }
    
    func goToChooseTraining() {
        let chooseTrainingViewController = ChooseGroupTrainingViewController()
        rootViewController.pushViewController(chooseTrainingViewController, animated: true)
    }
    
    func goToReservation() {
        let reservationCoordinator = ReservationCoordinator(rootViewController: rootViewController,
                                                            type: .groupTraining)
        reservationCoordinator.start()
    }
}
