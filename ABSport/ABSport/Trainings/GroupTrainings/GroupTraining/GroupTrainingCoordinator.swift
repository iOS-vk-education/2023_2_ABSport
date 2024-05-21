//
//  GroupTrainingCoordinator.swift
//  ABSport
//
//  Created by mac on 05.04.2024.
//

import UIKit

class GroupTrainingCoordinator: Coordinator {

    var rootViewController: UINavigationController
    var viewModel = GroupTrainingViewModel(
        dateFormatterManager: DateFormaterManagerImpl(),
        calendarManager: CalendarManagerImpl())
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    lazy var groupTrainingViewController = {
//        let viewModel = GroupTrainingViewModel()
        viewModel.coordinator = self
        let viewController = GroupTrainingViewController(viewModel: viewModel)
        
        viewController.navigationItem.backButtonTitle = ""
        return viewController
    }()
    
    func start() {
        rootViewController.pushViewController(groupTrainingViewController, animated: true)
    }
    
    func goToChooseTrainer() {
        let chooseTrainerViewController = ChooseGroupTrainerViewController(viewModel: viewModel)
        rootViewController.pushViewController(chooseTrainerViewController, animated: true)
    }
    
    func goToChooseTraining() {
        let chooseTrainingViewController = ChooseGroupTrainingViewController(viewModel: viewModel)
        rootViewController.pushViewController(chooseTrainingViewController, animated: true)
    }
    
    func goToReservation() {

    let reservationCoordinator = ReservationCoordinator(rootViewController: rootViewController, type: .groupTraining)
        reservationCoordinator.reservationViewController.viewModel.groupViewModel = viewModel

        reservationCoordinator.start()
    }
    
    func updateTrainer() {
        groupTrainingViewController.groupTrainingView.chooseTrainingButton.isEnabled = true
        groupTrainingViewController.groupTrainingView.chooseTrainingButton.isHidden = false
        groupTrainingViewController.groupTrainingView.addOKImage(
            to: groupTrainingViewController.groupTrainingView.chooseTrainerButton)
        rootViewController.popViewController(animated: true)
    }
    
    func updateTraining() {
        groupTrainingViewController.groupTrainingView.chooseDateButton.isEnabled = true
        groupTrainingViewController.groupTrainingView.chooseDateButton.isHidden = false
        groupTrainingViewController.groupTrainingView.addOKImage(
            to: groupTrainingViewController.groupTrainingView.chooseTrainingButton)
        rootViewController.popViewController(animated: true)
    }
    
    func updateDate() {
        groupTrainingViewController.chooseButton.isEnabled = true
        groupTrainingViewController.groupTrainingView.addOKImage(
            to: groupTrainingViewController.groupTrainingView.chooseDateButton)
        groupTrainingViewController.chooseButton.backgroundColor = UIColor(
            named: "GroupTrainers/ButtonColor")
        rootViewController.popViewController(animated: true)
    }
    
    func gotoMain() {
        rootViewController.popViewController(animated: true)
    }
}
