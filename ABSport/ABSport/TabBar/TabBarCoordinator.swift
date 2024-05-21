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
    
    var viewModel: AuthViewModel

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        self.rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
    }
    func start() {
        
        let scheduleCoordinator = ScheduleCoordinator()
        scheduleCoordinator.start()
        self.childCoordinators.append(scheduleCoordinator)
        let scheduleViewController = scheduleCoordinator.rootViewController
        setup(viewController: scheduleViewController,
              title: "Расписание",
              imageName: "Calendar",
              tag: 0)
        
        let mainCoordinator = MainTabCoordinator()
        mainCoordinator.start()
        self.childCoordinators.append(mainCoordinator)
        let mainViewController = mainCoordinator.rootViewController
        setup(viewController: mainViewController,
              title: "Главная",
              imageName: "Home",
              tag: 1)
        
        let profileCoordinator = ProfileTabCoordinator(viewModel: viewModel)
        profileCoordinator.start()
        self.childCoordinators.append(profileCoordinator)
        let profileViewController = profileCoordinator.rootViewController
        setup(viewController: profileViewController,
              title: "Профиль",
              imageName: "ProfileTab",
              tag: 2)
        
        self.rootViewController.viewControllers = [scheduleViewController, mainViewController, profileViewController]
        
        self.rootViewController.selectedIndex = 1
    }
    
    func setup(viewController: UIViewController, title: String, imageName: String, tag: Int) {
        let defaultImage = UIImage(named: imageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, tag: tag)
        viewController.tabBarItem = tabBarItem
    }
    
}
