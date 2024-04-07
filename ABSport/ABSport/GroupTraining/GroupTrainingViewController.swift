//
//  GroupTrainingViewContoller.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit

final class GroupTrainingViewController: UIViewController, GroupTrainingViewDelegate {
        
    private var groupTrainingView = GroupTrainingView(frame: UIScreen.main.bounds)
    
    var chooseTrainerRequested: () -> () = {}
    var chooseTrainingRequested: () -> () = {}
    var chooseDataRequested:() -> () = {}
    
    override func loadView() {
        super.loadView()
        self.view = groupTrainingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTrainingView.navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = groupTrainingView.navBarTitleStackView
        groupTrainingView.delegate = self
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
