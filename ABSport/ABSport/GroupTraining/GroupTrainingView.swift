//
//  GroupTrainingView.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 03.03.2024.
//

import UIKit

class GroupTrainingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "BackgroundColor")
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
    }
}
