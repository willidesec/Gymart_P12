//
//  ProgramViewController.swift
//  Gymart
//
//  Created by William on 16/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {
    
    // MARK: - Properties
    
    var programs = [Program]()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var programTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPrograms()
    }
    
    // MARK: - Methods
    
    fileprivate func configureTableView() {
        programTableView.delegate = self
        programTableView.dataSource = self
        programTableView.separatorStyle = .none
    }
    
    private func fetchPrograms() {
        let firestoreService = FirestoreService<Program>()
        firestoreService.fetchCollection(endpoint: .program) { [weak self] result in
            switch result {
            case .success(let firestorePrograms):
                self?.programs = firestorePrograms
                DispatchQueue.main.async {
                    self?.programTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.displayAlert(message: Constants.AlertError.serverError)
            }
        }
    }
    
    private func deleteProgramInFirestore(identifier: String) {
        let firestoreService = FirestoreService<Program>()
        firestoreService.deleteDocumentData(endpoint: .program, identifier: identifier) { [weak self] result in
            switch result {
            case .success(let successMessage):
                print(successMessage)
            case .failure(let error):
                print("Error deleting document: \(error)")
                self?.displayAlert(message: Constants.AlertError.serverError)
            }
        }
    }
    
}

// MARK: - Extensions

extension ProgramViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgramTableViewCell.identifier, for: indexPath) as? ProgramTableViewCell else {
            return UITableViewCell()
        }
        
        cell.program = programs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteProgramInFirestore(identifier: programs[indexPath.row].identifier)
            programs.remove(at: indexPath.row)
            programTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Training", bundle: nil)
        guard let workoutsVC = storyBoard.instantiateViewController(withIdentifier: WorkoutViewController.identifier) as? WorkoutViewController else { return }
        workoutsVC.programId = programs[indexPath.row].identifier
        navigationController?.pushViewController(workoutsVC, animated: true)
    }
    
}

extension ProgramViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 80
        return heightRow
    }
}
