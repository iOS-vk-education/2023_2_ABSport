//
//  LoginModelView.swift
//  ABSport
//
//  Created by Егор Иванов on 10.03.2024.
//

import UIKit

protocol LoginViewModelDelegate: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

final class LoginViewModel {
    
    var onFinish: (() -> Void)?
    
    func didTapOnSendSmsButton(inputText: String?) {
        guard let inputText, inputText.isEmpty else { return }
        
    }
}
