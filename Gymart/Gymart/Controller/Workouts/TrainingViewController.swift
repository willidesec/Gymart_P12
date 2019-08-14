//
//  TrainingViewController.swift
//  Gymart
//
//  Created by William on 14/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {

    var programId: String?
    var workoutId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        setupUI()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Constants.Navigation.trainingTitle
    }
    
    private func setupUI() {
        
    }

}
