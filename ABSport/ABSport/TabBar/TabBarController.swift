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
    static func createTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let mainListTabBarController = createTabBarController(controller: MainViewController(),
                                                              title: "Главная",
                                                              nameImage: "Home",
                                                              tag: 0)
        let scheduleViewModel =  ScheduleViewModelImpl(dateFormatterManager: DateFormaterManagerImpl(),
                                                       calendarManager: CalendarManagerImpl())
        let scheduleViewController = ScheduleViewController(viewModel: scheduleViewModel)
        let scheduleTabBarController = createTabBarController(controller: scheduleViewController,
                                                              title: "Расписание",
                                                              nameImage: "Calendar",
                                                              tag: 1)
    
        tabBarController.setViewControllers([mainListTabBarController, scheduleTabBarController], animated: true)
        return tabBarController
    }
}
