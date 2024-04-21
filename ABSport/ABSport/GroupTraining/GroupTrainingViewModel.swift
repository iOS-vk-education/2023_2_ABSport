//
//  GroupTrainingViewModel.swift
//  ABSport
//
//  Created by Arseniy Apollonov on 21.04.2024.
//

import Foundation
import Combine

class GroupTrainingViewModel {
    weak var coordinator: GroupTrainingCoordinator?
    
    let isTrainerChoosePublisher = PassthroughSubject<Bool, Never>()
}
