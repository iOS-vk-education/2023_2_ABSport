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
<<<<<<< HEAD
        let vc = MainViewController()
        vc.groupTrainingRequested = { [weak self] in self?.goToGroupTraining()}
        vc.trainingRequested = {}
        vc.navigationItem.backButtonTitle = ""
        return vc
=======
        let viewController = MainViewController()
        viewController.groupTrainingRequested = { [weak self] in self?.goToGroupTraining()}
        viewController.trainigRequested = {}
        return viewController
>>>>>>> f2bfe71f949b0ad29191336d18515b85e49550d1
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
