//
//  SmsModelView.swift
//  ABSport
//
//  Created by Егор Иванов on 13.03.2024.
//

import UIKit

enum SmsViewResult {
    case cancelled
    case data(text: String)
}


protocol SmsViewModel: AnyObject {
    
    func viewDidLoad()
    func didTapOnSubmitButton()
    func didTapOnLoginButton()
}

final class SmsViewModelModelImpl: SmsViewModel {

    

    
    
    func didTapOnLoginButton() {
    }
    weak var coordinator: AuthCoordinator?
    
    func viewDidLoad() {
    }
    func didTapOnSubmitButton() {
    }
}
