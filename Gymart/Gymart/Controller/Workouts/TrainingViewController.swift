//
//  TrainingViewController.swift
//  Gymart
//
//  Created by William on 14/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    
    // MARK: - Properties

    var isTimerRunning = false
    var timer = Timer()
    var counter = 0
    var programId: String?
    var workoutId: String?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var doneButton: TrainingActionButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        setupUI()
        launchTimer()
    }
    
    // MARK: - IBAction
    
    @IBAction func doneButtonDidTapped() {
        
    }
    
    @IBAction func stopwatchButtonDidTapped() {
        
    }
    
    
    // MARK: - Methods
    
    private func configureNavigationBar() {
        navigationItem.title = Constants.Navigation.trainingTitle
    }
    
    private func setupUI() {
        doneButton.setTitle("Done", for: .normal)
    }
    
    private func launchTimer() {
        if !isTimerRunning {
            isTimerRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.counter += 1
                
                self.updateTimer()
            })
        }
    }
    
    private func updateTimer() {
        let hour = self.counter / 3600
        
        let minute = (self.counter % 3600) / 60
        var minuteString = "\(minute)"
        if hour >= 1 && minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (self.counter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        if hour < 1 {
            self.timerLabel.text = "\(minuteString):\(secondString)"
        } else {
            self.timerLabel.text = "\(hour):\(minuteString):\(secondString)"
        }
    }

}
