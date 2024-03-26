//
//  UIButton+Extension.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 21.03.2024.
//

import UIKit

extension UIButton {
    func configureChooseTrainingButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.layer.cornerRadius = 12
        button.setTitle("Выбрать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        return button
    }
}
