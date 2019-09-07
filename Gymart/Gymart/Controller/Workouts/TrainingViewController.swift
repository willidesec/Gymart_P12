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

    let firestoreService = FirestoreService()
    
    var exercices = [Exercice]()
    var historicalExercices = [HistoricalExercice]()
    
    var sectionHeaderHeight: CGFloat = 0.0
    var rowHeight: CGFloat = 0.0
    
    var isTimerRunning = false
    var timer = Timer()
    var counter: Int = 0
    
    var programId: String?
    var workoutId: String?
    
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
        fetchTraining()
    }
    
    // MARK: - IBAction
    
    @IBAction func doneButtonDidTapped() {
        updateWorkoutDate()
        saveTrainingInHistory()
    }
    
    @IBAction func stopwatchButtonDidTapped() {
        
    }
    
    @IBAction func cancelButtonDidTapped() {
        
    }
    
    // MARK: - Methods UI
    
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
    
    // MARK: - Methods Timer
    
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
    
    // MARK: - Methods WebService
    
    private func fetchTraining() {
        guard let programId = programId else { return }
        guard let workoutId = workoutId else { return }
        
        firestoreService.fetchDocumentData(endpoint: .training(programId: programId, workoutId: workoutId)) { document, _ in
            if let workout = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Workout(dictionary: data)
                })
            }) {
                self.workoutNameLabel.text = workout.name
                
                self.exercices = workout.exercicesData.compactMap({Exercice(dictionary: $0)})
                
                self.exercices.forEach { (exercice) in
                    let historicalExercice = HistoricalExercice(name: exercice.name, sets: [ExerciceSet]())
                    self.historicalExercices.append(historicalExercice)
                }
                
                DispatchQueue.main.async {
                    self.trainingTableView.reloadData()
                }
                
            } else {
                print("Document does not exist")
                self.displayAlert(message: Constants.AlertError.serverError)
            }
        }
    }
    
    private func updateWorkoutDate() {
        guard let programId = programId else { return }
        guard let workoutId = workoutId else { return }
        let data = ["lastWorkoutDate": Date()]
        firestoreService.updateDocumentDataInFirestore(endpoint: .training(programId: programId, workoutId: workoutId), data: data) { (error) in
            if let error = error {
                print("Error updating document: \(error)")
                self.displayAlert(message: Constants.AlertError.serverError)
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    private func saveTrainingInHistory() {
        guard let workoutName = workoutNameLabel.text, !workoutName.isEmpty else { return }
        let identifier = UUID().uuidString
        let newHistoricalWorkout = HistoricalWorkout(identifier: identifier, name: workoutName, creationDate: Date(), exercices: historicalExercices)
        
        firestoreService.saveDataInFirestore(endpoint: .historical, identifier: identifier, data: newHistoricalWorkout.dictionary) { (error) in
            if let error = error {
                print("Error adding document: \(error)")
                self.displayAlert(message: Constants.AlertError.serverError)
            } else {
                print("Document added with succes")
                self.navigationController?.popViewController(animated: true)
            }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainingTableViewCell.identifier, for: indexPath) as? TrainingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.toggleSetDelegate = self
        cell.exerciceName = exercices[indexPath.section].name
        cell.numeroOfSet = indexPath.row + 1
        cell.setLabel.text = String(indexPath.row + 1)
        
        return cell
    }
    
}

extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainingHeaderTableViewCell.identifier) as? TrainingHeaderTableViewCell else {
            return UIView()
        }
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

extension TrainingViewController: ToggleSetProtocol {
    func addSetToExercice(set: ExerciceSet, exerciceName: String) {
        var currentIndex = 0
        historicalExercices.forEach { (exercice) in
            if exercice.name == exerciceName {
                historicalExercices[currentIndex].setsData.insert(set.dictionary, at: set.numeroOfSet - 1)
            }
            currentIndex += 1
        }
    }
    
    func deleteSetToExercice(set: ExerciceSet, exerciceName: String) {
        var exerciceIndex = 0
        historicalExercices.forEach { (exercice) in
            if exercice.name == exerciceName {
                var setIndex = 0
                historicalExercices[exerciceIndex].setsData.forEach { (historicalSet) in
                    guard let currentSet = historicalSet["numeroOfSet"] as? Int else { return }
                    if currentSet == set.numeroOfSet {
                        historicalExercices[exerciceIndex].setsData.remove(at: setIndex)
                    }
                    setIndex += 1
                }
            }
            exerciceIndex += 1
        }
    }
}
