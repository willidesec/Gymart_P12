//
//  ProgramViewController.swift
//  Gymart
//
//  Created by William on 16/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProgramViewController: UIViewController {
    
    // MARK: - Properties
    
    var programs = [Program]()
    var db: Firestore!

    // MARK: - IBOutlet
    
    @IBOutlet weak var programTableView: UITableView!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        programs.removeAll()
        programTableView.reloadData()
        fetchPrograms()
    }
    
    // MAARK: - Methods
    
    fileprivate func configureTableView() {
        programTableView.delegate = self
        programTableView.dataSource = self
        programTableView.separatorStyle = .none
    }
    
    private func fetchPrograms() {
        db = Firestore.firestore()
        
        guard let currentUser = AuthService.getCurrentUser() else { return }
        
        let programsCollection = db.collection("users").document(currentUser.uid).collection("programs")
        
        programsCollection.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    guard let name = data["name"] as? String else { return }
                    guard let description = data["description"] as? String else { return }
                    let program = Program(id: document.documentID, name: name, description: description)
                    
                    self.programs.append(program)
                    self.programTableView.reloadData()
                }
            }
            
        }
    }
    
    private func deleteProgramInFirestore(id: String) {
        db = Firestore.firestore()
        
        guard let currentUser = AuthService.getCurrentUser() else { return }
        
        let programsCollection = db.collection("users").document(currentUser.uid).collection("programs")
        
        programsCollection.document(id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath) as? ProgramTableViewCell else { return UITableViewCell() }
        
        cell.program = programs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteProgramInFirestore(id: programs[indexPath.row].id)
            programs.remove(at: indexPath.row)
            programTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Training", bundle:nil)
        guard let workoutsVC = storyBoard.instantiateViewController(withIdentifier: "Workouts") as? WorkoutViewController else { return }
        workoutsVC.programId = programs[indexPath.row].id
        navigationController?.pushViewController(workoutsVC, animated: true)
    }
    
    
}

extension ProgramViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 80
        return heightRow
    }
}
