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

        let viewController = GroupTrainingViewController()
        viewController.chooseTrainerRequested = { [weak self] in self?.goToChooseTrainer()}
        viewController.chooseTrainingRequested = { [weak self] in self?.goToChooseTraining()}
        viewController.chooseDataRequested = { [weak self] in self?.goToReservation()}

        viewController.navigationItem.backButtonTitle = ""
        return viewController
    }()
    
    func start() {
        rootViewController.pushViewController(groupTrainingViewController, animated: false)
    }
    
    func goToChooseTrainer() {
        let chooseTrainerViewController = ChooseTrainerViewController()
        rootViewController.pushViewController(chooseTrainerViewController, animated: true)
    }
    
    func goToChooseTraining() {
        let chooseTrainingViewController = ChooseTrainingViewController()
        rootViewController.pushViewController(chooseTrainingViewController, animated: true)
    }
    
    func goToReservation() {
        let reservationCoordinator = ReservationCoordinator(rootViewController: rootViewController)
        reservationCoordinator.start()
    }
}
