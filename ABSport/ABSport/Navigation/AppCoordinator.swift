//
//  MainCoordinator.swift
//  ABSport
//
//  Created by Егор Иванов on 29.02.2024.
//

import UIKit
import CoreData
import FirebaseAuth
import Combine

// MARK: - app coordinator (главный координатор, который пускает в приложение, либо в экран регистрации)
final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private var cancellables = Set<AnyCancellable>()
    
    var test: Int = 0
    
    init(window: UIWindow) {
        self.window = window
    }
    
    var childCoordinators = [Coordinator]()
    
    @MainActor var viewModel: AuthViewModel?
    
    var hardcode = false
    
    func start() {
        Task { @MainActor in
            self.viewModel = AuthViewModel()
            
            guard let viewModel = self.viewModel else { return }
            
            viewModel.$userSession
                .receive(on: DispatchQueue.main)
                .sink { [weak self] userSession in
                    self?.updateRootViewController(for: userSession)
                }
                .store(in: &cancellables)
            
            //updateRootViewController(for: viewModel.userSession)
            
        }
        window.makeKeyAndVisible()
    }
    
    @MainActor private func updateRootViewController(for userSession: FirebaseAuth.User?) {
        
        if userSession != nil {
            let tabBarCoordinator = TabBarCoordinator(viewModel: viewModel!)
            tabBarCoordinator.start()
            self.childCoordinators = [tabBarCoordinator]
            
            window.rootViewController = tabBarCoordinator.rootViewController
        } else {
            print("start login coordinator")
            let loginCoordinator = LoginCoordinator(viewModel: viewModel!)
            loginCoordinator.start()
            self.childCoordinators = [loginCoordinator]
            
            window.rootViewController = loginCoordinator.rootViewController
        }
    }
}




//if viewModel.userSession != nil {
//    
//} else {
//    
//}
//if viewModel.userSession != nil {
//    let tabBarCoordinator = TabBarCoordinator(viewModel: viewModel)
//    tabBarCoordinator.start()
//    self.childCoordinators = [tabBarCoordinator]
//    
//    window.rootViewController = tabBarCoordinator.rootViewController
//} else {
//    let loginCoordinator = LoginCoordinator(viewModel: viewModel)
//    loginCoordinator.start()
//    self.childCoordinators = [loginCoordinator]
//    
//    window.rootViewController = loginCoordinator.rootViewController
//}
