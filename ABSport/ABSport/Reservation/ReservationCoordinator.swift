//
//  ReservationCoordinator.swift
//  ABSport
//
//  Created by Александр Бобрун on 01.04.2024.
//

import Foundation
import UIKit

class ReservationCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    lazy var reservationViewController: ReservationViewController = {
        let dateFormatterManager = DateFormaterManagerImpl()
        let calendarManager = CalendarManagerImpl()
        let viewModel = ReservationViewModelImpl(dateFormatterManager: dateFormatterManager,
                                                 calendarManager: calendarManager)
        let viewController = ReservationViewController(viewModel: viewModel)
        return viewController
    }()
    
    func start() {
        rootViewController.pushViewController(reservationViewController, animated: false)
    }
    
}
