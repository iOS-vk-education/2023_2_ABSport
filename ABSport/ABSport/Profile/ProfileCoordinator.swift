//
//  ProfileCoordinator.swift
//  ABSport
//
//  Created by mac on 04.04.2024.
//

import Foundation
import UIKit
import SwiftUI

final class ProfileTabCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    init() {
        rootViewController = UINavigationController()
    }
    lazy var profileViewController = {
        let vc = UIHostingController(rootView: ProfileView())
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
    
}
