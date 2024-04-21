//
//  GroupTrainingCoordinator.swift
//  ABSport
//
//  Created by mac on 05.04.2024.
//

import UIKit
import Combine

class GroupTrainingCoordinator: Coordinator {

    var rootViewController: UINavigationController
    
    private var cancellables = Set<AnyCancellable>()
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    lazy var groupTrainingViewController = {

        let viewController = GroupTrainingViewController()

        viewController.navigationItem.backButtonTitle = ""
        return viewController
    }()
    
    func start() {
        let groupTrainingViewModel = GroupTrainingViewModel()
        groupTrainingViewController.viewModel = groupTrainingViewModel
        groupTrainingViewModel.coordinator = self
        
        groupTrainingViewController.chooseTrainerRequested = { [weak self] in self?.goToChooseTrainer(with: groupTrainingViewModel)}
        groupTrainingViewController.chooseTrainingRequested = { [weak self] in self?.goToChooseTraining()}
        groupTrainingViewController.chooseDataRequested = { [weak self] in self?.goToReservation()}
        
        rootViewController.pushViewController(groupTrainingViewController, animated: false)
    }
    
    func goToChooseTrainer(with viewModel: GroupTrainingViewModel) {
        let chooseTrainerViewController = ChooseTrainerViewController()
        let chooseTrainerViewModel = GroupTrainersViewModel()
        chooseTrainerViewController.viewModel = chooseTrainerViewModel
        chooseTrainerViewModel.coordinator = self
        
        // Подписка на обновления из GroupTrainingViewModel
        chooseTrainerViewModel.isTrainerChoosePublisher
            .sink { [weak self] data in
                viewModel.isTrainerChoosePublisher.send(data)
            }
            .store(in: &cancellables)
        
        rootViewController.pushViewController(chooseTrainerViewController, animated: true)
    }
    
    func goToChooseTraining() {
        let chooseTrainingViewController = ChooseTrainingViewController()
        rootViewController.pushViewController(chooseTrainingViewController, animated: true)
    }
    
    func goToReservation() {
        let reservationCoordinator = ReservationCoordinator(rootViewController: rootViewController)
        reservationCoordinator.start()
    }
}
