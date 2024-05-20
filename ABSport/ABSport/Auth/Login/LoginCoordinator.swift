//
//  LoginCoordinator.swift
//  ABSport
//
//  Created by mac on 17.05.2024.
//

import Foundation
import UIKit
import SwiftUI

final class LoginCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.rootViewController = UINavigationController()
        self.viewModel = viewModel
    }
    
    lazy var loginViewController: UIViewController = {
        let viewController = UIHostingController(rootView:LoginView(regisrtAction: { [weak self] in self?.goToRegistr()} ).environmentObject(viewModel))
        return viewController
    }()
    
    func start() {
        rootViewController.setViewControllers([loginViewController], animated: false)
    }
    
    func goToRegistr() {
        let registrationViewController = UIHostingController(rootView: RegistrationView().environmentObject(viewModel))
        rootViewController.pushViewController(registrationViewController, animated: true)
    }
}

// final class LoginCoordinator: Coordinator {
//    
//    var rootViewController: UIViewController
//    
//    init(rootViewController: UIViewController) {
//        self.rootViewController = rootViewController
//    }
//    
//    func start() {
//        let loginViewController = UIHostingController(rootView: LoginView())
//        rootViewController.present(loginViewController, animated: true)
//    }
// }
