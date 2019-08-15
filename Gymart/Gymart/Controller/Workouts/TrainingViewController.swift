//
//  TrainingViewController.swift
//  Gymart
//
//  Created by William on 14/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import FirebaseFirestore

class TrainingViewController: UIViewController {
    
    // MARK: - Properties

    var exercices = [Exercice]()
    
    var sectionHeaderHeight: CGFloat = 0.0
    var rowHeight: CGFloat = 0.0
    
    var isTimerRunning = false
    var timer = Timer()
    var counter: Int = 0
    
    var programId: String?
    var workoutId: String?
    
    var db: Firestore!
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var doneButton: TrainingActionButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var cancelButton: TrainingActionButton!
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var trainingTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        setupUI()
        launchTimer()
        fetchWorkout()
    }
    
    // MARK: - IBAction
    
    @IBAction func doneButtonDidTapped() {
        
    }
    
    @IBAction func stopwatchButtonDidTapped() {
        
    }
    
    @IBAction func cancelButtonDidTapped() {
        
    }
    
    // MARK: - Methods
    
    private func fetchWorkout() {
        db = Firestore.firestore()
        
        guard let currentUser = AuthService.getCurrentUser() else { return }
        guard let programId = programId else { return }
        guard let workoutId = workoutId else { return }
        
        let workoutDocument = db.document("users/\(currentUser.uid)/programs/\(programId)/workouts/\(workoutId)")
        
        workoutDocument.getDocument { (document, error) in
            if let workout = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Workout(dictionary: data)
                })
            }) {
                self.workoutNameLabel.text = workout.name
                
                let exercicesData = workout.exercicesData.compactMap({Exercice(dictionary: $0)})
                self.exercices = exercicesData
                
                DispatchQueue.main.async {
                    self.trainingTableView.reloadData()
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Constants.Navigation.trainingTitle
    }
    
    private func configureTableView() {
        sectionHeaderHeight = trainingTableView.dequeueReusableCell(withIdentifier: TrainingHeaderTableViewCell.identifier)?.contentView.bounds.height ?? 0
        
        rowHeight = trainingTableView.dequeueReusableCell(withIdentifier: TrainingTableViewCell.identifier)?.contentView.bounds.height ?? 0
    }
    
    private func setupUI() {
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.mainCondensedBoldFont(size: 16)
        
        cancelButton.backgroundColor = UIColor.pastelRed
        cancelButton.setTitle("Cancel workout", for: .normal)
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

// MARK: - Extensions

extension TrainingViewController: UITableViewDataSource {
    
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return exercices.count
    }

    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercices[section].sets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainingTableViewCell.identifier, for: indexPath) as? TrainingTableViewCell else { return UITableViewCell() }
        
        cell.setLabel.text = String(indexPath.row + 1)
        
        return cell
    }
    
}

extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainingHeaderTableViewCell.identifier) as? TrainingHeaderTableViewCell else { return UIView() }
        cell.exercice = exercices[section]
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}
