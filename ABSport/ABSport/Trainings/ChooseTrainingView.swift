//
//  ChooseTrainingView.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 10.03.2024.
//

import UIKit

protocol ChooseTrainingViewDelegate: AnyObject {
    func didTapChooseCyclingButton()
    func didTapChooseRunningButton()
    func didTapChoosePowerButton()
    func didTapChooseButton()
}

final class ChooseTrainingView: UIView {
    
    weak var delegate: ChooseTrainingViewDelegate?
    
    private var chooseButton = UIButton().configureChooseTrainingButton()
    
    private lazy var chooseCyclingButton: UIButton = {
        let button = configureTypeButton(imageName: "GroupTrainers/Cycling", title: "Велотренировка")
        button.translatesAutoresizingMaskIntoConstraints = false
        if !TrainingRegistation.shared.trainer!.reservationTypes.contains(ReservationType.bicycleTraining.rawValue) {
            button.isEnabled = false
            button.backgroundColor = UIColor(named: "DarkGrayColor")
        }
        
        return button
    }()
    
    private lazy var chooseRunningButton: UIButton = {
        let button = configureTypeButton(imageName: "GroupTrainers/Running", title: "Беговая тренировка")
        button.translatesAutoresizingMaskIntoConstraints = false
        if !TrainingRegistation.shared.trainer!.reservationTypes.contains(ReservationType.runningTraining.rawValue) {
            button.isEnabled = false
            button.backgroundColor = UIColor(named: "DarkGrayColor")
        }
        
        return button
    }()
    
    private lazy var choosePowerButton: UIButton = {
        let button = configureTypeButton(imageName: "GroupTrainers/QuickModeOn", title: "Силовая тренировка")
        button.translatesAutoresizingMaskIntoConstraints = false
        if !TrainingRegistation.shared.trainer!.reservationTypes.contains(ReservationType.poolTraining.rawValue) {
            button.isEnabled = false
            button.backgroundColor = UIColor(named: "DarkGrayColor")
        }
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "BackgroundColor")
        configureButtons()
        setUpButtonTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpButtonTargets() {
        chooseCyclingButton.addTarget(self, action: #selector(didTapCyclingButton), for: .touchUpInside)
        chooseRunningButton.addTarget(self, action: #selector(didTapRunningButton), for: .touchUpInside)
        choosePowerButton.addTarget(self, action: #selector(didTapPowerButton), for: .touchUpInside)
        chooseButton.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapChooseButton() {
        delegate?.didTapChooseButton()
    }
    
    @objc
    private func didTapCyclingButton() {
        chooseCyclingButton.layer.borderWidth = 4
        chooseCyclingButton.layer.borderColor = UIColor(named: "GroupTrainers/ButtonColor")?.cgColor
        chooseRunningButton.layer.borderWidth = 0
        choosePowerButton.layer.borderWidth = 0
        chooseButton.isEnabled = true
        chooseButton.backgroundColor = UIColor(named: "GroupTrainers/ButtonColor")
        delegate?.didTapChooseCyclingButton()
    }
    
    @objc
    private func didTapRunningButton() {
        chooseRunningButton.layer.borderWidth = 4
        chooseRunningButton.layer.borderColor = UIColor(named: "GroupTrainers/ButtonColor")?.cgColor
        chooseCyclingButton.layer.borderWidth = 0
        choosePowerButton.layer.borderWidth = 0
        chooseButton.isEnabled = true
        chooseButton.backgroundColor = UIColor(named: "GroupTrainers/ButtonColor")
        delegate?.didTapChooseRunningButton()
    }
    
    @objc
    private func didTapPowerButton() {
        choosePowerButton.layer.borderWidth = 4
        choosePowerButton.layer.borderColor = UIColor(named: "GroupTrainers/ButtonColor")?.cgColor
        chooseCyclingButton.layer.borderWidth = 0
        chooseRunningButton.layer.borderWidth = 0
        chooseButton.isEnabled = true
        chooseButton.backgroundColor = UIColor(named: "GroupTrainers/ButtonColor")
        delegate?.didTapChoosePowerButton()
    }
    
    private func configureTypeButton(imageName: String?, title: String) -> UIButton {
        
        let button = UIButton()
        let imageView = UIImageView()
        let label = UILabel()
        
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "GroupTrainers/TrainerButtonBackground")
        
        let viewWidth = UIScreen.main.bounds.width
        let ratio = viewWidth / 393
        label.font = UIFont.systemFont(ofSize: CGFloat(16 * ratio), weight: .semibold)
        label.textColor = UIColor(named: "GroupTrainers/TrainingText")
        label.numberOfLines = 1
        label.text = title
        label.textAlignment = .left
        
        imageView.image = UIImage(named: imageName ?? "")
        
        button.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 22),
            imageView.widthAnchor.constraint(equalToConstant: 38),
            imageView.heightAnchor.constraint(equalToConstant: 38),
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 17)
        ])
        
        button.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 21),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        return button
    }
    
    private func configureTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 1
        label.textColor = UIColor(named: "TextColor")
        label.text = title
        return label
    }
// MARK: - Layouts
    
    private func configureButtons() {
        
        self.addSubview(chooseCyclingButton)
        NSLayoutConstraint.activate([
            chooseCyclingButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            chooseCyclingButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseCyclingButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseCyclingButton.widthAnchor.constraint(equalToConstant: 361),
            chooseCyclingButton.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        self.addSubview(chooseRunningButton)
        NSLayoutConstraint.activate([
            chooseRunningButton.topAnchor.constraint(equalTo: chooseCyclingButton.bottomAnchor, constant: 8),
            chooseRunningButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseRunningButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseRunningButton.widthAnchor.constraint(equalToConstant: 361),
            chooseRunningButton.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        self.addSubview(choosePowerButton)
        NSLayoutConstraint.activate([
            choosePowerButton.topAnchor.constraint(equalTo: chooseRunningButton.bottomAnchor, constant: 8),
            choosePowerButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            choosePowerButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            choosePowerButton.widthAnchor.constraint(equalToConstant: 361),
            choosePowerButton.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        self.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseButton.heightAnchor.constraint(equalToConstant: 46),
            chooseButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
