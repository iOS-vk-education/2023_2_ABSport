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
        rootViewController = UINavigationController()
    }
    
    lazy var mainViewController: MainViewController = {
        let vc = MainViewController()
        vc.groupTrainingRequested = { [weak self] in self?.goToGroupTraining()}
        vc.trainigRequested = {}
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([mainViewController], animated: false)
    }
    
    func goToGroupTraining() {
        let groupTrainingCoordinator = GroupTrainingCoordinator(rootViewController: rootViewController)
        self.childCoordinators.append(groupTrainingCoordinator)
        groupTrainingCoordinator.start()
    }
}
