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
    
    func start() {
        //
    }
    
    func addDependency(_ coordinator: Coordinator) {
        childCoodinator.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        guard let index = childCoodinator.firstIndex(where: { coordinator === $0}) else { return }
        childCoodinator.remove(at: index)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
