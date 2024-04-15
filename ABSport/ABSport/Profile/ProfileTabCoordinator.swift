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
        let viewController = UIHostingController(rootView: ProfileView(
            settingsAction: { [weak self] in self?.goToSettings() },
            myFormAction: {[weak self] in self?.goToMyForm()},
            reciepAction: { [weak self] in self?.goToReciep() },
            plannerAction: {},
            logoutAction: {}))
        return viewController
    }()
    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
    
    func goToSettings() {
        let settingsViewController = UIHostingController(rootView: SettingsView())
        rootViewController.pushViewController(settingsViewController, animated: true)
    }
    
    func goToMyForm() {
        let myFowmViewController = UIHostingController(rootView: MyFormView())
        rootViewController.pushViewController(myFowmViewController, animated: true)
    }
    
    func goToReciep() {
        let reciepViewController = UIHostingController(rootView: ReciepView())
        rootViewController.pushViewController(reciepViewController, animated: true)
    }
    
    func logout() {
    }
}
