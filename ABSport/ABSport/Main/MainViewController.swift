//
//  ViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 28.02.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    
    private var mainView = MainView(frame: UIScreen.main.bounds)
    
    init(viewModel: MainViewModel?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.didTapGroupTrainingButton = { [weak self] in
            self?.viewModel?.didTapGroupTrainingButton()
        }
        
        mainView.didTapLaundryButton = { [weak self] in
            self?.viewModel?.didTapLaundryButton()
        }
        
        mainView.didTapLectionButton = { [weak self] in
            self?.viewModel?.didTapLectionButton()
        }
        
        mainView.didTapMassageButton = { [weak self] in
            self?.viewModel?.didTapMassageButton()
        }
        
        mainView.didTapSectionButton = { [weak self] in
            self?.viewModel?.didTapSectionButton()
        }
        
        mainView.didTapNutritionButton = { [weak self] in
            self?.viewModel?.didTapNutritionButton()
        }
        
        mainView.didTapBioimpedanceButton = { [weak self] in
            self?.viewModel?.didTapBioimpedanceButton()
        }
        
        mainView.didTapJoinClubButton = { [weak self] in
            self?.viewModel?.didTapJoinClubButton()
        }
        
        mainView.didTapCoffeeRideButton = { [weak self] in
            self?.viewModel?.didTapCoffeeRideButton()
        }
        
        mainView.didTapBikeStorageButton = { [weak self] in
            self?.viewModel?.didTapBikeStorageButton()
        }
        
        mainView.didTapBookingMachinesButton = { [weak self] in
            self?.viewModel?.didTapBookingMachinesButton()
        }
        
        mainView.didTapBookingRecoveryButton = { [weak self] in
            self?.viewModel?.didTapBookingRecoveryButton()
        }
        
        mainView.didTapPersonalTrainingButton = { [weak self] in
            self?.viewModel?.didTapPersonalTrainingButton()
        }
        
        viewModel?.viewDidLoad()
    }
}
