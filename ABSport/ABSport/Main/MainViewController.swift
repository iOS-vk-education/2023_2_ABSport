//
//  ViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 28.02.2024.
//

import UIKit

class MainViewController: UIViewController, MainViewDelegate {
    
//    var viewModel: MainViewModel?
//    var coordinator: MainCoordinator?

    var groupTrainingRequested: () -> Void = {}
    var trainingRequested: () -> Void = {}
    
    private var mainView = MainView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
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
        trainingRequested()
    }
    
    func didTapGroupTrainingButton() {
        //
        groupTrainingRequested()
    }
    
    func didTapJoinClubButton() {
        //
    }
}
