//
//  ChooseTrainingViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit

class ChooseTrainingViewController: UIViewController, ChooseTrainingViewDelegate {
    
    private var chooseTrainingView = ChooseTrainingView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        super.loadView()
        self.view = chooseTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseTrainingView.navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = chooseTrainingView.navBarTitleStackView
        chooseTrainingView.delegate = self
    }
    
    func didTapChooseCyclingButton() {
        print("cycling")
    }
    
    func didTapChooseRunningButton() {
        print("running")
    }
    
    func didTapChoosePowerButton() {
        print("power")
    }
    
    func didTapChooseButton() {
        print("choose")
    }
}
