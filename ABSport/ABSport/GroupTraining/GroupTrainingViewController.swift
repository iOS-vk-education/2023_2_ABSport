//
//  GroupTrainingViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 03.03.2024.
//

import UIKit

class GroupTrainingViewController: UIViewController {
    
    private var groupTrainigView = GroupTrainingView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        super.loadView()
        self.view = groupTrainigView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
