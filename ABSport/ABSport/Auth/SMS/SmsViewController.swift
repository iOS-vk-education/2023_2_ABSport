//
//  SmsViewController.swift
//  ABSport
//
//  Created by Егор Иванов on 13.03.2024.
//

import UIKit

final class SmsViewController: UIViewController {
    
    let viewModel: SmsViewModel?
    private let smsFullView = SmsFullView()
    
    init(viewModel: SmsViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = smsFullView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        smsFullView.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        
        viewModel?.viewDidLoad()
    }
}
