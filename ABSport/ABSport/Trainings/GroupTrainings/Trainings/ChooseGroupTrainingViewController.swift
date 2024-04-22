//
//  ChooseTrainingViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit

class ChooseGroupTrainingViewController: UIViewController, ChooseGroupTrainingViewDelegate {
    
    private var chooseGroupTrainingView = ChooseGroupTrainingView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        super.loadView()
        self.view = chooseGroupTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseGroupTrainingView.navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = chooseGroupTrainingView.navBarTitleStackView
        chooseGroupTrainingView.delegate = self
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
