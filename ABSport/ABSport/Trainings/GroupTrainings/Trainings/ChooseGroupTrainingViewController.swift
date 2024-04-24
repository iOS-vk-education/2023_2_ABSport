//
//  ChooseTrainingViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit

class ChooseGroupTrainingViewController: UIViewController, ChooseTrainingViewDelegate {
    
    private let chooseGroupTrainingView = ChooseTrainingView(frame: UIScreen.main.bounds)
    
    private let navBarTitleStackView: UIStackView = {
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: "GroupTrainers/backIconColor")
        titleLabel.text = "Групповые тренировки"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subtitleLabel.textAlignment = .left
        subtitleLabel.textColor = UIColor(named: "GroupTrainers/backIconColor")
        subtitleLabel.text = "Выбор тренировки"
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    override func loadView() {
        super.loadView()
        self.view = chooseGroupTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = navBarTitleStackView
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
