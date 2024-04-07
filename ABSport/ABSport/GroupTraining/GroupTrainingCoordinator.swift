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
        let vc = GroupTrainingViewController()
        vc.chooseTrainerRequested = { [weak self] in self?.goToChooseTrainer()}
        vc.chooseTrainingRequested = { [weak self] in self?.goToChooseTraining()}
        vc.chooseDataRequested = {}
        return vc
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
