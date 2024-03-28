//
//  TabBatCoordinator.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 28.03.2024.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    let tabBarController: UITabBarController
    
    var childCoodinator: [Coordinator] = []
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        print("tabbar coordinator started")
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        addDependency(mainCoordinator)
        print(childCoodinator)
        mainCoordinator.start()
    }
    
    func addDependency(_ coordinator: Coordinator) {
        childCoodinator.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        guard let index = childCoodinator.firstIndex(where: { coordinator === $0}) else { return }
        
        childCoodinator.remove(at: index)
    }
}
