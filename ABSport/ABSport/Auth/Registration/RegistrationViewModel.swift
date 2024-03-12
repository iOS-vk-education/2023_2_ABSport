//
//  RegistrationViewModel.swift
//  ABSport
//
//  Created by Егор Иванов on 10.03.2024.
//

import UIKit

enum RegistrationViewResult {
    case cancelled
    case data(text: String)
}

protocol RegistrationModule: AnyObject {
    var onFinish: ((RegistrationViewResult) -> Void)? { get set }
}

protocol RegistrationViewModel: AnyObject {
    
    func viewDidLoad()
    func didTapOnLoginButton()
    func didTapOnSubmitButton()
}

final class RegistrationViewModelImpl: RegistrationViewModel, RegistrationModule {
    weak var coordinator: AuthCoordinator?
    
    var onFinish: ((RegistrationViewResult) -> Void)?
    
    func viewDidLoad() {
    }
    
    func didTapOnSendSmsButton(inputText: String?) {
        guard let inputText, !inputText.isEmpty else { return }
    }
    
    func didTapOnSubmitButton() {

    }
    
    func didTapOnLoginButton() {
        coordinator?.showLogin()
    }
}
