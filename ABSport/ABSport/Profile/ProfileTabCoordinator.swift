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
        let vc = UIHostingController(rootView: ProfileView(
            settingsAction: { [weak self] in self?.goToSettings() },
            myFormAction: {},
            reciepAction: { [weak self] in self?.goToReciep() },
            plannerAction: {},
            logoutAction: {}))
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
    
    func goToSettings() {
        let settingsViewController = UIHostingController(rootView: SettingsView())
        rootViewController.pushViewController(settingsViewController, animated: true)
    }
    
    func goToReciep() {
        let reciepViewController = UIHostingController(rootView: ReciepView())
        rootViewController.pushViewController(reciepViewController, animated: true)
    }
    
    func logout() {
    }
}
