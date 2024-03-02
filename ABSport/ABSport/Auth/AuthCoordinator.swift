//
//  AuthCoordinator.swift
//  ABSport
//
//  Created by Егор Иванов on 29.02.2024.
//

import UIKit

// MARK: - Данные от пользователя
struct AuthUserData {
    var number: Int?
}

// MARK: - AuthCoordinator (Координатор, который отвечает за рег и логин) 
final class AuthCoordinator: Coordinator {
    
    var childCoodinator: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registrationController = RegistrationViewController()
        navigationController.setViewControllers([registrationController], animated: false)
    }
    
    func addDependency(_ coordinator: Coordinator) {
        childCoodinator.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        guard let index = childCoodinator.firstIndex(where: { coordinator === $0}) else { return }
        
        childCoodinator.remove(at: index)
    }
}
