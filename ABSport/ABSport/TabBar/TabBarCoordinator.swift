//
//  TabBarCoordinator.swift
//  ABSport
//
//  Created by mac on 04.04.2024.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinator {
    
    var rootViewController: UITabBarController
    
    var childCoordinators = [Coordinator]()

    init() {
        self.rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .lightGray
    }
    func start() {
        
        let mainCoordinator = MainTabCoordinator()
        mainCoordinator.start()
        self.childCoordinators.append(mainCoordinator)
        let mainViewController = mainCoordinator.rootViewController
        setup(vc: mainViewController,
              title: "Главная",
              imageName: "Home",
              tag: 0)
        
        let profileCoordinator = ProfileTabCoordinator()
        profileCoordinator.start()
        self.childCoordinators.append(profileCoordinator)
        let profileViewController = profileCoordinator.rootViewController
        setup(vc: profileViewController,
              title: "Профиль",
              imageName: "ProfileTab",
              tag: 1)
        
        self.rootViewController.viewControllers = [mainViewController, profileViewController]
    }
    
    func setup(vc: UIViewController, title: String, imageName: String, tag: Int) {
        let defaultImage = UIImage(named: imageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, tag: tag)
        vc.tabBarItem = tabBarItem
    }
    
}
