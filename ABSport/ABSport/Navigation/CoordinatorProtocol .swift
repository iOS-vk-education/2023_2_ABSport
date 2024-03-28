//
//  MainCoordinator .swift
//  ABSport
//
//  Created by Егор Иванов on 29.02.2024.
//

import UIKit

// MARK: - coordinator protocol (от него наследуются все координаторы) 
protocol Coordinator: AnyObject {
    var childCoodinator: [Coordinator] { get set }
    
    func start()
    func addDependency(_ coordinator: Coordinator)
    func removeDependency(_ coordinator: Coordinator)
}
