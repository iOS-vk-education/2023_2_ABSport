//
//  MainCoordinator.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 02.03.2024.
//

import UIKit

class MainTabCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    init() {
        rootViewController = UINavigationController()
    }
    
    lazy var mainViewController = {
        let vc = MainViewController()
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([mainViewController], animated: false)
    }
    
}
