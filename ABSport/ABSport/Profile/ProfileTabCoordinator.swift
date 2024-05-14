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
        let backIcon = UIImage(systemName: "chevron.backward")?.withTintColor(
            UIColor(named: "backIconColor") ?? .black,
            renderingMode: .alwaysOriginal)
        rootViewController = UINavigationController()
        rootViewController.navigationBar.backIndicatorImage = backIcon
        rootViewController.navigationBar.backIndicatorTransitionMaskImage = backIcon
    }
    lazy var profileViewController = {
        let viewController = UIHostingController(rootView: ProfileView(
            settingsAction: { [weak self] in self?.goToSettings() },
            myFormAction: {[weak self] in self?.goToMyForm()},
            reciepAction: { [weak self] in self?.goToReciep() },
            plannerAction: {},
            logoutAction: {}))
        viewController.navigationItem.backButtonTitle = ""
        viewController.view.backgroundColor = UIColor(named: "BackgroundColor")
        return viewController
    }()
    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
    
    func goToSettings() {
        let settingsViewController = UIHostingController(rootView: SettingsView())
        settingsViewController.view.backgroundColor = UIColor(named: "BackgroundColor")
        rootViewController.pushViewController(settingsViewController, animated: true)
    }
    
    func goToMyForm() {
        let myFowmViewController = UIHostingController(rootView:
                                                        MyFormView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext))
        rootViewController.pushViewController(myFowmViewController, animated: true)
    }
    
    func goToReciep() {
        let reciepViewController = UIHostingController(rootView: ReciepView())
        reciepViewController.view.backgroundColor = UIColor(named: "BackgroundColor")
        rootViewController.pushViewController(reciepViewController, animated: true)
    }
    
    func logout() {
    }
}
