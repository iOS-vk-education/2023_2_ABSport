//
//  LoginViewController.swift
//  ABSport
//
//  Created by Егор Иванов on 28.03.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - private properties
    weak var viewModel: LoginViewModel?
    private let loginFullView = LoginFullView()
    
    override func loadView() {
        view = loginFullView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        loginFullView.onBackButtonTapped = {
            self.navigationController?.popViewController(animated: false)
        }
    }

}
