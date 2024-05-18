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
    
    init() {
        self.rootViewController = UINavigationController()
    }
    lazy var loginViewController: UIViewController = {
        let viewController = UIHostingController(rootView: LoginView())
        return viewController
    }()
    func start() {
        rootViewController.setViewControllers([loginViewController], animated: false)
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
