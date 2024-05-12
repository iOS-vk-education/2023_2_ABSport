//
//  GroupTrainigView.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 09.03.2024.
//

import UIKit

final class TrainingView: UIView {
    
    var didTapChooseTrainerButton: (() -> Void)?
    var didTapChooseTrainingButton: (() -> Void)?
    var didTapChooseDateButton: (() -> Void)?
    
    lazy var chooseTrainerButton: UIButton = {
        let button = configureChooseButton(imageName: "GroupTrainers/UserMale", title: "Выбрать тренера")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var chooseTrainingButton: UIButton = {
        let button = configureChooseButton(imageName: "GroupTrainers/Shortlist", title: "Выбрать тренировку")
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var chooseDateButton: UIButton = {
        let button = configureChooseButton(imageName: "GroupTrainers/Schedule", title: "Выбрать дату и время")
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "BackgroundColor")
        configureButtons()
        setUpButtonTargets()
//        addOKImage(to: chooseTrainerButton)
//        addOKImage(to: chooseTrainingButton)
//        addOKImage(to: chooseDateButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOKImage(to button: UIButton) {
        let okImage = UIImageView()
        okImage.translatesAutoresizingMaskIntoConstraints = false
        okImage.image = UIImage(named: "GroupTrainers/OK")
        button.addSubview(okImage)
        NSLayoutConstraint.activate([
            okImage.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            okImage.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -16),
            okImage.heightAnchor.constraint(equalToConstant: 32),
            okImage.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setUpButtonTargets() {
        chooseTrainerButton.addTarget(self, action: #selector(didTapTrainerButton), for: .touchUpInside)
        chooseTrainingButton.addTarget(self, action: #selector(didTapTrainingsButton), for: .touchUpInside)
        chooseDateButton.addTarget(self, action: #selector(didTapDateButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapTrainerButton() {
        didTapChooseTrainerButton?()
    }
    
    @objc
    private func didTapTrainingsButton() {
        didTapChooseTrainingButton?()
    }
    
    @objc
    private func didTapDateButton() {
        didTapChooseDateButton?()
    }
    
    private func configureChooseButton(imageName: String?, title: String) -> UIButton {
        
        let button = UIButton()
        let imageView = UIImageView()
        let label = UILabel()
        
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "GroupTrainers/TrainingButtonBackground")
        
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
}
// MARK: - Layouts
private extension TrainingView {
    
    func configureButtons() {
        
        self.addSubview(chooseTrainerButton)
        NSLayoutConstraint.activate([
            chooseTrainerButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            chooseTrainerButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseTrainerButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseTrainerButton.widthAnchor.constraint(equalToConstant: 361),
            chooseTrainerButton.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        self.addSubview(chooseTrainingButton)
        NSLayoutConstraint.activate([
            chooseTrainingButton.topAnchor.constraint(equalTo: chooseTrainerButton.bottomAnchor, constant: 8),
            chooseTrainingButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseTrainingButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseTrainingButton.widthAnchor.constraint(equalToConstant: 361),
            chooseTrainingButton.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        self.addSubview(chooseDateButton)
        NSLayoutConstraint.activate([
            chooseDateButton.topAnchor.constraint(equalTo: chooseTrainingButton.bottomAnchor, constant: 8),
            chooseDateButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseDateButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseDateButton.widthAnchor.constraint(equalToConstant: 361),
            chooseDateButton.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
}
