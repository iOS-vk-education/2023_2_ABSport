//
//  GroupTrainersViewModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 21.04.2024.
//

import UIKit
import Combine

class GroupTrainersViewModel {
    let isTrainerChoosePublisher = PassthroughSubject<Bool, Never>()
    weak var coordinator: GroupTrainingCoordinator?
    
    func didTapChooseButton() {
        // Получаем данные для передачи
        let data = true
        isTrainerChoosePublisher.send(data)
    }
}
