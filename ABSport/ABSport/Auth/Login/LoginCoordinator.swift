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
        self.rootViewController.navigationItem.hidesBackButton = true
    }
    
    lazy var loginViewController: UIViewController = {
        let viewController = UIHostingController(rootView:LoginView(regisrtAction: { [weak self] in self?.goToRegistr()} ).environmentObject(viewModel))
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationController?.navigationBar.isHidden = true
        return viewController
    }()
    
    func start() {
        rootViewController.setViewControllers([loginViewController], animated: false)
    }
    
    func goToRegistr() {
        let registrationViewController = UIHostingController(rootView: RegistrationView(loginAction: { [weak self] in self?.goToLogin()}).environmentObject(viewModel))
        registrationViewController.navigationItem.hidesBackButton = true
        rootViewController.pushViewController(registrationViewController, animated: true)
    }
    
    func goToLogin() {
        rootViewController.popViewController(animated: true)
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
