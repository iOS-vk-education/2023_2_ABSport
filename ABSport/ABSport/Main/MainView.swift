//
//  MainView.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 28.02.2024.
//

import UIKit

final class MainView: UIView {
    
    lazy var sectionButton: UIButton = {
        let button = configureButton(imageName: "SectionImage", title: "Статьи")
        return button
    }()
    
    lazy var lectionButton: UIButton = {
        let button = configureButton(imageName: "LectionImage", title: "Лекции и подкасты")
        return button
    }()
    
    lazy var coffeeRideButton: UIButton = {
        let button = configureButton(imageName: "CoffeeRideImage", title: "Кофе-райды")
        return button
    }()
    
    lazy var laundryButton: UIButton = {
        let button = configureButton(imageName: "LaundryImage", title: "Стирка / сушка белья")
        return button
    }()
    
    lazy var bikeStorageButton: UIButton = {
        let button = configureButton(imageName: "BikeStorageImage", title: "Хранение велосипеда")
        return button
    }()
    
    lazy var massageButton: UIButton = {
        let button = configureButton(imageName: "MassageImage", title: "Онлайн-запись на массаж")
        return button
    }()
    
    lazy var nutritionButton: UIButton = {
        let button = configureButton(imageName: "NutritionImage", title: "Нутрициолог")
        return button
    }()
    
    lazy var bookingRecoveryButton: UIButton = {
        let button = configureButton(imageName: "RecoveryImage", title: "Бронь восстановления")
        return button
    }()
    
    lazy var bioimpedanceButton: UIButton = {
        let button = configureButton(imageName: "BioimpedanceImage", title: "Биоимпеданс")
        return button
    }()
    
    lazy var bookingMachinesButton: UIButton = {
        let button = configureButton(imageName: "BookingMachinesImage", title: "Бронь станков")
        return button
    }()
    
    lazy var personalTrainingButton: UIButton = {
        let button = configureButton(imageName: "PesonalTrainigImage", title: "Персональные тренировки")
        return button
    }()
    
    lazy var groupTrainigButton: UIButton = {
        let button = configureButton(imageName: "GroupTrainigImage", title: "Групповые тренировки")
        return button
    }()
    
    lazy var joinClubButton: UIButton = {
        let button = configureButton(imageName: "JoinClubImage", title: "Вступить в клуб")
        return button
    }()
    
    private lazy var sportTitleLabel: UILabel = {
        var label = self.configureTitleLabel(title: "Спорт")
        return label
    }()
    
    private lazy var beautyTitleLabel: UILabel = {
        var label = self.configureTitleLabel(title: "Бьюти")
        return label
    }()
    
    private lazy var otherTitleLabel: UILabel = {
        var label = self.configureTitleLabel(title: "Прочее")
        return label
    }()
    
    private let logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ABSportLogoImage") ?? nil
        return imageView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "BackgroundColor")
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        setUpScrollView()
        setUpContentView()
        setUpLogoImage()
        
        setUpSportTitleLabel()
        setUpBookingMachinesButton()
        setUpPersonalTrainingButton()
        setUpGroupTrainingButton()
        setUpJoinClubButton()
        
        setUpBeautyTitleLabel()
        setUpMassageButton()
        setUpNutritionButton()
        setUpBookingRecoveryButton()
        setUpBioimpedanceButton()
        
        setUpOtherTitleLabel()
        setUpBikeStorageButton()
        setUpLaundryButton()
        setUpCoffeeRideButton()
        setUpLectionButton()
        setUpSectionButton()
        
    }
    
    private func configureButton(imageName: String?, title: String) -> UIButton {
        let button = UIButton()
        let imageView = UIImageView()
        let label = UILabel()
        
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 12
        
        let viewWidth = UIScreen.main.bounds.width
        let ratio = viewWidth / 393
        label.font = UIFont.systemFont(ofSize: CGFloat(20 * ratio), weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = title
        label.textAlignment = .left
        
        imageView.image = UIImage(named: imageName ?? "")
        
        imageView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 9),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -9),
            label.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0)
        ])
        
        button.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor),
            imageView.rightAnchor.constraint(equalTo: button.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: button.leftAnchor)
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
private extension MainView {
    
