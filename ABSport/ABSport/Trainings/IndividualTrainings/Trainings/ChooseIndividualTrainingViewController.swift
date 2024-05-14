//
//  ChooseIndividualTrainingViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 24.04.2024.
//

import UIKit

class ChooseIndividualTrainingViewController: UIViewController, ChooseTrainingViewDelegate {
    
    var trainingType: ReservationType = .unknown
    
    let viewModel: IndividualTrainingViewModel?
    private let chooseIndividualTrainingView = ChooseTrainingView(frame: UIScreen.main.bounds)
    
    private let navBarTitleStackView: UIStackView = {
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: "GroupTrainers/backIconColor")
        titleLabel.text = "Персональные тренировки"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subtitleLabel.textAlignment = .left
        subtitleLabel.textColor = UIColor(named: "GroupTrainers/backIconColor")
        subtitleLabel.text = "Выбор тренировки"
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(viewModel: IndividualTrainingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = chooseIndividualTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = navBarTitleStackView
        chooseIndividualTrainingView.delegate = self
    }
    
    func didTapChooseCyclingButton() {
        print("cycling")
        trainingType = .bicycleTraining
    }
    
    func didTapChooseRunningButton() {
        print("running")
        trainingType = .runningTraining
    }
    
    func didTapChoosePowerButton() {
        print("power")
        trainingType = .poolTraining
    }
    
    func didTapChooseButton() {
        print("choose")
        viewModel?.coordinator?.updateTraining()
        
        // singleton
        TrainingRegistation.shared.trainingRegistation.trainingType = trainingType
    }
}
