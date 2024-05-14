//
//  MainCoordinator.swift
//  ABSport
//
//  Created by Егор Иванов on 29.02.2024.
//

import UIKit
import CoreData

// MARK: - app coordinator (главный координатор, который пускает в приложение, либо в экран регистрации)
final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    var childCoordinators = [Coordinator]()
    
    var hardcode = true
    
    func start() {
        if hardcode {
            let tabBarCoordinator = TabBarCoordinator()
            tabBarCoordinator.start()
            self.childCoordinators = [tabBarCoordinator]
            
            window.rootViewController = tabBarCoordinator.rootViewController
        } else {
            let navigationController = UINavigationController()
            window.rootViewController = navigationController
            let authCoordinator = AuthCoordinator(navigationController: navigationController)
            authCoordinator.start()
        }
        window.makeKeyAndVisible()
    }
}
