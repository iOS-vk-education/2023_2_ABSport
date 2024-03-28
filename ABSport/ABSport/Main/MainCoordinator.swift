//
//  MainCoordinator.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 02.03.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoodinator: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //
        print("main coordinator started")
        let viewModel = MainViewModel()
        viewModel.coordinator = self
        let mainController = MainViewController(
            viewModel: viewModel
        )
        navigationController.setViewControllers([mainController], animated: false)
    }
    
    func showGroupTraining() {
        //
        print("show group training")
        navigationController.pushViewController(GroupTrainingViewController(), animated: true)
    }
    
    func addDependency(_ coordinator: Coordinator) {
        childCoodinator.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        guard let index = childCoodinator.firstIndex(where: { coordinator === $0}) else { return }
        childCoodinator.remove(at: index)
    }
}
