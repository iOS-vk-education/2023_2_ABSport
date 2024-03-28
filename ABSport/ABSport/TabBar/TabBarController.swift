//
//  TabBarController.swift
//  ABSport
//
//  Created by Егор Иванов on 11.03.2024.
//

import UIKit
func createTabBarController(controller: UIViewController,
                            title: String?,
                            nameImage: String,
                            tag: Int) -> UINavigationController {
    let tabBarElement = UINavigationController(rootViewController: controller)
    tabBarElement.tabBarItem = UITabBarItem(title: title,
                                            image: UIImage(named: nameImage),
                                            tag: tag)
    return tabBarElement
}
final class TabBarController {
    static func createTabBar(mainViewModel: MainViewModel) -> UITabBarController {
        let tabBarController = UITabBarController()
    
        let mainListTabBarController = createTabBarController(controller: MainViewController(viewModel: mainViewModel),
                                                              title: "Главная",
                                                              nameImage: "Home",
                                                              tag: 0)

        tabBarController.setViewControllers([mainListTabBarController], animated: true)
        return tabBarController
    }
}
