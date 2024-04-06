//
//  ChooseTrainerViewController.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 10.03.2024.
//

import UIKit

final class ChooseTrainerViewController: UIViewController {
    
    private let chooseButton = UIButton().configureChooseTrainingButton()
    
    private var collectionView: UICollectionView!
    
    private var selectedCellButtonIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCollectionViewLayouts()
        configureChooseButton()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.dataSource = self
        collectionView.delegate = self
    
        self.navBarTitleStackView.spacing = UIStackView.spacingUseDefault
        self.navigationItem.titleView = navBarTitleStackView
        
        chooseButton.addTarget(self, action: #selector(didTapChooseButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
    }
    
    @objc
    private func didTapChooseButton() {
        //
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 15
        return layout
    }
    
    private let navBarTitleStackView: UIStackView = {
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: "backIconColor")
        titleLabel.text = "Персональные тренировки"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subtitleLabel.textAlignment = .left
        subtitleLabel.textColor = UIColor(named: "backIconColor")
        subtitleLabel.text = "Выбор тренировки"
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
}

// MARK: - CollectionView Data Source
extension ChooseTrainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrainerCell.identifier,
            for: indexPath) as? TrainerCell else {
            return UICollectionViewCell()
        }
        
        cell.configureTrainerCell(trainerPhoto: nil, trainerName: "Алексей Жуков", trainerStatus: "Персональный тренер")

        if indexPath == selectedCellButtonIndexPath {
            cell.cellButton.layer.borderWidth = 2
            cell.cellButton.layer.borderColor = UIColor(named: "GroupTrainers/ButtonColor")?.cgColor
        } else {
            cell.cellButton.layer.borderWidth = 0
        }
        return cell
    }
}

// MARK: - CollectionView Delegate
extension ChooseTrainerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellButtonIndexPath = indexPath
        collectionView.reloadData()
    }
}

// MARK: - CollectionView FlowLayout Delegate
extension ChooseTrainerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthRatio = UIScreen.main.bounds.width / 393
        let heightRatio = UIScreen.main.bounds.height / 852
        
        guard let size = collectionView.cellForItem(
            at: indexPath)?.contentView.frame.size else { return CGSize(
                width: 175 * widthRatio,
                height: 258 * heightRatio)}
        return size
    }
}

// MARK: - Setup CollectionView
private extension ChooseTrainerViewController {
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.register(TrainerCell.self, forCellWithReuseIdentifier: TrainerCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func setupCollectionViewLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15)
        ])
    }
    
    private func configureChooseButton() {
        collectionView.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            chooseButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            chooseButton.heightAnchor.constraint(equalToConstant: 46),
            chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -17)
        ])
    }
}
