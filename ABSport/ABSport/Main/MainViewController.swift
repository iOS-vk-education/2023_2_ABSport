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
<<<<<<< HEAD
    var groupTrainingRequested: () -> () = {}
    var trainingRequested: () -> () = {}
=======
    var groupTrainingRequested: () -> Void = {}
    var trainigRequested: () -> Void = {}
>>>>>>> f2bfe71f949b0ad29191336d18515b85e49550d1
    
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
