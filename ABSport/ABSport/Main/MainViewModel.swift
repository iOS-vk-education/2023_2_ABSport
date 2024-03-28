//
//  MainViewModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 02.03.2024.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func viewDidLoad()
}

class MainViewModel: MainViewModelDelegate {
    
    var coordinator: MainCoordinator?
    
    func viewDidLoad() {
        //
    }
    
    func didTapGroupTrainingButton() {
        //
        print("group training in view model")
        coordinator?.showGroupTraining()
        print(" coordinator?.showGroupTraining() = \(coordinator?.showGroupTraining())")
    }
    
    func didTapSectionButton() {
        //
    }
    
    func didTapLectionButton() {
        //
    }
    
    func didTapCoffeeRideButton() {
        //
    }
    
    func didTapLaundryButton() {
        //
    }
    
    func didTapBikeStorageButton() {
        //
    }
    
    func didTapMassageButton() {
        //
    }
    
    func didTapNutritionButton() {
        //
    }
    
    func didTapBookingRecoveryButton() {
        //
    }
    
    func didTapBioimpedanceButton() {
        //
    }
    
    func didTapBookingMachinesButton() {
        //
    }
    
    func didTapPersonalTrainingButton() {
        //
    }
    
    func didTapJoinClubButton() {
        //
    }
}
