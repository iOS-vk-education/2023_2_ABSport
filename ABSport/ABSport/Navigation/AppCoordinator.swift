//
//  MainCoordinator.swift
//  ABSport
//
//  Created by Егор Иванов on 29.02.2024.
//

import UIKit

// MARK: - app coordinator (главный координатор, который пускает в приложение, либо в экран регистрации)
final class AppCoordinator: Coordinator {
    var childCoodinator: [Coordinator] = []
    
    var hardcode = true
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if hardcode {
            let mainViewModel = MainViewModel()
            print(mainViewModel)
            let tabBarController = TabBarController.createTabBar(mainViewModel: mainViewModel)
            window.rootViewController = tabBarController
            let tabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController)
            tabBarCoordinator.start()
            addDependency(tabBarCoordinator)
        } else {
            let navigationController = UINavigationController()
            window.rootViewController = navigationController
            let authCoordinator = AuthCoordinator(navigationController: navigationController)
            authCoordinator.start()
            addDependency(authCoordinator)
        }
        window.makeKeyAndVisible()
    }
    func addDependency(_ coordinator: Coordinator) {
        childCoodinator.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        guard let index = childCoodinator.firstIndex(where: { coordinator === $0}) else { return }
        
        childCoodinator.remove(at: index)
    }
}
