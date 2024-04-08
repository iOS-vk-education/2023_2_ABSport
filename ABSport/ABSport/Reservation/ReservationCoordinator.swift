//
//  ReservationCoordinator.swift
//  ABSport
//
//  Created by Александр Бобрун on 01.04.2024.
//

import Foundation
import UIKit

final class ReservationCoordinator: Coordinator {
    
    var childCoodinator: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //
    }
    
    func addDependency(_ coordinator: Coordinator) {
        childCoodinator.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        guard let index = childCoodinator.firstIndex(where: { coordinator === $0}) else { return }
        childCoodinator.remove(at: index)
    }
    
}
