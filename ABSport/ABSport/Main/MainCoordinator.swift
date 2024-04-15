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
        let vc = MainViewController()
        vc.groupTrainingRequested = { [weak self] in self?.goToGroupTraining()}
        vc.trainingRequested = {}
        vc.navigationItem.backButtonTitle = ""
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
