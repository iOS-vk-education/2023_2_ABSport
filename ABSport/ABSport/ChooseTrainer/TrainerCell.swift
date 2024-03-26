//
//  TrainerCell.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 11.03.2024.
//

import UIKit

final class TrainerCell: UICollectionViewCell {
    
    static let identifier = "TrainerCellIdentifier"
    
    private let widthRatio = UIScreen.main.bounds.width / 393
    private let heightRatio = UIScreen.main.bounds.height / 852
    
    lazy var cellButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "TrainerButtonBackgroud")
        button.layer.cornerRadius = 12
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    private let trainerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(named: "TrainerPhotoBackground")
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let trainerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: CGFloat(15), weight: .semibold)
        label.textColor = UIColor(named: "TrainingText")
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let trainerStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: CGFloat(13), weight: .light)
        label.textColor = UIColor(named: "TrainerStatusColor")
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTrainerCell(trainerPhoto: UIImage?, trainerName: String?, trainerStatus: String?) {
        trainerImage.image = trainerPhoto ?? UIImage(named: "Alex")
        trainerNameLabel.text = trainerName
        trainerStatusLabel.text = trainerStatus
    }

    private func setup() {
        self.addSubview(cellButton)
        self.clipsToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            cellButton.topAnchor.constraint(equalTo: self.topAnchor),
            cellButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            cellButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellButton.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        cellButton.addSubview(trainerImage)
        NSLayoutConstraint.activate([
            trainerImage.leftAnchor.constraint(equalTo: cellButton.leftAnchor, constant: 11 * widthRatio),
            trainerImage.topAnchor.constraint(equalTo: cellButton.topAnchor, constant: 11 * widthRatio),
            trainerImage.rightAnchor.constraint(equalTo: cellButton.rightAnchor, constant: -11 * widthRatio)
        ])
  
        cellButton.addSubview(trainerNameLabel)
        NSLayoutConstraint.activate([
            trainerNameLabel.topAnchor.constraint(equalTo: trainerImage.bottomAnchor, constant: 18 * widthRatio),
            trainerNameLabel.leftAnchor.constraint(equalTo: cellButton.leftAnchor, constant: 11 * widthRatio),
            trainerNameLabel.rightAnchor.constraint(equalTo: cellButton.rightAnchor, constant: -11 * widthRatio),
            trainerNameLabel.widthAnchor.constraint(equalToConstant: (153) * widthRatio)
        ])

        cellButton.addSubview(trainerStatusLabel)
        NSLayoutConstraint.activate([
            trainerStatusLabel.topAnchor.constraint(equalTo: trainerNameLabel.bottomAnchor, constant: 2),
            trainerStatusLabel.leftAnchor.constraint(equalTo: cellButton.leftAnchor, constant: 11 * widthRatio),
            trainerStatusLabel.rightAnchor.constraint(equalTo: cellButton.rightAnchor, constant: -11 * widthRatio),
            trainerStatusLabel.bottomAnchor.constraint(equalTo: cellButton.bottomAnchor, constant: -11 * widthRatio)
        ])
    }
}
