//
//  ScheduleViewController.swift
//  ABSport
//
//  Created by Александр Бобрун on 21.03.2024.
//

import Foundation
import UIKit
import SwiftUI

class ScheduleViewController<ViewModel: ScheduleViewModel>: UIViewController {
  
    private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = ScheduleView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.didMove(toParent: self)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        hostingController.view.backgroundColor = UIColor(named: "BackgroundColor")
        
        title = "Расписание"
    }
}
