//
//  MainCoordinator.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 02.03.2024.
//

import UIKit

class MainTabCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    init() {
        let backIcon = UIImage(systemName: "chevron.backward")?.withTintColor(
            UIColor(named: "backIconColor") ?? .black,
            renderingMode: .alwaysOriginal)
        rootViewController = UINavigationController()
        rootViewController.navigationBar.backIndicatorImage = backIcon
        rootViewController.navigationBar.backIndicatorTransitionMaskImage = backIcon
    }
    
    lazy var mainViewController: MainViewController = {
        let viewController = MainViewController()
        
        viewController.groupTrainingRequested = { [weak self] in
            self?.goToGroupTraining()}
        viewController.individualTrainingRequested = { [weak self] in
            self?.goToIndividualTraining()}
        
        viewController.navigationItem.backButtonTitle = ""
        return viewController
    }()
    
    func start() {
        rootViewController.setViewControllers([mainViewController], animated: false)
    }
    
    func goToGroupTraining() {
        let groupTrainingCoordinator = GroupTrainingCoordinator(rootViewController: rootViewController)
        self.childCoordinators.append(groupTrainingCoordinator)
        TrainingRegistation.shared.isIndividual = false
        groupTrainingCoordinator.start()
    }
    
    func goToIndividualTraining() {
        let groupTrainingCoordinator = GroupTrainingCoordinator(rootViewController: rootViewController)
        self.childCoordinators.append(groupTrainingCoordinator)
        TrainingRegistation.shared.isIndividual = true
        groupTrainingCoordinator.start()
    }
}
