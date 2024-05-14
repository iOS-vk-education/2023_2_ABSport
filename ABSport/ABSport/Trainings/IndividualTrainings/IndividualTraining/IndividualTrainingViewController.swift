//
//  IndividualTrainingViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 24.04.2024.
//

import UIKit

final class IndividualTrainingViewController: UIViewController {
    
    let viewModel: IndividualTrainingViewModel?
    
    let individualTrainingView = TrainingView(frame: UIScreen.main.bounds)
    
    var chooseButton = UIButton().configureChooseTrainingButton()
    
    private let navBarTitleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: "GroupTrainers/backIconColor")
        titleLabel.text = "Персональные тренировки"
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
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
        self.view = individualTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = navBarTitleStackView
        setupChooseButton()
        individualTrainingView.didTapChooseDateButton = { [weak self] in
            self?.viewModel?.didTapChooseDateButton()}
        
        individualTrainingView.didTapChooseTrainingButton = { [weak self] in
            self?.viewModel?.didTapChooseTrainingButton()}
        
        individualTrainingView.didTapChooseTrainerButton = { [weak self] in
            self?.viewModel?.didTapChooseTrainerButton()}
        
        chooseButton.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
        
    }
    
    @objc
    private func didTapChooseButton() {
        self.viewModel?.didTapChooseButton()
    }
    
    private func setupChooseButton() {
        view.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            chooseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
