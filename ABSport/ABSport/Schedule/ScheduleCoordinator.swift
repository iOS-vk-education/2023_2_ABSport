//
//  ScheduleCoordinator.swift
//  ABSport
//
//  Created by Александр Бобрун on 21.03.2024.
//

import Foundation
import UIKit

final class ScheduleCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    init() {
        rootViewController = UINavigationController()
    }
    
    lazy var scheduleViewController: ScheduleViewController = {
        let dateFormatterManager = DateFormaterManagerImpl()
        let calendarManager = CalendarManagerImpl()
        let viewModel = ScheduleViewModelImpl(dateFormatterManager: dateFormatterManager,
                                              calendarManager: calendarManager)
        let viewController = ScheduleViewController(viewModel: viewModel)
        return viewController
    }()
    
    func start() {
        rootViewController.setViewControllers([scheduleViewController], animated: false)
    }
}