    func setUpScrollView() {
        self.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setUpContentView() {
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setUpLogoImage() {
        contentView.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 58),
            logoImageView.widthAnchor.constraint(equalToConstant: 92)
            
        ])
    }
    
    func setUpSportTitleLabel() {
        contentView.addSubview(sportTitleLabel)
        NSLayoutConstraint.activate([
            sportTitleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            sportTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            sportTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func setUpBookingMachinesButton() {
        contentView.addSubview(bookingMachinesButton)
        NSLayoutConstraint.activate([
            bookingMachinesButton.topAnchor.constraint(equalTo: sportTitleLabel.bottomAnchor, constant: 14),
            bookingMachinesButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            bookingMachinesButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            bookingMachinesButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 190/759)
        ])
    }
    
    func setUpPersonalTrainingButton() {
        contentView.addSubview(personalTrainingButton)
        NSLayoutConstraint.activate([
            personalTrainingButton.topAnchor.constraint(equalTo: sportTitleLabel.bottomAnchor, constant: 14),
            personalTrainingButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -23),
            personalTrainingButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            personalTrainingButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 130/759)
        ])
    }
    
    func setUpGroupTrainingButton() {
        contentView.addSubview(groupTrainigButton)
        NSLayoutConstraint.activate([
            groupTrainigButton.topAnchor.constraint(equalTo: bookingMachinesButton.bottomAnchor, constant: 6),
            groupTrainigButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            groupTrainigButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            groupTrainigButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 110/759)
        ])
    }
    
    func setUpJoinClubButton() {
        contentView.addSubview(joinClubButton)
        NSLayoutConstraint.activate([
            joinClubButton.topAnchor.constraint(equalTo: personalTrainingButton.bottomAnchor, constant: 6),
            joinClubButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -23),
            joinClubButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            joinClubButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 170/759)
        ])
    }
    
    func setUpBeautyTitleLabel() {
        contentView.addSubview(beautyTitleLabel)
        NSLayoutConstraint.activate([
            beautyTitleLabel.topAnchor.constraint(equalTo: groupTrainigButton.bottomAnchor, constant: 55),
            beautyTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23)
        ])
    }
    
    func setUpMassageButton() {
        contentView.addSubview(massageButton)
        NSLayoutConstraint.activate([
            massageButton.topAnchor.constraint(equalTo: beautyTitleLabel.bottomAnchor, constant: 14),
            massageButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            massageButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            massageButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 170/759)
        ])
    }
    
    func setUpNutritionButton() {
        contentView.addSubview(nutritionButton)
        NSLayoutConstraint.activate([
            nutritionButton.topAnchor.constraint(equalTo: beautyTitleLabel.bottomAnchor, constant: 14),
            nutritionButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -23),
            nutritionButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            nutritionButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 110/759)
        ])
    }
    
    func setUpBookingRecoveryButton() {
        contentView.addSubview(bookingRecoveryButton)
        NSLayoutConstraint.activate([
            bookingRecoveryButton.topAnchor.constraint(equalTo: massageButton.bottomAnchor, constant: 6),
            bookingRecoveryButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            bookingRecoveryButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            bookingRecoveryButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 130/759)
        ])
    }
    
    func setUpBioimpedanceButton() {
        contentView.addSubview(bioimpedanceButton)
        NSLayoutConstraint.activate([
            bioimpedanceButton.topAnchor.constraint(equalTo: nutritionButton.bottomAnchor, constant: 6),
            bioimpedanceButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -23),
            bioimpedanceButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            bioimpedanceButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 190/759)
        ])
    }
    
    func setUpOtherTitleLabel() {
        contentView.addSubview(otherTitleLabel)
        NSLayoutConstraint.activate([
            otherTitleLabel.topAnchor.constraint(equalTo: bioimpedanceButton.bottomAnchor, constant: 55),
            otherTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23)
        ])
    }
    
    func setUpBikeStorageButton() {
        contentView.addSubview(bikeStorageButton)
        NSLayoutConstraint.activate([
            bikeStorageButton.topAnchor.constraint(equalTo: otherTitleLabel.bottomAnchor, constant: 14),
            bikeStorageButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            bikeStorageButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            bikeStorageButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 164/759)
        ])
    }
    
    func setUpLaundryButton() {
        contentView.addSubview(laundryButton)
        NSLayoutConstraint.activate([
            laundryButton.topAnchor.constraint(equalTo: otherTitleLabel.bottomAnchor, constant: 14),
            laundryButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -23),
            laundryButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            laundryButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 113.43/759)
        ])
    }
    
    func setUpCoffeeRideButton() {
        contentView.addSubview(coffeeRideButton)
        NSLayoutConstraint.activate([
            coffeeRideButton.topAnchor.constraint(equalTo: bikeStorageButton.bottomAnchor, constant: 6),
            coffeeRideButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            coffeeRideButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            coffeeRideButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 95.98/759)
        ])
    }
    
    func setUpLectionButton() {
        contentView.addSubview(lectionButton)
        NSLayoutConstraint.activate([
            lectionButton.topAnchor.constraint(equalTo: laundryButton.bottomAnchor, constant: 6),
            lectionButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -23),
            lectionButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 170/393),
            lectionButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 146/759)
        ])
    }
    
    func setUpSectionButton() {
        contentView.addSubview(sectionButton)
        NSLayoutConstraint.activate([
            sectionButton.topAnchor.constraint(equalTo: lectionButton.bottomAnchor, constant: 6),
            sectionButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -23),
            sectionButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23),
            sectionButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 106/759),
            sectionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}
