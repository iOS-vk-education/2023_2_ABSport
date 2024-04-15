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
<<<<<<< HEAD
        let vc = GroupTrainingViewController()
        vc.chooseTrainerRequested = { [weak self] in self?.goToChooseTrainer()}
        vc.chooseTrainingRequested = { [weak self] in self?.goToChooseTraining()}
        vc.chooseDataRequested = {}
        vc.navigationItem.backButtonTitle = ""
        return vc
=======
        let viewController = GroupTrainingViewController()
        viewController.chooseTrainerRequested = { [weak self] in self?.goToChooseTrainer()}
        viewController.chooseTrainingRequested = { [weak self] in self?.goToChooseTraining()}
        viewController.chooseDataRequested = {}
        return viewController
>>>>>>> f2bfe71f949b0ad29191336d18515b85e49550d1
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
}
