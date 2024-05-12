//
//  ChooseTrainingViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit

class ChooseGroupTrainingViewController: UIViewController, ChooseTrainingViewDelegate {
    
    let viewModel: GroupTrainingViewModel?
    
    var trainingType: TrainingType?
    
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
    
    init(viewModel: GroupTrainingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        trainingType = .bike
    }
    
    func didTapChooseRunningButton() {
        print("running")
        trainingType = .running
    }
    
    func didTapChoosePowerButton() {
        print("power")
        trainingType = .power
    }
    
    func didTapChooseButton() {
        print("choose")
        viewModel?.coordinator?.updateTraining()
    }
}
