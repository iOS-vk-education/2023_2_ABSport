//
//  GroupTrainingViewContoller.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit
import Combine

final class GroupTrainingViewController: UIViewController, GroupTrainingViewDelegate {
        
    var viewModel: GroupTrainingViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    private var groupTrainingView = GroupTrainingView(frame: UIScreen.main.bounds)
    
    var chooseTrainerRequested: () -> Void = {}
    var chooseTrainingRequested: () -> Void = {}
    var chooseDataRequested: () -> Void = {}
    
    override func loadView() {
        super.loadView()
        self.view = groupTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTrainingView.navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = groupTrainingView.navBarTitleStackView
        groupTrainingView.delegate = self
        
        // Combine
        viewModel.isTrainerChoosePublisher
            .sink { [weak self] data in
                self?.updateTrainerButton(with: data)
            }
            .store(in: &cancellables)
    }
    
    func updateTrainerButton(with data: Bool) {
        // update UI
        print("[DEBUG] trainer is choose == \(data)")
        if data {
            groupTrainingView.addCheckMark()
        }
    }
    
    func didTapChooseTrainerButton() {
        print("trainer")
        chooseTrainerRequested()
    }
    
    func didTapChooseTainingButton() {
        print("training")
        chooseTrainingRequested()
    }
    
    func didTapChooseDateButton() {
        print("date")
        chooseDataRequested()
    }
}
