//
//  LoginModelView.swift
//  ABSport
//
//  Created by Егор Иванов on 10.03.2024.
//
import UIKit

enum LoginViewResult {
    case cancelled
    case data(text: String)
}

protocol LoginModule: AnyObject {
}

protocol LoginViewModel: AnyObject {
    
    func viewDidLoad()
    
}

final class LoginViewModelImpl: LoginViewModel, LoginModule {
    weak var coordinator: AuthCoordinator?
    
    func viewDidLoad() {
    }
}

