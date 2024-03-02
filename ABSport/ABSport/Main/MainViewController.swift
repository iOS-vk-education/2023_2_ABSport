//
//  ViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 28.02.2024.
//

import UIKit

class MainViewController: UIViewController {
    
//    var viewModel: MainViewModel?
//    var coordinator: MainCoordinator?
    private var mainView = MainView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonTargets()
    }
    
    // swiftlint:disable function_body_length
    private func setUpButtonTargets() {

        // Sport
        mainView.bookingMachinesButton.addTarget(
            self,
            action: #selector(bookingMachinesButtonDidTapped),
            for: .touchUpInside)
        mainView.personalTrainingButton.addTarget(
            self,
            action: #selector(personalTrainingButtonDidTapped),
            for: .touchUpInside)
        mainView.groupTrainigButton.addTarget(
            self,
            action: #selector(groupTrainingButtonDidTapped),
            for: .touchUpInside)
        mainView.joinClubButton.addTarget(
            self,
            action: #selector(joinButtonDidTapped),
            for: .touchUpInside)
        
        // Beauty
        mainView.massageButton.addTarget(
            self,
            action: #selector(massageButtonDidTapped),
            for: .touchUpInside)
        mainView.nutritionButton.addTarget(
            self,
            action: #selector(nutritionButtonDidTapped),
            for: .touchUpInside)
        mainView.bookingRecoveryButton.addTarget(
            self,
            action: #selector(bookingRecoveryButtonDidTapped),
            for: .touchUpInside)
        mainView.bioimpedanceButton.addTarget(
            self,
            action: #selector(bioimpedanceButtonDidTapped),
            for: .touchUpInside)
        
        // Other
        mainView.bikeStorageButton.addTarget(
            self,
            action: #selector(bikeStorageButtonDidTapped),
            for: .touchUpInside)
        mainView.laundryButton.addTarget(
            self,
            action: #selector(laundryButtonDidTapped),
            for: .touchUpInside)
        mainView.coffeeRideButton.addTarget(
            self,
            action: #selector(coffeeRideButtonDidTapped),
            for: .touchUpInside)
        mainView.lectionButton.addTarget(
            self,
            action: #selector(lectionButtonDidTapped),
            for: .touchUpInside)
        mainView.sectionButton.addTarget(
            self,
            action: #selector(sectionButtonDidTapped),
            for: .touchUpInside)
    }
    // swiftlint:enable function_body_length
    
    // Sport
    
    @objc
    private func bookingMachinesButtonDidTapped() {
        
    }
    
    @objc
    private func personalTrainingButtonDidTapped() {
        
    }
    
    @objc
    private func groupTrainingButtonDidTapped() {
        
    }
    
    @objc
    private func joinButtonDidTapped() {
        
    }
    
    // Beauty
    
    @objc
    private func massageButtonDidTapped() {
        
    }
    
    @objc
    private func nutritionButtonDidTapped() {
        
    }
    
    @objc
    private func bookingRecoveryButtonDidTapped() {
        
    }
    
    @objc
    private func bioimpedanceButtonDidTapped() {
        
    }
    
    // Other
    
    @objc
    private func bikeStorageButtonDidTapped() {
        
    }
    
    @objc
    private func laundryButtonDidTapped() {
        
    }
    
    @objc
    private func coffeeRideButtonDidTapped() {
        
    }
    
    @objc
    private func lectionButtonDidTapped() {
        
    }
    
    @objc
    private func sectionButtonDidTapped() {
        
    }

}
