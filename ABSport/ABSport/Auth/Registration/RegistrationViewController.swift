//
//  RegistrationViewController.swift
//  ABSport
//
//  Created by Егор Иванов on 29.02.2024.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    let viewModel: RegistrationViewModel?
    private let registationFullView = RegistrationFullView()
    
    init(viewModel: RegistrationViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = registationFullView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registationFullView.onLoginButtonTap = { [weak self] in
            self?.viewModel?.didTapOnLoginButton()
        }
        registationFullView.onSubmitButtonTap = { [weak self] in
            self?.viewModel?.didTapOnSubmitButton()
        }
        
        viewModel?.viewDidLoad()
    }
}
