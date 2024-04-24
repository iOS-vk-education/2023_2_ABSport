//
//  GroupTrainingViewContoller.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit

final class GroupTrainingViewController: UIViewController {
    
    let viewModel: GroupTrainingViewModel?
    
    private let groupTrainingView = TrainingView(frame: UIScreen.main.bounds)
    
    private let navBarTitleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: "GroupTrainers/backIconColor")
        titleLabel.text = "Групповые тренировки"
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
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
        self.view = groupTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = navBarTitleStackView
        
        groupTrainingView.didTapChooseDateButton = { [weak self] in
            self?.viewModel?.didTapChooseDateButton()}
        
        groupTrainingView.didTapChooseTrainingButton = { [weak self] in
            self?.viewModel?.didTapChooseTrainingButton()}
        
        groupTrainingView.didTapChooseTrainerButton = { [weak self] in
            self?.viewModel?.didTapChooseTrainerButton()}
        
    }
}
